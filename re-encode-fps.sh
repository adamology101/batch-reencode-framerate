#!/bin/bash

# Source and destination directories
source_dir="/Users/me/input_folder"
destination_dir="/Users/me/export_folder"

# Ensure the destination directory exists
mkdir -p "$destination_dir"

# Iterate through files in the source directory
for input_file in "$source_dir"/*.mov "$source_dir"/*.mp4; do
    if [ -f "$input_file" ]; then
        # Extract filename and extension
        filename=$(basename "$input_file")
        extension="${filename##*.}"
        filename_noext="${filename%.*}"

        # Output file path in the destination directory
        output_file="$destination_dir/$filename"

        # FFmpeg command to change frame rate (-r value) by re-encoding 
        # High quality prores file exported
        ffmpeg -i "$input_file" -r 24 -c:v prores_ks -profile:v 3 -preset veryslow -crf 17 -c:a copy -vtag avc1 "$output_file"

        # Check FFmpeg's exit status
        if [ $? -eq 0 ]; then
            echo "Encoded: $filename"
        else
            echo "Error encoding: $filename"
        fi
    fi
done

echo "Encoding complete."
