#!/bin/bash

mkdir -p results
echo 'Hello Bioinformatic World!' > results/output.txt

tr '[:lower:]' '[:upper:]' < results/output.txt > results/uppercase_output.txt
