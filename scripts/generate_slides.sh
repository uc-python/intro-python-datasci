#!/bin/bash

if [ ! -d ".git" ]; then
    echo "Error: no .git directory detected"
    echo "This script should be run from the base of the repo"
    echo 'e.g. `bash scripts/generate_slides.sh`'
    exit 1
fi

# We must be *in* the notebook folder for relative links (to eg images) to work
# correctly..
cd notebooks
mkdir -p ../slides/images/
cp -a ./images/* ../slides/images/
# Match all notebook files with content.
for file in *-*.ipynb; do
    jupyter nbconvert --to slides $file --output-dir=../slides
done
