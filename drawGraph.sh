#!/bin/bash

IMG_DIR = "./img/"
echo "Checking depencies"
if type prism &> /dev/null; then
    echo "prism is installed"
else
    echo "Prism is not installed. Run ./bin/initPrism.sh to install"
fi

if type dot &> /dev/null; then
    echo "dot is installed"
else
    echo "Using sudo to install graphviz"    
    sudo apt install graphviz
fi

if [ -d "$IMG_DIR" ]; then
    echo "Making image directory"
    mkdir ./img
fi

for i in *.prism; do
    [ -f "$i" ] || echo "no prism file found";break
    x=$(basename $i .prism)
    prism $i -exportmodel $i.dot
    dot -Tsvg $i.dot -o $x.svg
    mv *.svg ./img
    rm *.dot
    echo "$x.svg placed in ./img/"
done