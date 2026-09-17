

palabra=$1
archivo=$2

if [ ! -f "$archivo" ]; then
    echo "Error: el archivo no existe"
    exit 1
fi

