#!/bin/bash
#compile or run root c++ files

export ROOTSYS=/cern/root/
export PATH=$ROOTSYS/bin:$PATH
export LD_LIBRARY_PATH=$ROOTSYS/lib:$LD_LIBRARY_PATH
export DISPLAY=0

#try to compile if only one file is given per default
RUN=""
CFILE=$1
BINARY="${CFILE%.*}.out"
USAGE=false

while [[ $# > 0 ]]
do
    key="$1"
    case $key in
            -r|--run)
            [ -e "$2" ] && RUN="$2" || echo "file $2 not found";
            shift
            ;;
            -c|--compile)
            [ -e "$2" ] && CFILE="$2" || echo "file $2 not found";
            BINARY="${CFILE%.*}.out"
            shift
            ;;
            -o|--output)
            BINARY="$2"
            shift
            ;;
            -h|--help)
            USAGE=true
            ;;
            *)
            ;;
    esac
    shift
done 

if [ "$USAGE" == "true" ] || [ "$CFILE" == "" ]; then
    echo "Usage:"
    echo "-r file.out";
    echo "  file.out = executable to run";
    echo "";
    echo "-c cfile.cc [-o file.out]";
    echo "  file.cc = root-file to compile";
    echo "  file.out = executable to save (optional, default is cfile.out)";
    echo "";
    exit 1;

    exec ./$2
    exit

elif [ -e "$RUN" ]; then 

    exec ./$RUN
    exit 1;

elif [ -e "$CFILE" ]; then 

    echo "performing: g++ -o $BINARY $CFILE -I /gnu/gsl/include"
    g++ -o "$BINARY" "$CFILE" -I /gnu/gsl && echo "done" || echo "error"

elif [ "$CFILE" == "bash" ]; then
    
    exec bash
    sleep

else
    
    echo "file $CFILE not found."
    exit 1;
fi

