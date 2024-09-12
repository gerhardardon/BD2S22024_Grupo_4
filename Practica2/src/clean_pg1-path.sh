#!/bin/bash

# Directorio a limpiar
dir="pg1-path"

# Verificar si el directorio existe, si no, crearlo
if [ ! -d "$dir" ]; then
    echo "El directorio $dir no existe. Creando..."
    mkdir -p "$dir"
else
    echo "Limpiando el directorio: $dir"
    rm -rf "$dir"/*
fi

echo "Limpieza y/o creación de $dir completada."
