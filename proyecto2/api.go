package proyecto2

import (
	"context"
	"database/sql"
	"encoding/json"
	"fmt"
	"github.com/gorilla/mux"
	_ "github.com/jackc/pgx/v4/stdlib"
	"github.com/joho/godotenv"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"log"
	"net/http"
	"os"
)

// Estructura para representar los datos que vamos a transferir
type Item struct {
	ID     int    `json:"id"`
	Name   string `json:"name"`
	Gender string `json:"gender"`
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

// Configuración de la conexión a MongoDB
func connectMongo() (*mongo.Client, error) {
	clientOptions := options.Client().ApplyURI("mongodb://localhost:27017")
	client, err := mongo.Connect(context.Background(), clientOptions)
	if err != nil {
		return nil, err
	}
	// Verificar la conexión
	err = client.Ping(context.Background(), nil)
	if err != nil {
		return nil, err
	}
	return client, nil
}

// Función para transferir datos de PostgreSQL a MongoDB
func transferData(w http.ResponseWriter, r *http.Request) {
	// Conectar a PostgreSQL
	postgresDB, err := connectPostgres()
	if err != nil {
		http.Error(w, "Error al conectar a PostgreSQL", http.StatusInternalServerError)
		return
	}
	defer postgresDB.Close()

	// Conectar a MongoDB
	mongoClient, err := connectMongo()
	if err != nil {
		http.Error(w, "Error al conectar a MongoDB", http.StatusInternalServerError)
		return
	}
	defer mongoClient.Disconnect(context.Background())

	// Obtener el nombre del esquema desde las variables de entorno
	schema := os.Getenv("POSTGRES_SCHEMA")
	if schema == "" {
		schema = "public" // Por defecto, usar el esquema "public" si no se especifica
	}

	// Seleccionar base de datos y colección de MongoDB
	collection := mongoClient.Database("proyecto2").Collection("artistas")

	// Consultar los datos en PostgreSQL utilizando el esquema
	query := fmt.Sprintf("SELECT id, name, gender FROM %s.artist", schema)
	rows, err := postgresDB.Query(query)
	if err != nil {
		http.Error(w, "Error al consultar en PostgreSQL", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	// Recorrer las filas y transferir a MongoDB
	for rows.Next() {
		var item Item
		if err := rows.Scan(&item.ID, &item.Name, &item.Gender); err != nil {
			http.Error(w, "Error al leer fila de PostgreSQL", http.StatusInternalServerError)
			return
		}

		// Insertar el elemento en MongoDB
		_, err = collection.InsertOne(context.Background(), bson.M{
			"id":     item.ID,
			"nombre": item.Name,
			"genero": item.Gender,
		})
		if err != nil {
			http.Error(w, "Error al insertar en MongoDB", http.StatusInternalServerError)
			return
		}
	}

	// Devolver respuesta de éxito
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(map[string]string{"message": "Datos transferidos exitosamente"})
}

func main() {
	// Crear un enrutador con Gorilla Mux
	r := mux.NewRouter()
	r.HandleFunc("/transfer", transferData).Methods("POST")

	// Iniciar el servidor
	fmt.Println("Servidor escuchando en el puerto 8080")
	log.Fatal(http.ListenAndServe(":8080", r))
}
