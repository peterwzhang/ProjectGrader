# Project Grader
This is a simple project grader shell script. It is made to emulate the grading done in my Data Structures and Algorithm class.

## Features
- Adjustable runtime check by giving the program a certain amount of time to run. 
- Compiles files into an executable using a makefile (using "make") then checks that the makefile compiles properly and the executable is named correctly.
- Customizable parameters via file change (lines 2-8) or command line.
- Grades by giving an adjustable amount of points for a successful compile, then each line is worth an equal amount of the remaining points.
- Shows expected output, actual output, and the differences between the two. This can ignore whitespace differences, if desired.

## Notes
- **As of 4/16/21, "GradingScriptNT.sh" and "GradingScriptNTP.sh" are no longer maintained.**
- **Make sure your correct grading file has a new line at the end**
- After downloading the scripts, you can remain them however you would like.
- There are currently two main versions: "GradingScript.sh" and "GradingScriptP.sh".
- "GradingScript.sh" requires you to edit lines 2-8 to edit the parameters (Better for testing repeatedly).
- "GradingScriptP.sh" will ask you for each parameter via the command line, so no file changes are required.
- The two main versions require "timeout" which is included in [coreutils](https://www.gnu.org/software/coreutils/).
- "GradingScriptNT.sh" and "GradingScriptNTP.sh" do not use timeout.
- This script as of right now does not check for "correct" parameters or other issues such as having the wrong grading file. This can cause some unexpected behavior if you do not use the script correctly.
- You can find an example of "GradingScript.sh" [here](https://github.com/PeterTheAmazingAsian/ProjectGrader/tree/master/src/example).

## Usage
1. After downloading the scripts place one (or all) in a directory, then navigate to that directory in a terminal.
2. Place your makefile and project file(s) in the same directory as the script.
3. Place your grading file (text file with correct output) in the same directory as the script.
    1. If you are using "GradingScript.sh" or "GradingScriptNT.sh" you need to edit the first lines 2-7 to change the parameters.
    2. If you are using "GradingScriptP.sh" or "GradingScriptNTP.sh" it will ask you for parameters everytime you run the file.
4. Run the script using bash scriptname.sh 
    1. Example usage: bash GradingScript.sh
    2. If you ran "GradingScriptP.sh" or "GradingScriptNTP.sh" it will ask you to put in parameters before it runs, follow the prompts in the terminal.
5. The script should output the results in the terminal.

## [Changelog (click to open)]()