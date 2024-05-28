#!perl

# This program prints the date of Easter given the year number.  If no argument
# is supplied, the next occurance of Easter is printed.

$year  = $ARGV[0];
$month = 0;
$day   = 0;

if ("$year" ne "") {

    GetEasterDate ($year, $month, $day);

} else {

    # No year was supplied on the command line, so get the next occurance of
    # Easter.  First get the Easter date for this year.

    ($j1, $j2, $j3, $currday, $currmonth, $year, $jrest) = localtime();
    $year      += 1900;
    $currmonth += 1;

    # Get the Easter Date for this year.

    GetEasterDate ($year, $month, $day);

    # If the computed date occurs before today, then Easter is past for this
    # year, so get the date for next year.

    if (($month < $currmonth) || (($month == $currmonth) && ($day < $currday)))
    {
        ++ $year;
        GetEasterDate ($year, $month, $day);
    }
}

printf "%04d-%02d-%02d\n", $year, $month, $day;
exit (0);



# ____________________________________________________________________________
#
# Article 32049 of sci.math:
# From: ernie@neumann.une.edu.au (Ernest W Bowen)
# Newsgroups: sci.math
# Subject: Re: algorithm for date of easter
# Date: 6 Jul 93 15:18:54 GMT
# Sender: usenet@grivel.une.edu.au
# 
# hadi@salyko.cubenet.sub.org (Hans Dimbeck) writes:
# > I need a method to calculate the date of easter.
# 
# According to H.V. Smith in "Mathematical Spectrum," 11 (1978/79),
# 23-24, the following rule appeared in Butcher's Ecclesiastical
# Calendar, 1876.  To find the date of Easter Sunday for year y:
# 
#               Divide            by      Quotient  Remainder
#         ---------------------------------------------------
#                  y               19                   j
#                  y              100        k          h
#                  k                4        m          n
#                k + 8             25        p
#              k - p + 1            3        q
#         19j + k - m - q + 15     30                   r
#                  h                4        s          u
#         32 + 2n + 2s - r - u      7                   v
#            j + 11r + 22v        451        w
#          r + v - 7w + 114        31        x          z
# 
# Here x is the number of the month and 1 + z is the day of that
# month upon which Easter Sunday falls in the year y. 
# 
# 	The following csh shell script does these calculations and
# echoes x and 1 + z.  Some signs appear to be wrong because in @
# assignments + and - are right-associative.
# 
# ---
# 
# With argument y, this echoes the month-number and day-number for
# Easter Sunday in year y; e.g. easter 1992 displays  4 19.
#
##############################################################################

# This routine returns the month and day of Easter based on the given year.

sub GetEasterDate ($year, $month, $day)
{
    ($year, $month, $day) = @_;
    local ($j, $k, $h, $m, $n, $p, $q, $r, $s, $u, $v, $w, $xp);

    $j  = $year % 19;
    $k  = int($year / 100);
    $h  = $year % 100;
    $m  = int($k / 4);
    $n  = $k % 4;
    $p  = int(($k + 8) / 25);
    $q  = int(($k - $p + 1) / 3);
    $r  = ((19 * $j) + $k - $m - $q + 15) % 30;
    $s  = int($h / 4);
    $u  = $h % 4;
    $v  = (32 + (2*$n) + (2*$s) - $r - $u) % 7;
    $w  = int(($j + (11*$r) + (22*$v)) / 451);
    $xp = $r + $v - (7*$w) + 114;

    $month = int($xp / 31);
    $day   = ($xp % 31) + 1;
}
