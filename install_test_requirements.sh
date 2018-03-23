#!/bin/bash -x

echo "Install Test Requirements"
pip install .
pip install -I -r test-requirements.txt
which travis || ( which brew && brew install travis ) ||:
