#!/bin/bash

# -----------------------------------------------
QMINP=$1
QMOUT=$2
NSTEP=$3
MOL=${QMINP%.*}

initialchk='../initial.chk'

# -----------------------------------------------
# Script to run Gaussian
#
export g09root=/home/mdsoft/gaussian/g09D01_intel16
export GAUSS_EXEDIR=$g09root/g09
export GAUSS_EXEBIN=$g09root/g09/g09
export PATH=$PATH:$GAUSS_EXEDIR
export LD_LIBRARY_PATH=${GAUSS_EXEDIR}:${LD_LIBRARY_PATH}

# -----------------------------------------------
# Folder settings
#
TIME=$(date '+%N')
if [ -e /scr2 ]; then
  export GAUSS_SCRDIR=/scr2/${USER}/$MOL.$TIME.$$
else
  export GAUSS_SCRDIR=/scr/${USER}/$MOL.$TIME.$$
fi
mkdir -p ${GAUSS_SCRDIR}

# -----------------------------------------------
# Initial MO
#
if [ $NSTEP -eq 0 ] && [ -e ${initialchk} ]; then
    cp ${initialchk} gaussian.chk
fi

# -----------------------------------------------
# Now exe g09 and create a formatted chk file
#
(time $GAUSS_EXEBIN < $QMINP) > ${QMOUT} 2>&1
formchk gaussian.chk gaussian.Fchk >& /dev/null

# -----------------------------------------------
# Remove unnecessary folder
#
rm -rf ${GAUSS_SCRDIR}

