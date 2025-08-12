#!/bin/bash

set -e

CWD="$(pwd)"
DATA_DIR="$CWD/data"


echo "======================================"
echo "   maps4FS Data Preparation Startup   "
echo "======================================"
echo "Current working directory: $CWD"
echo "--------------------------------------"

# Create data directory
if [ ! -d "$DATA_DIR" ]; then
    echo "Creating data directory at $DATA_DIR"
    mkdir "$DATA_DIR"
else
    echo "Data directory already exists at $DATA_DIR"
    echo "All content will be removed from existing data directory."
    rm -rf "$DATA_DIR/*"
    echo "Cleared existing content in data directory."
fi

echo "--------------------------------------"

# Find all directories starting with "fs" in cwd
for DIR in "$CWD"/fs*/; do
    [ -d "$DIR" ] || continue
    BASENAME=$(basename "$DIR")
    echo "--- Processing directory: $BASENAME"

    # Copy all files (not directories) from DIR to data directory
    for FILE in "$DIR"*; do
        if [ -f "$FILE" ]; then
            echo "Copying file $(basename "$FILE") to data directory"
            cp "$FILE" "$DATA_DIR/"
        fi
    done
    echo "Copied files from $BASENAME directory"
    echo "--------------------------------------"

    # Iterate over subdirectories
    for SUBDIR in "$DIR"*/; do
        [ -d "$SUBDIR" ] || continue
        SUBBASENAME=$(basename "$SUBDIR")
        ZIPFILE="$DATA_DIR/${SUBBASENAME}.zip"
        echo "Packing contents of $SUBBASENAME into $ZIPFILE"
        (cd "$SUBDIR" && zip -r "$ZIPFILE" .)
        # Move the zip file to data directory
        mv "$SUBDIR/$SUBBASENAME.zip" "$DATA_DIR/" 2>/dev/null || true
    done
    echo "--------------------------------------"
    echo "Packed subdirectories from $BASENAME directory"
    echo "------ Directory $BASENAME processed. -----"
    echo "--------------------------------------"
done
echo "Data preparation complete."
echo "======================================"