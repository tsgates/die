#!/usr/bin/env python3

import sys

TR = {
    r"\PY{o}{*}": r"$\star$",
}

for l in sys.stdin.readlines():
    for k, v in TR.items():
        if l.startswith(k):
            l = l.replace(k, v, 1)
            break
    print(l, end="")