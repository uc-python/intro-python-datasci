# Replace a notebook, with cells tagged ci-skip removed.
# Adapted from https://stackoverflow.com/questions/62022603/how-to-delete-a-jupyter-notebook-input-cell-programmatically-using-its-tag

import sys
import nbformat

SKIP_TAG = 'ci-skip'

if len(sys.argv) != 2:
    raise Exception('Usage: prep_nb_for_ci [notebook.ipynb]')
nb_file = sys.argv[1]

nb = nbformat.read(nb_file, as_version=nbformat.NO_CONVERT)

tagged_cell_indices = []

# find index for the cell with the injected params
for idx, cell in enumerate(nb.cells):
    cell_tags = cell.metadata.get('tags')
    if cell_tags:
        if SKIP_TAG in cell_tags:
            tagged_cell_indices.append(idx)

# Remove tagged cells.
# Iterate in reverse because deleting an earlier index will change what cell
# is at a later one.
for idx in reversed(tagged_cell_indices):
    nb.cells.pop(idx)

# Overwrite the original.
nbformat.write(nb, nb_file)
