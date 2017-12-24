#!/bin/bash
#
# Script to run Q-Chem
#
# ==============================================================
QMINP=$1
QMOUT=$2
NSTEP=$3
MOL=${QMINP%.*}

initial='../initial_save'

# ==============================================================
# Settings for QChem 4.4
#
export QC=/home/mdsoft/qchem/qchem_v4.4/intel
export QCAUX=$QC/qcaux
export QCSCRATCH=$(pwd)
. $QC/qcenv.sh
export PATH=$QC/bin:$QC/exe:${PATH}

# -----------------------------------------------
# Folder settings
#
TIME=$(date '+%N')
if [ -e /scr2 ]; then
  export QCLOCALSCR=/scr2/${USER}/$MOL.$TIME.$$
else
  export QCLOCALSCR=/scr/${USER}/$MOL.$TIME.$$
fi
mkdir -p $QCLOCALSCR

# -----------------------------------------------
# Initial MO
#
SAVE=qchem_save
if [ $NSTEP -eq 0 ] && [ -e ${initial} ]; then
  cp -r ${initial} ${SAVE}
fi

if [ ! -e ${SAVE} ]; then
  grep -i -v scf_guess ${QMINP} > tmp
  mv tmp ${QMINP}
fi

# ==============================================================
# Now execute Q-Chem
#
(time qchem -nt ${QM_NUM_THREADS} -save $QMINP $QMOUT $SAVE) >& $MOL.e
cat $MOL.e >> $QMOUT
rm $MOL.e

# ==============================================================
# Post process
#
rm -r $QCLOCALSCR
rm pathtable

exit 0

