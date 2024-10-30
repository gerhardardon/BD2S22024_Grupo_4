package main

import (
	"context"
	"database/sql"
	"encoding/json"
	"fmt"

	"log"
	"net/http"
	"os"

	"github.com/gorilla/mux"
	_ "github.com/jackc/pgx/v5/stdlib" // Si usas el controlador pgx para PostgreSQL
	"github.com/joho/godotenv"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

type artist struct {
	Name      sql.NullString
	Birth     sql.NullInt64
	AreaBirth sql.NullString
	Biography sql.NullString
}

type album struct {
	Name     sql.NullString
	Language sql.NullString
	Version  sql.NullString
}

type label struct {
	Name sql.NullString
}

// Función para cargar variables de entorno desde el archivo .env
func loadEnv() {
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error al cargar el archivo .env")
	}
}

// Configuración de la conexión a PostgreSQL utilizando variables de entorno
func connectPostgres() (*sql.DB, error) {
	loadEnv()

	// Obtener valores de las variables de entorno
	user := os.Getenv("POSTGRES_USER")
	password := os.Getenv("POSTGRES_PASSWORD")
	dbName := os.Getenv("POSTGRES_DB")
	host := os.Getenv("POSTGRES_HOST")
	port := os.Getenv("POSTGRES_PORT")

	// Construir la cadena de conexión
	connStr := fmt.Sprintf("postgres://%s:%s@%s:%s/%s?sslmode=disable", user, password, host, port, dbName)
	return sql.Open("pgx", connStr)
}

// Función para conectar a MongoDB
func connectMongo() (*mongo.Client, *mongo.Collection, error) {
	// Configuración de opciones de cliente de MongoDB
	clientOptions := options.Client().ApplyURI("mongodb://localhost:27017")

	// Conectar a MongoDB
	client, err := mongo.Connect(context.Background(), clientOptions)
	if err != nil {
		return nil, nil, err
	}

	// Verificar la conexión
	err = client.Ping(context.Background(), nil)
	if err != nil {
		return nil, nil, err
	}

	// Definir y retornar la colección que se utilizará
	collection := client.Database("proyectoFase2").Collection("artistas")
	return client, collection, nil
}

func migrarDatos(w http.ResponseWriter, r *http.Request, db *sql.DB, collection *mongo.Collection) {
	// Consulta principal
	query := "SELECT a.name FROM musicbrainz_old.artist a"
	rows, err := db.Query(query)
	if err != nil {
		http.Error(w, "Error consultando en PostgreSQL", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	// Iterar sobre los resultados
	for rows.Next() {
		var nombre sql.NullString
		var nombre2 string
		if err := rows.Scan(&nombre); err != nil {
			if err == sql.ErrNoRows {
				log.Printf("Artista %s no encontrado", nombre)
			}
			log.Println("Error al escanear nombre:", err)
			continue
		}

		if nombre.Valid {
			nombre2 = nombre.String
		} else {
			continue
		}
		// Obtener información adicional
		albumes, err := obtenerAlbumesPorArtista(nombre2, w, db)
		if err != nil {
			log.Printf("Error obteniendo álbumes para %s: %v", nombre, err)
			continue
		}

		canciones, err := obtenerCancionesPorArtista(nombre2, w, db)
		if err != nil {
			log.Printf("Error obteniendo canciones para %s: %v", nombre, err)
			continue
		}

		disqueras, err := obtenerDisquerasPorArtista(nombre2, w, db)
		if err != nil {
			log.Printf("Error obteniendo disqueras para %s: %v", nombre, err)
			continue
		}

		artistaInfo, err := obtenerInformacionArtista(nombre2, w, db)
		if err != nil {
			log.Printf("Error obteniendo información del artista %s: %v", nombre, err)
			continue
		}

		// Agregar los atributos adicionales al objeto artistaInfo
		artistaInfo["Albumes"] = albumes
		artistaInfo["Canciones"] = canciones
		artistaInfo["Disqueras"] = disqueras

		// Insertar el documento en MongoDB
		_, err = collection.InsertOne(context.TODO(), artistaInfo)
		if err != nil {
			log.Printf("Error insertando en MongoDB para el artista %s: %v", nombre, err)
			continue
		}

	}

	// Enviar respuesta de éxito
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]string{"mensaje": "Datos migrados exitosamente"})
}

