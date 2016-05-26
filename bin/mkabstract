#!/usr/bin/env python3

import os
import sys
import re
import textwrap

if len(sys.argv) != 3:
    print("[usage] %s [p.tex] [abstract.tex]" % sys.argv[0])
    exit(0)

pn_main = sys.argv[1]
pn_abst = sys.argv[2]

def get_sys(tex):
    tok = re.findall(r"\\newcommand{\\sys}{\\mbox{\\textsc{([^}]*)}", tex)
    if len(tok) == 0:
        print("Failed to find 'sys'")
        exit(1)
    return tok[0]

SYS = get_sys(open(pn_main).read())

abstract = []
for l in open(pn_abst):
    l = l.strip()
    if l.startswith("%"):
        continue
    if "{abstract}" in l:
        continue
    l = l.replace("\\%", "%")
    l = l.replace("\\emph{", "")
    l = l.replace("{", "")
    l = l.replace("}", "")
    l = l.replace("~", " ")
    l = l.replace("\\,", " ")
    l = l.replace("\\X", "x")
    l = l.replace("---", " -- ")
    l = l.replace("--", "-")
    l = l.replace("\\sys", SYS)
    l = l.replace("\\ie", "i.e.")
    l = l.replace("\\eg", "e.g.")
    l = l.replace("\\etal", " et al.")
    l = l.replace("\\Bs", " B/s")
    l = l.replace("\\KBs", " KB/s")
    l = l.replace("\\MBs", " MB/s")
    l = l.replace("\\GBs", " GB/s")
    l = l.replace("\\KB", " KB")
    l = l.replace("\\MB", " MB")
    l = l.replace("\\GB", " GB")
    l = l.replace("\\TB", " TB")
    l = l.replace("\\B", " B")
    l = l.replace("\\K", " K")
    l = l.replace("\\M", " M")
    l = l.replace("\\T", " T")
    
    if "\\" in l:
        print("WARN: unresolved char in")
        print(" > %s" % l)
        exit(1)

    abstract.append(l)

print("\n".join(abstract))
