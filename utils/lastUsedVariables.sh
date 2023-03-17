#!/bin/bash
#
#
#This file is used to store get and set functions of last used variables
#All the LAST_saved variables are store in savedData folder
#
# imports
current_bash_file_s_folder_path=$(dirname  "$0")
source "$current_bash_file_s_folder_path/globalVariables.sh" #importing globalVariables
source "$utils_path/lib.sh" #importing basic functions

#---------------------------------------------------------------

# common functions
#
setUpSavedDataFolder(){
    # used to set up saved data folder if it do not exist.
    # every setter function should call this to ensure that the folder in which they are going to save data exists.
    isFolderExists $savedData_path
    if [ $? == 1 ];then
        mkdir $savedData_path
    fi
}

#-----------------------------------------------
#getter and setter for LAST_USED_SOURCECODE_FILE_PATH

setSavedValueOfLAST_USED_SOURCECODE_FILE_PATH () {
# 1) if $savedData folder_path do not exist then create it and
# 2) save the last source code file path at $variable_LAST_USED_SOURCECODE_FILE_PATH_path
# saved means its saved on non volatile memory
# $1 is path of source code file
    setUpSavedDataFolder
    LAST_USED_SOURCECODE_FILE_PATH=$1
    echo $LAST_USED_SOURCECODE_FILE_PATH > $variable_LAST_USED_SOURCECODE_FILE_PATH_path

}
getSavedValueOfLAST_USED_SOURCECODE_FILE_PATH () {
# return 1 at error, along with a message
# returns  0 at success, and loads the variable
#	the variable should be exported from parent process.
#	so that the script can modify it.
	isFileExists $variable_LAST_USED_SOURCECODE_FILE_PATH_path
	if [ $? == 1 ];then
		echo "$variable_LAST_USED_SOURCECODE_FILE_PATH_path File Do Not Exist"
		return 1
    else
        LAST_USED_SOURCECODE_FILE_PATH=$(cat $variable_LAST_USED_SOURCECODE_FILE_PATH_path)
		return 0
	fi

}

#-----------------------------------------------------
#getter and setter for LAST_USED_BINARY_FILE_PATH

setSavedValueOfLAST_USED_BINARY_FILE_PATH () {
# 1) if $savedData folder_path do not exist then create it and
# 2) save the last source code file path at $variable_LAST_USED_BINARY_FILE_PATH_path
# saved means its saved on non volatile memory
# $1 is path of source code file
    setUpSavedDataFolder
    LAST_USED_BINARY_FILE_PATH=$1
    echo $LAST_USED_BINARY_FILE_PATH > $variable_LAST_USED_BINARY_FILE_PATH_path

}
getSavedValueOfLAST_USED_BINARY_FILE_PATH () {
# return 1 at error, along with a message
# returns  0 at success, and loads the variable
#	the variable should be exported from parent process.
#	so that the script can modify it.

	isFileExists $variable_LAST_USED_BINARY_FILE_PATH_path
	if [ $? == 1 ];then
		echo "$variable_LAST_USED_BINARY_FILE_PATH_path File Do Not Exist"
		return 1
	elif [ $? == 0 ];then
		$LAST_USED_BINARY_FILE_PATH=$(cat $variable_LAST_USED_BINARY_FILE_PATH_path)
		return 0
	fi

}


