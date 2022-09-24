#!/bin/sh

#Check the options provided by the user.
#Run the program only if all the options are provided
set -a
while getopts :N:M:a:c:o: opt
do
    case "$opt" in
            N) name=$OPTARG;;
            M) mail=$OPTARG;;
            a) module=$OPTARG;;
            o) outputF=$OPTARG;;
            *)  echo
                echo Provide correct options:
                    echo "-N job name"
                    echo "-a module name"
                    echo "-o output file"
                    echo "-M mail ID (optional)" 
                    echo "Followed by command"
                    echo
                exit;;
        esac
done
#Position
nn=$OPTIND
#set the position to original
shift $[ $OPTIND - 1 ]

#get the command
command=$*
if [ -n "$command" ]
then
    if [ -n $name ]  && [ -n "$module" ] && [ -n "$outputF" ] && [ $nn -gt 6 ]
    then
        #submit the job to the queue
        if [ -n "$mail" ] 
        then
            qsub -N $name -M $mail -o "$outputF" -V ./runJob.sh
        else
            qsub -N $name -o "$outputF" -V ./runJob.sh
        fi

    elif [ -z $name ] || [ -z "$module" ] || [ $nn -gt 1 ] && [ $nn -lt 7 ]
    then
        echo
        echo Missing options.......
        echo Use the available options given below;
            echo "-N job_name"
            echo "-a module name" 
            echo "-o output file"
            echo "-M mail ID (optional)"
            echo "Followed by command"
            echo
        exit
    fi
else 
    echo
    echo
    echo Command to run is Missing
    echo
    echo ..........Terminated...................
    echo
    exit
fi
