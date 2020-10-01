#!/bin/bash
FILES="$@"
for i in $FILES
do
echo "Processing $i ..."

filename=$(basename "$i")
extension="${filename##*.}"
filename="${filename%.*}"

`npm bin`/decktape remark --chrome-arg=--allow-file-access-from-files $i $filename.pdf
done
