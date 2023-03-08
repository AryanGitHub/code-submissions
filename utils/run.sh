#!/bin/bash
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


current_bash_file_s_folder_path=$(dirname  "$0")
source "$current_bash_file_s_folder_path/globalVariables.sh" #importing globalVariables
source "$utils_path/lib.sh" #importing basic functions

source_code_path=$1

binary_file_path=$(getBinaryFilePath $source_code_path)

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

