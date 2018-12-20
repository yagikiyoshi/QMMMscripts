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

# In other cases, you may want to start always
# from the same MO, for example, in vibrational 
# calculations.
#
# cp ${initialchk} gaussian.chk

# -----------------------------------------------
# Settings for Gaussian16
#
module load gaussian
GAUSS_EXEBIN=g16

# -----------------------------------------------
# Scratch folder settings
#
TIME=$(date '+%N')
export GAUSS_SCRDIR=./g16scratch/$MOL.$TIME.$$
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
# Now exe g16 and create a formatted chk file
#
(time $GAUSS_EXEBIN < $QMINP) > ${QMOUT} 2>&1
formchk gaussian.chk gaussian.Fchk >& /dev/null

# -----------------------------------------------
# Remove unnecessary folder
#
rm -rf ${GAUSS_SCRDIR}

