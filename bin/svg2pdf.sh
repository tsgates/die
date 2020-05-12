#!/bin/bash

if [[ $# != 2 ]]; then
    echo "[!] $0 [src.svg] [out.pdf]" >&2
    exit 1
fi

candidates=(
    /Applications/Inkscape.app/Contents/Resources/bin/inkscape
    /Applications/Inkscape.app/Contents/MacOS/inkscape
)

for pn in candidates; do
    if [[ -e $pn ]]; then
        INKSCAPE=$pn
        break
    fi
done

if [[ -z $INKSCAPE ]]; then
    if which inkscape &>/dev/null; then
        INKSCAPE=inkscape
    else
        echo "[!] please install 'inkscape'" >&2
        exit 1
    fi
fi

# set arguments
if ($INKSCAPE --version | grep "Inkscape 0.9") &>/dev/null; then
    INKSCAPE_ARG1="--without-gui -f"
    INKSCAPE_ARG2="-A"
else
    INKSCAPE_ARG1=""
    INKSCAPE_ARG2="-o"
fi

$INKSCAPE -D $INKSCAPE_ARG1 $1 $INKSCAPE_ARG2 $2
