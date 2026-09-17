#!/bin/bash
#
# script.sh - Busca una palabra/frase dentro de todos los archivos de una
#             carpeta (de forma recursiva) e imprime la ruta de cada archivo
#             junto con la frecuencia de aparición de la palabra.
#
# Uso:
#   ./script.sh "palabra o frase" /ruta/a/la/carpeta

# =============================================================
# MÓDULO 1: Validación de Entrada (Integrante 1)
# =============================================================
validar_argumentos() {
    if [ "$#" -ne 2 ]; then
        echo "Uso incorrecto." >&2
        echo "Uso: $0 \"palabra_o_frase\" /ruta/a/carpeta" >&2
        exit 1
    fi

    local ruta="$2"
    if [ ! -d "$ruta" ]; then
        echo "Error: la ruta '$ruta' no existe o no es un directorio válido." >&2
        exit 1
    fi
}

# =============================================================
# MÓDULO 2: Motor de Búsqueda (Integrante 2)
# =============================================================
buscar_archivos() {
    local palabra="$1"
    local ruta="$2"

    grep -rlI --fixed-strings -- "$palabra" "$ruta" 2>/dev/null
}

# =============================================================
# MÓDULO 3: Formato y Conteo de Ocurrencias (Integrante 3)
# =============================================================
contar_y_formatear_ocurrencias() {
    local palabra="$1"
    local total_archivos=0
    local total_ocurrencias=0

    echo "=================================================="
    echo " Resultados de búsqueda para: \"$palabra\""
    echo "=================================================="

    while IFS= read -r archivo; do
        [ -z "$archivo" ] && continue

        local frecuencia
        frecuencia=$(grep -o --fixed-strings -- "$palabra" "$archivo" 2>/dev/null | wc -l)

        printf "Archivo: %s\n" "$archivo"
        printf "  Ocurrencias: %d\n" "$frecuencia"
        echo "--------------------------------------------------"

        total_archivos=$((total_archivos + 1))
        total_ocurrencias=$((total_ocurrencias + frecuencia))
    done

    echo "=================================================="
    echo " Archivos con coincidencias: $total_archivos"
    echo " Total de ocurrencias:       $total_ocurrencias"
    echo "=================================================="

    if [ "$total_archivos" -eq 0 ]; then
        echo "No se encontraron archivos que contengan \"$palabra\"."
    fi
}

# =============================================================
# FLUJO PRINCIPAL
# =============================================================
main() {
    validar_argumentos "$@"

    local palabra="$1"
    local ruta="$2"

    buscar_archivos "$palabra" "$ruta" | contar_y_formatear_ocurrencias "$palabra"
}

main "$@"
