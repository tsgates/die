$bibtex = "bibtex -min-crossrefs=99";

push @cus_dep_list, "c tex 0 c2tex";
push @cus_dep_list, "cc tex 0 cc2tex";
push @cus_dep_list, "js tex 0 js2tex";
push @cus_dep_list, "py tex 0 py2tex";
push @cus_dep_list, "svg pdf 0 svg2pdf";
push @cus_dep_list, "plt tex 0 plt2tex";
push @cus_dep_list, "gp tex 0 gp2tex";
push @cus_dep_list, "dat gp 0 gp2tex";

sub c2tex { system("pygmentize -P tabsize=4 -P mathescape -f latex $_[0].c > $_[0].tex"); }
sub cc2tex { system("pygmentize -P tabsize=4 -P mathescape -f latex $_[0].cc > $_[0].tex"); }
sub js2tex { system("pygmentize -P linenos=1 -f latex $_[0].js > $_[0].tex"); }
sub py2tex { system("pygmentize -P tabsize=4 -P mathescape -f latex $_[0].py > $_[0].tex"); }
sub js2tex { system("pygmentize -P linenos=1 -f latex $_[0].js > $_[0].tex"); }
sub svg2pdf { system("inkscape --without-gui -f $_[0].svg -D -A $_[0].pdf"); }
sub gp2tex { system("gnuplot $_[0].gp"); }

