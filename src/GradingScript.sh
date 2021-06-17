#! /bin/sh

# clean all files made by the grader
clean_files(){
    if [ -e "$outputfile" ]
    then
        rm "$outputfile"
    fi
    if [ -e "$filename" ]
    then
        rm "$filename"
    fi
}

restart_helper(){
    echo "Would you like to run the grader again?"
    echo "Type either Y to run again, N to stop, YY to run again with different inputs, NN to stop and clean files"
    echo "followed by [ENTER]"
    read -r option
    if [ "$option" = "Y" ]
    then 
        grading=true
    elif [ "$option" = "YY" ]
    then
        grading=true
        get_input
    elif [ "$option" = "NN" ]
    then
        grading=false
        clean_files
    else
        grading=false
    fi
}

get_input(){
    echo "Type the filename of the final compiled program (ex: a.out), followed by [ENTER]:"
    read -r fname
    echo "Type any run time arguments (argv arguments), followed by [ENTER]:"
    read -r args
    echo "Type what you want your output file to be named (ex: output.out), followed by [ENTER]:"
    read -r ofile
    echo "Type the filename of your grading file (ex: correct.out), followed by [ENTER]:"
    read -r gfile
    echo "Type the time limit in seconds (ex: 5), followed by [ENTER]:"
    read -r tlimit
    echo "Type the number of points for a successful compilation (0-100), followed by [ENTER]:"
    read -r cpoints
    echo "Do you want to ignore whitespace?"
    echo "Type true or false, followed by [ENTER]:"
    read -r ws
}

grade() {
    filename=$1
    argv=$2
    outputfile=$3 
    gradingfile=$4 
    timelimit=$5
    compilepoints=$6 
    ignore_whitespace=$7
    compiled=0
    earnedpoints=0
    grade=0.00
    echo "-------------------------"
    echo "Grading"
    echo "-------------------------"
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
            timeout "$timelimit"s ./"$filename" "$argv" > "$outputfile"
            timeout_status=$?
            echo "Running: ./$filename $argv > $outputfile"
            if [ $timeout_status -eq 124 ]
            then
                echo "Runtime exceeded"
                grade=$earnedpoints
            else
                if [ "$ignore_whitespace" = "true" ]
                then
                    incorrect=$(diff -w -y --suppress-common-lines "$outputfile" "$gradingfile" | wc -l | tr -d '[:space:]')
                else
                    incorrect=$(diff -y --suppress-common-lines "$outputfile" "$gradingfile" | wc -l | tr -d '[:space:]')
                fi
                total=$(wc -l < "$gradingfile" | tr -d '[:space:]')
                correct=$((total - incorrect))
                if [ "$correct" -eq "$total" ]
                then
                    echo "Your output is correct ($correct/$total)"
                else
                    incorrect=$((total - correct))
                    if [ "$incorrect" -ge "$total" ]
                    then
                        incorrect=$total
                    fi
                    echo "Your output is not correct, you missed $incorrect out of $total"
                    echo "--------------------"
                    echo "Expected output"
                    cat "$gradingfile"
                    echo "--------------------"
                    echo "Your output"
                    cat "$outputfile"
                    echo "--------------------"
                    echo "Your differences"
                    if [ "$ignore_whitespace" = "true" ]
                    then
                        diff -w "$outputfile" "$gradingfile"
                    else
                        diff "$outputfile" "$gradingfile"
                    fi
                fi
                grade=$(echo "scale=2; $correct / $total * (100 - $earnedpoints) + $earnedpoints" | bc)
            fi
    fi 
echo "-------------------------"
printf "final grade: %.2f\n" "$grade"
echo "-------------------------"
}

grading=true
config_file="grading_config.ini"
if [ -e "$config_file" ] # check for a config file
then
    echo "Reading from $config_file:"
    while read -r fname args ofile gfile tlimit cpoints ws; do
        echo "$fname:$args:$ofile:$gfile:$tlimit:$cpoints:$ws"
    done < "grading_config.ini"
    echo "$fname $args $ofile $gfile $tlimit $cpoints $ws"
else
    get_input
fi
while [ $grading = true ]
do
    grade "$fname" "$args" "$ofile" "$gfile" "$tlimit" "$cpoints" "$ws"
    restart_helper
done