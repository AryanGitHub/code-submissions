 #!/bin/bash
 

 #this script basic work is to debig the cpp file in the tui mode
 #no file existance checking.
 # $1 is path of the file
 #using gdb debugger 
 
 gdb "$1" -tui -ex "break main"
