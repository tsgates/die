#!/bin/sh
perl -pi -e 's,January,Jan,;
	     s,February,Feb,;
	     s,March,Mar,;
	     s,April,Apr,;
	     s,June,Jun,;
	     s,July,Jul,;
	     s,August,Aug,;
	     s,September,Sep,;
	     s,October,Oct,;
	     s,November,Nov,;
	     s,December,Dec,;' "$@"
