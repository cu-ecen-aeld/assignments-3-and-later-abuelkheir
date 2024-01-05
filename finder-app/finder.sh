#!/bin/bash

# Check for providing the right number of entries
if [ "$#" -ne 2 ]; then
    echo "Files and strings were not specified"
    exit 1 
fi

# Get directory path and string 
filesdir="$1"
searchstr="$2"

if [ ! -d "$filesdir" ]; then
    echo "Error: Directory '$filesdir' not found"
    exit 1 
fi

# Count the number of files
file_paths=$(find "$filesdir" -type f)
num_files=$(echo "$file_paths" | wc -l)

# Count the number of matching lines
matching_lines=$(grep -r "$searchstr" "$filesdir")
num_matches=$(echo "$matching_lines" | wc -l)

# Print the result
echo "The number of files are $num_files and the number of matching lines are $num_matches"

# Exit with success
exit 0
