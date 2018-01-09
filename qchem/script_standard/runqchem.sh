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
# Scratch folder settings
#
TIME=$(date '+%N')
export QCLOCALSCR=./$MOL.$TIME.$$
mkdir -p ${QCLOCALSCR}

# -----------------------------------------------
# Initial MO
#
SAVE=qchem_save
if [ $NSTEP -eq 0 ] && [ -e ${initial} ]; then
  cp -r ${initial} ${SAVE}
fi

if [ ! -e ${SAVE} ]; then
  TMP=$(mktemp tmp.XXXX)
  grep -i -v scf_guess ${QMINP} > $TMP
  mv $TMP ${QMINP}
fi

# -----------------------------------------------
# Default QM_NUM_THREADS to OMP_NUM_THREADS
#
if [ -z "$QM_NUM_THREADS" ] && [ "${QM_NUM_THREADS:-A}" = "${QM_NUM_THREADS-A}" ]; then
  QM_NUM_THREADS=$OMP_NUM_THREADS
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
rm -r ${QCLOCALSCR}
rm pathtable

exit 0

