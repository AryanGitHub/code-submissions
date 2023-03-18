#!/bin/bash

current_bash_file_s_folder_path=$(dirname  "$0")
source "$current_bash_file_s_folder_path/globalVariables.sh" #importing globalVariables
source "$utils_path/lib.sh" #importing basic functions
source "$utils_path/lastUsedVariables.sh" # importing the LAST_USED_VARIABLES

# main function --------------------

# $1 is path of the binary file, [OPTIONAL], can use LAST_USED_BINARY_FILE variable.

if [ $# == 0 ];then
    message=<. getSavedValueOfLAST_USED_BINARY_FILE_PATH
    if [ $? == 1 ];then
        echo "$message"
        exit
    elif [ "$LAST_USED_BINARY_FILE_PATH" == 'NONE' ];then
        echo 'NO LAST BINARY FILE PATH USED'
        exit
    else
        binary_file_path="$LAST_USED_BINARY_FILE_PATH"
    fi
else 
    binary_file_path="$1"
    setSavedValueOfLAST_USED_BINARY_FILE_PATH "$1"
fi

isFileExists "$binary_file_path"

if [ $? == 0 ]; then
    extension="$(getExtension "$binary_file_path")"

    if [ "$extension" == 'out' ];then
        "$utils_path/debug_cpp.sh" "$binary_file_path"

    elif [ "$extension" == 'class' ];then  #java bytecode
        ./debug_java.sh "(not made)" "$binary_file_path"

    else
        echo "Cannot understand the extension of the file ""$1"
    fi
else
    echo "File do not exist."
fi

