#!/bin/bash -e
# simplified from https://github.com/ljishen/BSFD
if [ "$#" -lt 2 ]; then
    cat <<-ENDOFMESSAGE
Please specify at least the output file, the test name and command.
Usage: ./run.sh <output file> --test=<test-name> [options]... <command>

You can use "./run.sh <output file> help" (without --test) to display the brief usage summary and the list of available test modes.

Examples:
# Run CPU performance test
./run.sh output.prof --test=cpu --cpu-max-prime=20000 run

# Run File I/O test
./run.sh output.prof --test=fileio --file-num=64 prepare
./run.sh output.prof --test=fileio --file-num=64 --file-test-mode=seqrewr run
./run.sh output.prof --test=fileio cleanup

# Print help message
./run.sh output.prof help
ENDOFMESSAGE
    exit
fi

out_file="$1"
if [[ "$1" != /* ]]; then
    out_file="../$1"
fi

mkdir -p $(dirname "$1") workdir
cd workdir && sysbench "${@:2}" | tee "$out_file" 

# Navigate back to the original path in case people call this script using "source" command.
cd ..
