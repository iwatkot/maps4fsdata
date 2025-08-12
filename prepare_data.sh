#!/bin/bash

set -e

CWD="$(pwd)"
DATA_DIR="$CWD/data"

echo "[INFO] Current working directory: $CWD"

# Create data directory
if [ ! -d "$DATA_DIR" ]; then
    echo "[INFO] Creating data directory at $DATA_DIR"
    mkdir "$DATA_DIR"
else
    echo "[INFO] Data directory already exists at $DATA_DIR"
fi

# Find all directories starting with "fs" in cwd
for DIR in "$CWD"/fs*/; do
    [ -d "$DIR" ] || continue
    BASENAME=$(basename "$DIR")
    echo "[INFO] Processing directory: $BASENAME"

    # Copy all files (not directories) from DIR to data directory
    for FILE in "$DIR"*; do
        if [ -f "$FILE" ]; then
            echo "[INFO] Copying file $(basename "$FILE") to data directory"
            cp "$FILE" "$DATA_DIR/"
        fi
    done

    # Iterate over subdirectories
    for SUBDIR in "$DIR"*/; do
        [ -d "$SUBDIR" ] || continue
        SUBBASENAME=$(basename "$SUBDIR")
        ZIPFILE="$DATA_DIR/${SUBBASENAME}.zip"
        echo "[INFO] Packing contents of $SUBBASENAME into $ZIPFILE"
        (cd "$SUBDIR" && zip -r "$ZIPFILE" .)
        # Move the zip file to data directory
        mv "$SUBDIR/$SUBBASENAME.zip" "$DATA_DIR/" 2>/dev/null || true
    done
done

echo "[INFO] All done."