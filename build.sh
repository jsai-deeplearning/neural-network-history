#!/usr/bin/env bash

pwd=`pwd`;
rmcmd=/bin/rm
pubdir=kamext:sync/doc/My
figdir=Fig

base=nnhistory

build=main
#build=proof

latex=platex
#latex=pdflatex

bibtex=pbibtex
#bibtex=bibtex

# paper size
paper=a4
#paper=letter

# generate xbb files
#ls ${figdir}/*.pdf ${figdir}/*.png ${figdir}/*.jpg 2>&1 >/dev/null
#if [ $? ]; then
#  /bin/rm ${figdir}/*.xbb
  #extractbb ${figdir}/*.pdf ${figdir}/*.png ${figdir}/*.jpg
#fi

# build pdf file
for target in ${build}; do
  if [ -f ${target}.aux ]; then
    ${rmcmd} ${target}.aux
  fi
  ${latex} ${target}
#  ${bibtex}  ${target}
#  if [ -f ${target}.idx ]; then
#    mendex -r -c -g -p any -s ${target}.ist -d ${target}.dic ${target}.idx
#  fi
  ${latex} ${target} 2>&1 >/dev/null
  ${latex} ${target} 2>&1 >/dev/null
  ${latex} ${target}
  if [ "x${latex}" != "xpdflatex" ]; then
    dvipdfmx -p ${paper} -o ${target}.pdf ${target}
    #dvipdfmx -o ${target}.pdf -m 2 -x 2in -y 2in ${target} # magnifiy two times
  fi
done

# rename target files
/bin/cp -f ${build}.pdf ${base}.pdf

