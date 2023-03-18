This repo this for storing my code submissions for online events.

### **User Manual** 
There are 3 main commands as of now

> * getCppFile.sh To make cpp file at the required position also open it with the $EDITOR.
> * run.sh To compiler and run the file with appropriate flags (EXTENSION_LESS(do not need to tell the type of the file, it will understand by the extension provided.)) 
> * debug.sh To debug the file using gdb TUI mode.

#### **For getCppFile.sh**

**SYNOPSIS**
    getCppFile.sh leetcode <Question ID>
    getCppFile.sh <any other category> <name of the file>
    
----

    
#### **For run.sh**
**SYNOPSIS**
    run.sh (runs the last edited file!)
    run.sh <path of the source code file>
**DESCRIPTION**
it saves the binary file in the bin folder, under the type of file (cf | leetcode | others)
eg. bin/leetcode/443/a.out

----

#### **For debug.sh**
**SYNOPSIS**
    debug.sh (debug the last compiled or debugged binary file!)
    debug.sh <path of the source code file>
**DESCRIPTION**
it opens gdb with tui mode and breakpoint "main function" of the file path passed or it will take it from LAST_USED_BINARY_FILE_PATH.
also sets LAST_USED_BINARY_FILE_PATH to the current debug file.
eg. bin/leetcode/443/a.out

----

**The programming languages I am using are**
* ~~Python~~ (I am learning currently)
* ~~Java~~
* C/Cpp

**Text Editor/IDEs**
* neovim (I will post my vim script too for this, and will try to make it minimal)
* maybe VSVode? idk



**Folders Struct**
* leetcode (contains [leetcode](https://leetcode.com/) submissions)
* cf (contains [codeforces](https://codeforces.com/) submissions)
* DSA practice maybe
* others (contains other than these)
* utils (the bash scripts I am using to get templates, compile, and debug)
* bin (to store binaries, will be under gitignore, but important for running compilation)


Some global variables I will use will update later.

I don't know how successful it will be, but I am planning to somehow record the time I required for thinking, writing, and debugging each solution, using some bash scripts.

**Todo**
- [ ] Build a naming convention for both cf and leetcode
    - [x] for leetcode
        - [x] including binary files convention
    - [ ] for cf
        - [ ] including binary files convention
- [ ] get basic compilation scripts for each lang respectively
    - [x] for cpp
    - [ ] java
    - [ ] python 
- [ ] get basic template build script for each lang
    - [x] for cpp
        - [x] leetcode
        - [ ] cf
        - [x] others basic
    - [ ] java
    - [ ] python 
- [ ] the template should include the URL for the problem, timestamps (later), and other attributes like, did I see the solution before coding , number of compilations, and what other important links are there for this solution, notes.
- [ ] go extensionless for compiling and generating scripts
    - [x] for compilation 
    - [ ] for layout generation
    - [x] for debugging
- [ ] bash script for scoring habit tracking points!
- [ ] maybe if I continue with this, a way to store test cases and test them automatically 

Todo for compilation script cpp
As I m using cpp the most rn its easier to start with that only
- [ ] include fsanitise=address
- [x] storing binary files
- [ ] add debug script too
    - [x] at least gdb one
