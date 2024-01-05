#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Error: Usage: $0 <full_path_to_file> <text_to_write>"
    exit 1
fi

# Get the file path and text from command-line arguments
writefile="$1"
writestr="$2"

# Check if the provided file path and text are specified
if [ -z "$writefile" ] || [ -z "$writestr" ]; then
    echo "Error: Both file path and text to write must be specified"
    exit 1
fi

# Extract the directory path from the file path
dir_path=$(dirname "$writefile")

# Create the directory if it doesn't exist
mkdir -p "$dir_path"

# Create the file with the specified content
echo "$writestr" > "$writefile"

# Check if the file creation was successful
if [ $? -ne 0 ]; then
    echo "Error: Unable to create or write to the file '$writefile'"
    exit 1
fi

# Print success message
echo "File '$writefile' created successfully with content: '$writestr'"

# Exit with success
exit 0
