#!/bin/csh -f

source /home/gempak/NAWIPS/Gemenviron
set DOCDIR=/home/mjames/gemdocs/
if ( ! -e $DOCDIR ) exit 0

rm -rf $DOCDIR/hlp/*
rm -rf $DOCDIR/man/prog/*
rm -rf $DOCDIR/man/parm/*

# PROGRAM FILES

set progs=`ls $GEMPTXT | cut -d . -f1`
foreach prog ($progs)
   set pval=`echo $prog | tr '[:lower:]' '[:upper:]'`
   cp $GEMHLP/hlp/${prog}.hlp $DOCDIR/hlp/
   set LCLFIL=$DOCDIR/hlp/${prog}.hlp
   set OUTFIL=$DOCDIR/man/prog/${prog}.html
   if ( -e $LCLFIL ) then 
      set parms=`ls $GEMHLP/hlx/*.hl2 | cut -d / -f8 | cut -d . -f1`
      foreach parm ($parms)
         set val=`echo $parm | tr '[:lower:]' '[:upper:]'`
         sed -i 's/\b'${val}'\b/<a href=..\/parm\/'${parm}'.html>'${val}'<\/a>/g' $LCLFIL
         if (${val} == TRACE) then
            sed -i 's/\bTRACE\([1-5]\)\b/<a href=..\/parm\/'${parm}'.html>TRACE\1<\/a>/g' $LCLFIL
         endif
      end
      echo '<\!doctype html>' > $OUTFIL
      echo '<a href=../>GEMPAK Manual</a> | ' >> $OUTFIL
      echo '<a href=../prog/>GEMPAK Programs</a><br><hr>' >> $OUTFIL
      echo '<pre>' >> $OUTFIL
      cat $LCLFIL >> $OUTFIL
      echo '</pre>' >> $OUTFIL
   endif
   scp $OUTFIL conan:/content/software/gempak/man/prog/
end


# PARAMETER FILES
#set parms=`ls $GEMHLP/hlx/*.hl2 | cut -d / -f8 | cut -d . -f1`
 
foreach parm ($parms)
   cp $GEMHLP/hlx/${parm}.hl2 $DOCDIR/hlp/
   set LCLFIL=$DOCDIR/hlp/${parm}.hl2
   set OUTFIL=$DOCDIR/man/parm/${parm}.html
   set val1=`echo $parm | tr '[:lower:]' '[:upper:]'`

   if ( -e $LCLFIL ) then
      set parms2=`ls $GEMHLP/hlx/*.hl2 | cut -d / -f8 | cut -d . -f1 | grep -v $parm`
      foreach parm2 ($parms2)
         set val=`echo $parm2 | tr '[:lower:]' '[:upper:]'`
         sed -i 's/\b'${val}'\b/<a href='${parm2}'.html>'${val}'<\/a>/g' $LCLFIL
         if (${val} == TRACE) then
            sed -i 's/\bTRACE\([1-5]\)\b/<a href='${parm2}'.html>TRACE\1<\/a>/g' $LCLFIL
         endif
      end
      echo '<\!doctype html>' > $OUTFIL
      #echo '<title> '$val1' : GEMPAK Manual</title>' >> $OUTFIL
      #echo '<link rel=StyleSheet href=/software/gempak/tutorial/md.css TYPE="text/css"> ' >> $OUTFIL
      echo '<a href=../>GEMPAK Manual</a> | ' >> $OUTFIL
      echo '<a href=../prog/>GEMPAK Programs</a><br><hr>' >> $OUTFIL
      echo '<pre>' >> $OUTFIL
      cat $LCLFIL >> $OUTFIL
      echo '</pre>' >> $OUTFIL
   endif
   scp $OUTFIL conan:/content/software/gempak/man/parm/
end

exit 0