// Función para obtener álbumes por nombre de artista
func obtenerAlbumesPorArtista(nombre string, w http.ResponseWriter, db *sql.DB) ([]bson.M, error) {
	// Definir la consulta SQL con el nombre como parámetro
	query := `
		SELECT DISTINCT ON (r.name)
            r.name AS nombre_album, 
            l.name AS lenguaje, 
            r.comment AS version
        FROM 
            musicbrainz_old.artist a
            LEFT JOIN musicbrainz_old.release r ON r.artist_credit = a.id
            LEFT JOIN musicbrainz_old.language l ON r.language = l.id
            LEFT JOIN musicbrainz_old.release_alias ra ON r.id = ra.release
        WHERE 
            a.name = $1
        ORDER BY 
            r.name, r.id;`

	// Ejecutar la consulta utilizando la variable 'nombre' como parámetro
	rows, err := db.Query(query, nombre)
	if err != nil {
		http.Error(w, "Error querying postgres", http.StatusInternalServerError)
		return nil, fmt.Errorf("error querying postgres: %v", err)
	}
	defer rows.Close()

	// Crear el slice para almacenar los álbumes
	var albumes []bson.M

	// Iterar sobre los resultados de la consulta
	for rows.Next() {
		var album1 album
		if err := rows.Scan(&album1.Name, &album1.Language, &album1.Version); err != nil {
			if err == sql.ErrNoRows {
				log.Printf("album %s no encontrado", nombre)
			}
			http.Error(w, "Error al leer fila de PostgreSQL", http.StatusInternalServerError)
			return nil, fmt.Errorf("error al leer fila de PostgreSQL: %v", err)
		}

		// Crear el objeto BSON y hacer append al slice albumes
		album2 := bson.M{
			"Nombre":   album1.Name.String,
			"Lenguaje": album1.Language.String,
			"Version":  album1.Version.String,
		}
		albumes = append(albumes, album2)
	}

	// Retornar el slice de álbumes
	return albumes, nil
}

// Función para obtener canciones por nombre de artista
func obtenerCancionesPorArtista(nombre string, w http.ResponseWriter, db *sql.DB) ([]bson.M, error) {
	// Definir la consulta SQL con el nombre como parámetro
	query := `
		SELECT 
			t.name AS nombre,
			MIN(t.length) AS duracion
		FROM 
			musicbrainz_old.track t
			JOIN musicbrainz_old.artist a ON t.artist_credit = a.id
		WHERE
			a.name = $1
		GROUP BY 
			t.name;`

	// Ejecutar la consulta utilizando la variable 'nombre' como parámetro
	rows, err := db.Query(query, nombre)
	if err != nil {
		http.Error(w, "Error querying postgres", http.StatusInternalServerError)
		return nil, fmt.Errorf("error querying postgres: %v", err)
	}
	defer rows.Close()

	// Crear el slice para almacenar las canciones
	var canciones []bson.M

	for rows.Next() {
		var lengthMillis sql.NullInt64
		var trackName sql.NullString
		var formattedDuration string
		if err := rows.Scan(&trackName, &lengthMillis); err != nil {
			if err == sql.ErrNoRows {
				log.Printf("track %s no encontrado", nombre)
			}
			http.Error(w, "Error al leer fila de PostgreSQL", http.StatusInternalServerError)
			return nil, fmt.Errorf("error al leer fila de PostgreSQL: %v", err)
		}

		if lengthMillis.Valid {
			// Convertir 'lengthMillis' a minutos y segundos
			seconds := lengthMillis.Int64 / 1000 // Convertir milisegundos a segundos
			minutes := seconds / 60              // Calcular los minutos completos
			remainingSeconds := seconds % 60     // Calcular los segundos restantes
			formattedDuration = fmt.Sprintf("%02d:%02d", minutes, remainingSeconds)
		} else {
			formattedDuration = fmt.Sprintf("%02d:%02d", 0, 0)
		}

		// Crear el objeto BSON y hacer append al slice canciones
		cancion := bson.M{
			"Nombre":   trackName.String,
			"Duracion": formattedDuration,
		}
		canciones = append(canciones, cancion)
	}

	// Retornar el slice de canciones
	return canciones, nil
}

// Función para obtener disqueras por nombre de artista
func obtenerDisquerasPorArtista(nombre string, w http.ResponseWriter, db *sql.DB) ([]bson.M, error) {
	// Definir la consulta SQL con el nombre como parámetro
	query := `
		 SELECT DISTINCT
			lb.name AS disquera
		FROM 
			musicbrainz_old.artist a
			LEFT JOIN musicbrainz_old.release r ON r.artist_credit = a.id
			LEFT JOIN musicbrainz_old.language l ON r.language = l.id
			LEFT JOIN musicbrainz_old.release_alias ra ON r.id = ra.release
			LEFT JOIN musicbrainz_old.release_label rl ON r.id = rl.release
			LEFT JOIN musicbrainz_old.label_alias lb ON rl.label = lb.label
		WHERE 
			a.name = $1;`

	// Ejecutar la consulta utilizando la variable 'nombre' como parámetro
	rows, err := db.Query(query, nombre)
	if err != nil {
		http.Error(w, "Error querying postgres", http.StatusInternalServerError)
		return nil, fmt.Errorf("error querying postgres: %v", err)
	}
	defer rows.Close()

	// Crear el slice para almacenar las disqueras
	var disqueras []bson.M

	for rows.Next() {
		var disquera label
		if err := rows.Scan(&disquera.Name); err != nil {
			if err == sql.ErrNoRows {
				log.Printf("disquera %s no encontrado", nombre)
			}
			http.Error(w, "Error al leer fila de PostgreSQL", http.StatusInternalServerError)
			return nil, fmt.Errorf("error al leer fila de PostgreSQL: %v", err)
		}

		// Crear el objeto BSON y hacer append al slice disqueras
		disquera2 := bson.M{
			"Nombre": disquera.Name.String,
		}
		disqueras = append(disqueras, disquera2)
	}

	// Retornar el slice de disqueras
	return disqueras, nil
}

