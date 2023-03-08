 #!/bin/bash
 
 #its basic work is to compile and run the cpp file
 #no file existance checking.
 
 #using g++ compiler
 
 g++ -g -pedantic-errors -Wall -Weffc++ -Wextra -Wsign-conversion -std=c++17 -o $1 $2
