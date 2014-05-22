#!/usr/bin/env gnuplot

set term epslatex color size 5,2.6
set output "data/ex-plot.tex"

set style data histogram
set style fill solid border
set ylabel "Time (sec)"
set yrange [0:75]

set xtics center offset 0.8,0

plot for [COL=2:2] 'data/ex-plot.dat' using COL:xticlabels(1) notitle
