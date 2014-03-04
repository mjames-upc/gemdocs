#!/bin/csh -f

source /home/gempak/NAWIPS/Gemenviron
set DOCDIR=/home/mjames/gemdocs/
if ( ! -e $DOCDIR ) exit 0

# DECODERS

set OUTFIL=$DOCDIR/man/prog/dc.html
echo '<\!doctype html>' > $OUTFIL
echo '<LINK REL="StyleSheet" HREF="/software/gempak/man.css" TYPE="text/css">' >> $OUTFIL
echo '<a href=../../help_and_documentation>GEMPAK Manual</a> | Decoders <br><hr>' >> $OUTFIL
echo '<table>' >> $OUTFIL
cd $GEMHLP/hlp
set progs=`ls *.hlp | sed 's,\.hlp$,,' | grep '^dc' | sort | uniq`
foreach prog ($progs)
   set uparm=`echo $prog | tr '[:lower:]' '[:upper:]'`
   set blurb=`cat $GEMHLP/hlp/${prog}.hlp | head -4 | tail -1 | sed 's/'${uparm}'//g'`
   set blurb2=`cat $GEMHLP/hlp/${prog}.hlp | head -5 | tail -1`
   echo '<tr><td><a href='$prog'.html>'$prog'</a> '$blurb' '$blurb2'</td></tr>' >> $OUTFIL
end
echo '</table>' >> $OUTFIL
scp $OUTFIL conan:/content/software/gempak/man/prog/

exit 0

set OUTFIL=$DOCDIR/man/prog/index.html
echo '<\!doctype html>' > $OUTFIL
echo '<a href=../../help_and_documentation>GEMPAK Manual</a> | Programs <br><hr>' >> $OUTFIL
set progs=`ls $GEMPTXT | cut -d . -f1`
foreach prog ($progs)
   echo '<li><a href='$prog'.html>'$prog'</a></li>' >> $OUTFIL
end
scp $OUTFIL conan:/content/software/gempak/man/prog/

# PARAMETER FILES
 
set OUTFIL=$DOCDIR/man/parm/index.html
echo '<\!doctype html>' > $OUTFIL
echo '<a href=../../help_and_documentation>GEMPAK Manual</a> | Parameters <br><hr>' >> $OUTFIL
set parms=`ls $GEMHLP/hlx/*.hl2 | cut -d / -f8 | cut -d . -f1`
foreach parm ($parms)
   echo '<li><a href='$parm'.html>'$parm'</a></li>' >> $OUTFIL
end
scp $OUTFIL conan:/content/software/gempak/man/parm/


# NPROGS

set OUTFIL=$DOCDIR/man/prog/nprog.html
echo '<\!doctype html>' > $OUTFIL
echo '<a href=../../help_and_documentation>GEMPAK Manual</a> | GUI Programs (NPROGs) <br><hr>' >> $OUTFIL
cd $GEMHLP/hlp
set progs=`ls *.hlp | sed 's,\.hlp$,,' | grep 'Index$' | sed 's@Index$@@' | sort | uniq`
foreach prog ($progs)
   echo '<li><a href='$prog'.html>'$prog'</a></li>' >> $OUTFIL
end
scp $OUTFIL conan:/content/software/gempak/man/prog/




exit 0



