#!/bin/bash
usage() { echo "Usage: $0 [-l <looping>] [-d <directory>]" 1>&2; exit 1; }

play_file() 
{
	echo "play_file $1" #debug
	sleep 1 #debug
    #omxplayer --blank "$1" 1>/dev/null 2>/dev/null
}

## parse the arguments
while getopts ":l:d:" o; do
    case "${o}" in
        l)
            LOOPING=${OPTARG}
            ;;
        d)
            DIRECTORY=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))


## Set state if no argument is provided
if [ -z "${LOOPING}" ];then;LOOPING=0;fi
if [ -z "${DIRECTORY}" ];then;DIRECTORY="/home/pi/videos";fi


## if Looping infinite loop else dont.
if [ $LOOPING == 1  ];then

	while true; do
		for entry in $DIRECTORY/*
		do
			play_file $entry
		done
	done  #infinit loop? 

else
	for entry in $DIRECTORY/*
	do
		play_file $entry
	done
	echo "this is the end"
fi
