#!/bin/bash

if [ $# -gt 2 ]; then
    echo "Error: exceso de parametros"
    exit 1
fi

if [ $# -lt 2 ]; then
    echo "Error: faltan parametros"
    exit 1
fi
