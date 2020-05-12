#!/bin/sh

if [[ $# != 2 ]]; then
    echo "[!] $0 [src.odg] [out.pdf]" >&2
    exit 1
fi

candidates=(/Applications/LibreOffice.app/Contents/MacOS/soffice)

for pn in candidates; do
    if [[ -e $pn ]]; then
        SOFFICE=$pn
        break
    fi
done

if [[ -z $SOFFICE ]]; then
    if which soffice &>/dev/null; then
        SOFFICE=soffice
    else
        echo "[!] please install 'soffice'" >&2
        exit 1
    fi
fi

$SOFFICE --convert-to pdf $1 --outdir $(dirname $1)
pdfcrop $2 $2
