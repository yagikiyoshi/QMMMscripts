#!/bin/bash

# -----------------------------------------------
QMINP=$1
QMOUT=$2
NSTEP=$3
MOL=${QMINP%.*}

initialchk='../initial.chk'

# -----------------------------------------------
# Initial MO
#
# In the following, the initial MO is copied only 
# for the 1st step in MD.
#
if [ $NSTEP -eq 0 ] && [ -e ${initialchk} ]; then
  cp ${initialchk} gaussian.chk
fi

# -----------------------------------------------
# Settings for Gaussian09
#
# beluga
export g09root=/home/mdsoft/gaussian/g09D01_HCentOS7
# diva/kushana
#export g09root=/home/mdsoft/gaussian/g09D01_SCentOS6
export GAUSS_EXEDIR=$g09root/g09
export GAUSS_EXEBIN=$g09root/g09/g09
export PATH=$PATH:$GAUSS_EXEDIR
export LD_LIBRARY_PATH=${GAUSS_EXEDIR}:${LD_LIBRARY_PATH}

# -----------------------------------------------
# Scratch folder settings
#
TIME=$(date '+%N')
if [ -e /scr2 ]; then
  export GAUSS_SCRDIR=/scr2/${USER}/$MOL.$TIME.$$
else
  export GAUSS_SCRDIR=/scr/${USER}/$MOL.$TIME.$$
fi
mkdir -p ${GAUSS_SCRDIR}

# -----------------------------------------------
# SMP parallel setting
#   - check if QM_NUM_THREADS is undefined.
#   - same as "test -v"
#
if [ -z "$QM_NUM_THREADS" ] && [ "${QM_NUM_THREADS:-A}" = "${QM_NUM_THREADS-A}" ]; then
  QM_NUM_THREADS=$OMP_NUM_THREADS
fi

TMP=$(mktemp tmp.XXXX)
echo "%NprocShared=${QM_NUM_THREADS}" >> $TMP
grep -v -i nproc $QMINP >> $TMP
mv $TMP $QMINP

# -----------------------------------------------
# Now exe g09 and create a formatted chk file
#
(time $GAUSS_EXEBIN < $QMINP) > ${QMOUT} 2>&1
formchk gaussian.chk gaussian.Fchk >& /dev/null

# -----------------------------------------------
# Remove unnecessary folder
#
rm -rf ${GAUSS_SCRDIR}