// Función para obtener información específica del artista por nombre
func obtenerInformacionArtista(nombre string, w http.ResponseWriter, db *sql.DB) (bson.M, error) {
	query := `
		SELECT
			a.name AS nombre,
			a.begin_date_year AS anio_nacimimento,
			ar.name AS lugar_nacimiento,
			a.type AS tipo_artista,
			a.gender AS genero,
			a.ended AS estatus,
			a.comment AS biografia
		FROM
			musicbrainz_old.artist a
			LEFT JOIN musicbrainz_old.area ar ON a.area = ar.id
		WHERE 
			a.name = $1;`

	// Ejecutar la consulta utilizando la conexión proporcionada
	row := db.QueryRow(query, nombre)

	var artista artist
	var tipo, genero sql.NullInt64
	var estatus sql.NullBool
	var tipo2, genero2 int64
	var tipo3, genero3, estatus3 string
	var estatus2 bool

	// Escanear los valores de la fila devuelta
	if err := row.Scan(&artista.Name, &artista.Birth, &artista.AreaBirth, &tipo, &genero, &estatus, &artista.Biography); err != nil {
		if err == sql.ErrNoRows {
			log.Printf("Artista %s no encontrado", nombre)
		}
		return nil, fmt.Errorf("error al obtener información del artista: %v", err)
	}

	if tipo.Valid {
		tipo2 = tipo.Int64
		tipo3 = "desconocido"
		if tipo2 == 1 {
			tipo3 = "solista"
		} else if tipo2 == 2 {
			tipo3 = "grupo"
		}
	} else {
		// Asignar un valor por defecto o manejar el caso nulo
		tipo3 = "no aplica"
	}

	if genero.Valid {
		genero2 = genero.Int64
		genero3 = "No aplica"
		if genero2 == 1 {
			genero3 = "Masculino"
		} else if genero2 == 2 {
			genero3 = "Femenino"
		}
	} else {
		// Asignar un valor por defecto o manejar el caso nulo
		genero3 = "No aplica"
	}

	if estatus.Valid {
		estatus2 = estatus.Bool
		estatus3 = "No aplica"
		if estatus2 == false {
			estatus3 = "Activo"
		} else if estatus2 == true {
			estatus3 = "Retirado"
		}
	} else {
		// Asignar un valor por defecto o manejar el caso nulo
		estatus3 = "No aplica"
	}

	// Crear un objeto BSON para el documento del artista
	artista1 := bson.M{
		"Nombre":              artista.Name.String,
		"Fecha de Nacimiento": artista.Birth.Int64,
		"Pais":                artista.AreaBirth.String,
		"Tipo":                tipo3,
		"Genero":              genero3,
		"Biografia":           artista.Biography.String,
		"Estatus":             estatus3,
	}

	return artista1, nil
}

func main() {
	// Cargar variables de entorno
	loadEnv()

	// Conectar a la base de datos PostgreSQL
	db, err := connectPostgres()
	if err != nil {
		log.Fatal("Error al conectar a PostgreSQL:", err)
	}
	defer db.Close()

	// Conectar a MongoDB
	mongoClient, collection, err := connectMongo()
	if err != nil {
		log.Fatal("Error al conectar a MongoDB:", err)
	}
	defer mongoClient.Disconnect(context.TODO())

	// Configurar el router
	r := mux.NewRouter()

	// Pasar las conexiones de MongoDB y PostgreSQL a las funciones de manejo de rutas
	r.HandleFunc("/migrar", func(w http.ResponseWriter, r *http.Request) {
		migrarDatos(w, r, db, collection)
	}).Methods("GET")

	// Iniciar el servidor
	port := os.Getenv("PORT")
	if port == "" {
		port = "5001"
	}
	log.Printf("Servidor escuchando en el puerto %s", port)
	err = http.ListenAndServe(":"+port, r)
	if err != nil {
		return
	}
}
