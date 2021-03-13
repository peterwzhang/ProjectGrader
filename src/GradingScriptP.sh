#! /bin/sh
# this version prompts for all variables required to run.
echo "Type the filename of the final compiled program (ex: a.out), followed by [ENTER]:"
read -r filename
echo "Type any run time arguments (argv arguments), followed by [ENTER]:"
read -r argv
echo "Type what you want your output file to be named (ex: output.out), followed by [ENTER]:"
read -r outputfile
echo "Type the filename of your grading file (ex: correct.out), followed by [ENTER]:"
read -r gradingfile
echo "Type the time limit in seconds (ex: 5), followed by [ENTER]:"
read -r timelimit
echo "Type the number of points for a successful compilation, followed by [ENTER]:"
read -r compilepoints
compiled=0 
earnedpoints=0
if make # test if the make file works
then
    if [ -e "$filename" ] # test if make file properly makes executable
    then
        compiled=1
        echo "Project builds correctly. (+$compilepoints points)"
        earnedpoints=$((earnedpoints + compilepoints))
    else
        echo "Project does not compile."
    fi
else
    echo "Makefile problem"
fi
if [ $compiled -eq 1 ]
    then 
        if [ -e "$outputfile" ]
        then 
            rm "$outputfile" # remove previous outputfiles if they exist
        fi
        timeout "$timelimit"s ./"$filename" "$argv" > "$outputfile"
        timeout_status=$?
        echo "Running: ./$filename $argv > $outputfile"
        if [ $timeout_status -eq 124 ]
        then 
        echo "Runtime exceeded"
        grade=$earnedpoints
        else 
            incorrect=$(diff -y --suppress-common-lines "$outputfile" "$gradingfile" | wc -l | tr -d '[:space:]')
            total=$(wc -l < "$gradingfile" | tr -d '[:space:]')
            if [ "$incorrect" -eq 0 ]
            then 
                correct=$total
                echo "Your output is correct ($correct/$total)"
            else
                correct=$((total - incorrect))
                echo "Your output is not correct, you missed $incorrect out of $total"
                echo "--------------------"
                echo "Expected output"
                cat "$gradingfile"
                echo "--------------------"
                echo "Your output"
                cat "$outputfile"
                echo "--------------------"
                echo "Your differences"
                diff "$outputfile" "$gradingfile"
            fi
            grade=$(echo "scale=10; $correct / $total * $((100 - earnedpoints)) + $earnedpoints" | bc)
        fi
fi 
echo "-------------------------"
printf "Final grade: %.2f\n" "$grade"
echo "-------------------------"