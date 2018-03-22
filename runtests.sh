#!/bin/bash -xe
if which travis; then
    travis lint -x .travis.yml
else
    echo "Skipping travis lint as travis command not available. "
    echo "On osx, install from brew, otherwise gem."
fi
bashate *.sh
pylama --skip "*venv/*"

findbugs2junit testdata/findbugs.xml testdata/out.xml
diff testdata/out.xml testdata/junit.xml || {
    echo "test failed, output doesn't match."
    exit 1
}

if which pandoc; then
    pandoc -f markdown -t rst README.md > README.rst
    git add README.rst
else
    echo "skipping pandoc as not available"
fi
