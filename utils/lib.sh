#!/bin/bash
cointains (){
    if [[ $2 =~ $1 ]]; then
        return 0
    else
        return 1
    fi
}
isFileExists (){
    if test -f "$1"; then
        return 0
    else 
        return 1
    fi
}

isFolderExists (){
    if test -d "$1"; then
        return 0
    else 
        return 1
    fi
}

getFilename (){
#using as told here https://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash
    local filename=$(basename -- "$1")
    local filename="${filename%.*}"

    echo $filename
}

getExtension (){
#using as told here https://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash
    local filename=$(basename -- "$1")
    local extension="${filename##*.}"
    local filename="${filename%.*}"

    echo $extension
}
