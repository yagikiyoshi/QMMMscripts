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
module load gaussian
GAUSS_EXEBIN=g16

# -----------------------------------------------
# Folder settings
#
TIME=$(date '+%N')
export GAUSS_SCRDIR=./g09scratch/$MOL.$TIME.$$
mkdir -p ${GAUSS_SCRDIR}

# -----------------------------------------------
# Initial MO
#
if [ $NSTEP -eq 0 ] && [ -e ${initialchk} ]; then
    cp ${initialchk} gaussian.chk
fi

# -----------------------------------------------
# Now exe g16 and create a formatted chk file
#
(time $GAUSS_EXEBIN < $QMINP) > ${QMOUT} 2>&1
formchk gaussian.chk gaussian.Fchk >& /dev/null

# -----------------------------------------------
# Remove unnecessary folder
#
rm -rf ${GAUSS_SCRDIR}

