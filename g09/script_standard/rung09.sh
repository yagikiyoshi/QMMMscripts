#!/bin/bash

# -----------------------------------------------
QMINP=$1
QMOUT=$2
MOL=${QMINP%.*}

# -----------------------------------------------
# Script to run Gaussian
#
export g09root=/Users/kyagi/Work/pgm/gaussian
export GAUSS_EXEDIR=$g09root/g09
export GAUSS_EXEBIN=$g09root/g09/g09
export PATH=$PATH:$GAUSS_EXEDIR
export LD_LIBRARY_PATH=${GAUSS_EXEDIR}:${LD_LIBRARY_PATH}

# -----------------------------------------------
# Folder settings
#
TIME=$(date '+%N')
export GAUSS_SCRDIR=./$MOL.$TIME.$$
mkdir -p ${GAUSS_SCRDIR}
sed -i -e "s#SCRDIR#${GAUSS_SCRDIR}#g" $QMINP

# -----------------------------------------------
# Restart MO
#
savechk="gaussian_save.chk"
if [ -e ${savechk} ]; then
  cp ${savechk} ${GAUSS_SCRDIR}
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

