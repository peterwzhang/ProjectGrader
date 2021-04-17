#! /bin/sh
filename="" #put name of compiled file here
argv="" #put your argv parameters here
outputfile="" #put name of the outputfile here
gradingfile="" #put name of file with correct output here
timelimit=5 #set time limit in seconds here
compilepoints=15 #change the points for an successful compilation here
ignore_whitespace="Y" #put "Y" to ignore whitespace, put "N" to grade white space
#don't change below this line unless you know what you are doing
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
            if [ "$ignore_whitespace" = "Y" ]
            then
                incorrect=$(diff -w -y --suppress-common-lines "$outputfile" "$gradingfile" | wc -l | tr -d '[:space:]')
            else
                incorrect=$(diff -y --suppress-common-lines "$outputfile" "$gradingfile" | wc -l | tr -d '[:space:]')
            fi
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
                if [ "$ignore_whitespace" = "Y" ]
                then
                    diff -w "$outputfile" "$gradingfile"
                else
                    diff "$outputfile" "$gradingfile"
                fi
            fi
            grade=$(echo "scale=10; $correct / $total * $((100 - earnedpoints)) + $earnedpoints" | bc)
        fi
fi 
echo "-------------------------"
printf "Final grade: %.2f\n" "$grade"
echo "-------------------------"