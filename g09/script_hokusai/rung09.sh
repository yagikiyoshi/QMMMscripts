#!/bin/bash

# -----------------------------------------------
QMINP=$1
QMOUT=$2
MOL=${QMINP%.*}

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
sed -i -e "s#SCRDIR#${GAUSS_SCRDIR}#gi" $QMINP

# -----------------------------------------------
# Restart MO
#
savechk="gaussian_save.chk"
if [ -e ${savechk} ]; then
  cp ${savechk} ${GAUSS_SCRDIR}/gaussian.chk
fi

# -----------------------------------------------
# Now exe g09 and create a formatted chk file
#
(time $GAUSS_EXEBIN < $QMINP) > ${QMOUT} 2>&1
formchk ${GAUSS_SCRDIR}/gaussian.chk gaussian.Fchk >& /dev/null

# -----------------------------------------------
# Save current MO
#
cp ${GAUSS_SCRDIR}/gaussian.chk $savechk

# -----------------------------------------------
# Remove unnecessary folder
#
rm -rf ${GAUSS_SCRDIR}

