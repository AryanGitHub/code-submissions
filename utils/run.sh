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
setUpBinFolder(){
    
    isFolderExists $bin_path
    if [ $? == 1 ];then
        mkdir $bin_path
    fi
        
    isFolderExists $leetcode_bin_path
    if [ $? == 1 ];then
        mkdir $leetcode_bin_path
    fi
    
    isFolderExists $cf_bin_path
    if [ $? == 1 ];then
        mkdir $cf_bin_path
    fi
    
    isFolderExists $others_bin_path
    if [ $? == 1 ];then
        mkdir $others_bin_path
    fi
}

getBinaryFilePath(){
    setUpBinFolder
    
    cointains "leetcode" $1
    if [ $? == 0 ];then
        source_code_bin_file_folder="$leetcode_bin_path/$(getFilename $1)"

        isFolderExists $source_code_bin_file_folder
        if [ $? == 1 ];then
            mkdir $source_code_bin_file_folder
        fi

        echo "$source_code_bin_file_folder/a.out" #this has to be versioned 
    fi

}
#main function-----------------------

#variable initilisaions
code_submissions_path="$(pwd)"
utils_path="$code_submissions_path/utils"
bin_path="$code_submissions_path/bin"
leetcode_bin_path="$bin_path/leetcode"
cf_bin_path="$bin_path/cf"
others_bin_path="$bin_path/others"

source_code_path=$1

binary_file_path=$(getBinaryFilePath $source_code_path)
echo $binary_file_path

isFileExists $source_code_path

if [ $? == 0 ]; then
    extension="$(getExtension $1)"

    if [ $extension == 'cpp' ];then
        $utils_path/run_cpp.sh "$binary_file_path" "$1"
    elif [ $extension == 'java' ];then
        ./run_java $1
    else
        echo "Cannot understand the extension of the file "$1
    fi
else
    echo "File do not exist."
fi

