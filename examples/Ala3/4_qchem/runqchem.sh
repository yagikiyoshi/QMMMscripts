#!/bin/bash

# -----------------------------------------------
# Settings for Q-Chem
#
# --- Set the path for Q-Chem ---
export QC=/usr/local/qchem
export QCAUX=$QC/qcaux
export QCSCRATCH=$(pwd)
. $QC/qcenv.sh
export PATH=$QC/bin:$QC/exe:${PATH}

# --- Set the path for a scratch folder ---
scratch=./

# (optional) 
# --- Set a folder where initial MOs are stored ---
#initial='../initial_save'

# -----------------------------------------------

QMINP=$1
QMOUT=$2
NSTEP=$3
MOL=${QMINP%.*}

# -----------------------------------------------
# Initial MO
#
# The initial MO is copied only for the 1st step 
# in MD.
#
SAVE=qchem_save
if [ $NSTEP -eq 0 ] && [ -n "${initial}" ] && [ -e ${initial} ]; then
  cp -r ${initial} ${SAVE}
fi

if [ ! -e ${SAVE} ]; then
  # Remove an entry for scf_guess in the input
  TMP=$(mktemp tmp.XXXX)
  grep -i -v scf_guess ${QMINP} > $TMP
  mv $TMP ${QMINP}
fi

# -----------------------------------------------
# Scratch folder settings
#
export QCLOCALSCR=$scratch/$(mktemp -u $MOL.XXXX)
mkdir -p ${QCLOCALSCR}

# -----------------------------------------------
# SMP parallel setting
#   - check if QM_NUM_THREADS is undefined.
#   - same as "test -v"
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

