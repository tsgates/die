push @cus_dep_list, "c tex 0 c2tex";
push @cus_dep_list, "diff tex 0 diff2tex";

sub c2tex { system("pygmentize -P tabsize=4 -P mathescape -f latex $_[0].c > $_[0].tex"); }
sub diff2tex { system("pygmentize -P tabsize=4 -P mathescape -f latex $_[0].diff > $_[0].tex"); }
