#!/bin/bash

# Removes BOM characters from file
#
# $1 is the input file to clean
# $2 is the clean output file

sed 's/\xEF\xBB\xBF//g' $1 > $2
