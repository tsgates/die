#!/usr/bin/gnuplot
#
# Plotting filledcurves with different transparencies
#
# AUTHOR: Hagen Wierstorf
# VERSION: gnuplot 4.6 patchlevel 0

reset

set term epslatex color size 3.5,2
set output "data/ex-gaussian.tex"

set border linewidth 1.5
# Axes
set style line 11 lc rgb '#808080' lt 1
set border 3 back ls 11
set tics nomirror out scale 0.75
# Grid
set style line 12 lc rgb'#808080' lt 0 lw 1
set grid back ls 12

set style fill noborder
set style function filledcurves y1=0
set clip two

Gauss(x,mu,sigma) = 1./(sigma*sqrt(2*pi)) * exp( -(x-mu)**2 / (2*sigma**2) )
d1(x) = Gauss(x, 0.5, 0.5)
d2(x) = Gauss(x,  2.,  1.)
d3(x) = Gauss(x, -1.,  2.)

set xrange [-5:5]
set yrange [0:1]

unset colorbox

set key title "Gaussian Distribution"
set key top left Left reverse samplen 1

set lmargin 6
plot d1(x) fs transparent solid 0.75 lc \
       rgb "forest-green" title '$\mu$= 0.5, $\sigma$=0.5', \
     d2(x) fs transparent solid 0.50 lc \
       rgb "gold" title '$\mu$= 2.0, $\sigma$=1.0', \
     d3(x) fs transparent solid 0.25 lc \
       rgb "red" title '$\mu$=-1.0, $\sigma$=2.0'
