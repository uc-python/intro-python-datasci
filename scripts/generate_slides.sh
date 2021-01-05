set -e

if [ ! -d ".git" ]; then
    echo "Error: no .git directory detected"
    echo "This script should be run from the base of the repo"
    echo 'e.g. `bash scripts/generate_slides.sh`'
    exit 1
fi

# We must be *in* the notebook folder for relative links (to eg images) to work
# correctly..
cd notebooks
cp -r images ../slides
# Match all notebook files with content.
for file in *-*.ipynb; do
    # jupyter nbconvert --to slides $file --reveal-prefix https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.3.0 --output-dir=../slides
    jupyter nbconvert --to slides $file --output-dir=../slides
done
