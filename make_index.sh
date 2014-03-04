#!/bin/csh -f

source /home/gempak/NAWIPS/Gemenviron
set CGIDIR=/home/mjames/gemdocs/
if ( ! -e $CGIDIR ) exit 0

# PROGRAM FILES

set OUTFIL=$CGIDIR/man/prog/index.html
echo '<\!doctype html>' > $OUTFIL
echo '<a href=../>GEMPAK Manual</a><br><hr>' >> $OUTFIL
set progs=`ls $GEMPTXT | cut -d . -f1`
foreach prog ($progs)
   echo '<li><a href='$prog'.html>'$prog'</a></li>' >> $OUTFIL
end
scp $OUTFIL conan:/content/software/gempak/man/prog/

# PARAMETER FILES
 
set OUTFIL=$CGIDIR/man/parm/index.html
echo '<\!doctype html>' > $OUTFIL
echo '<a href=../>GEMPAK Manual</a><br><hr>' >> $OUTFIL
set parms=`ls $GEMHLP/hlx/*.hl2 | cut -d / -f8 | cut -d . -f1`
foreach parm ($parms)
   echo '<li><a href='$parm'.html>'$parm'</a></li>' >> $OUTFIL
end
scp $OUTFIL conan:/content/software/gempak/man/parm/

exit 0



