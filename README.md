# Project Grader
This is a simple project grader shell script. It is made to emulate the grading done for projects in the Data Structures and Algorithms class I took (CS201 at the University of Alabama).

## Features
- Adjustable runtime check by giving the program a certain amount of time to run. 
- Compiles files into an executable using a makefile (using "make") then checks that the makefile compiles properly and the executable is named correctly.
- Customizable parameters via `grading_config.ini` or command line.
- Grades by giving an adjustable amount of points for a successful compile, then each line is worth an equal amount of the remaining points.
- Shows expected output, actual output, and the differences between the two. This can ignore whitespace differences, if desired.
- The script can run multiple times in succession to adjust to code, makefile, expected output changes, or parameter changes.
- The script can clean any files it generated on its most recent run.

## Notes
- **Make sure your correct grading file has a new line at the end**
- If you want to run the script using `$ ./scriptname.sh` instead of `$ bash scriptname.sh` you can use: `$ chmod +x scriptname.sh`
- To use the config.ini make a file called: `grading_config.ini` then type your parameters in a single line in this order: `$compiledname $argv $outputfile $gradingfile $timelimit $compilepoints $whitespace`
- After downloading the script, you can rename it however you would like.
- This script requires `timeout` which is included in [coreutils](https://www.gnu.org/software/coreutils/).
- This script as of right now does not check for "correct" parameters or other issues such as having the wrong grading file. This can cause some unexpected behavior if you do not use the script correctly.
- I highly recommend making test files that manage printing for you. (ex: the turned in portion returns some variable while the file for grading manages all printing and formatting)
- You can find an example of `GradingScript.sh` and `grading_config.ini` [here](/src/example).

## Usage
1. After downloading the scripts place the script in a directory, then navigate to that directory in a bash terminal.
2. Place your makefile and project file(s) in the same directory as the script.
3. Place your grading file (text file with correct output) in the same directory as the script.
4. Run the script using `$ bash scriptname.sh` (Example usage: `$ bash GradingScript.sh`)
    1. If you set up a grading_config.ini file it will read that.
    2. If you did not set up an ini file, you can enter your parameters through the command line.
5. The script should output the results in the terminal.

## [Changelog (click to open)](CHANGELOG.md)
