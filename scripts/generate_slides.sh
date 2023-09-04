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
# images are copied over to slides/ by the Makefile
NB_PATH="$1"
REL_NB=${NB_PATH/#notebooks\//}
jupyter nbconvert --to slides $REL_NB --output-dir=../slides
