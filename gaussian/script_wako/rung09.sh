#!/bin/bash

# -----------------------------------------------
QMINP=$1
QMOUT=$2
NSTEP=$3
MOL=${QMINP%.*}

initialchk='../initial.chk'

# -----------------------------------------------
# Settings for Gaussian09
#
export g09root=/home/mdsoft/gaussian/g09D01_HCentOS6
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
# Initial MO
#
if [ $NSTEP -eq 0 ] && [ -e ${initialchk} ]; then
  cp ${initialchk} gaussian.chk
fi

# -----------------------------------------------
# SMP parallel setting
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

