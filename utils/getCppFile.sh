#!/bin/bash

current_bash_file_s_folder_path=$(dirname  "$0")
source "$current_bash_file_s_folder_path/globalVariables.sh" #importing globalVariables
source "$utils_path/lib.sh" #importing basic functions
setUpSavedDataFolder(){
    isFolderExists $savedData_path
    if [ $? == 1 ];then
        mkdir $savedData_path
    fi
}
copyLayout(){
    # $1 is path of layout 
    # $2 is path of the destination source file
    
    # returns 1 on error with message
    # returns 0 on success

    layoutFile=$1
    sourceFile=$2
    
    isFileExists "$layoutFile"
    if [ $? == 0 ]; then
        isFileExists "$sourceFile"
        if [ $? == 0 ];then
            echo "$sourceFile file already exist, can't overwite."
            setSavedValueOfLAST_USED_SOURCECODE_FILE_PATH $sourceFile
            return 1
        else
            cat $layoutFile > $sourceFile
            setSavedValueOfLAST_USED_SOURCECODE_FILE_PATH $sourceFile 
            return 0
        fi
    else 
        echo "$layoutFile layout file does not exist."
        return 1
    fi

}

setSavedValueOfLAST_USED_SOURCECODE_FILE_PATH () {
# 1) if $savedData folder_path do not exist then create it and
# 2) save the last source code file path at $variable_LAST_USED_SOURCECODE_FILE_PATH_path
# saved means its saved on non volatile memory
# $1 is path of source code file
    setUpSavedDataFolder
    LAST_USED_SOURCECODE_FILE_PATH=$1
    echo $LAST_USED_SOURCECODE_FILE_PATH > $variable_LAST_USED_SOURCECODE_FILE_PATH_path

}

#main function ------------------

    # $1 is which cpp layout, leetcode, cf, others
    # $2 is name of the file
if [ $# -eq 2 ]; then
        if [ $1 == 'leetcode' ];then
            layoutFile="$layouts_path/leetcode/basicCppLayout.cpp"
            srcFilePath="$leetcode_src_path/$2.cpp"
            #TODO add elif of cf and others
        else 
            layoutFile="$layout_path/basicCppLayout.cpp"
            srcFilePath="$others_src_path/$2.cpp"
        fi

        message=$(copyLayout $layoutFile $srcFilePath)
        if [ $? == 0 ];then
            $EDITOR $srcFilePath
        elif [ $? == 1 ];then
            echo $message
        fi

else
    echo "Provide 2 arguments, <type of layout> <file_name>"
fi

