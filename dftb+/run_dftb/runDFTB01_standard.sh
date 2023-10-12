#!/bin/bash

# -----------------------------------------------
# Settings for DFTB+
#
# --- Set the path for DFTB+ ---
export PATH=/path/to/dftbplus-23.1/_install/bin:$PATH

# (optional) 
# --- Set a file to read initial charges ---
#initial='../charges.bin_save'

# -----------------------------------------------

QMINP=$1
QMOUT=$2
NSTEP=$3
MOL=${QMINP%.*}

# -----------------------------------------------
# Initial charge
#
# The initial charge is copied only for the 1st step 
# in MD.
#
if [ $NSTEP -eq 0 ] && [ -n "${initial}" ] && [ -e ${initial} ]; then
  cp ${initial} charges.bin
fi

if [ ! -e charges.bin ] && [ ! -e charges.dat ]; then
  # Remove an option for ReadInitialCharges
  TMP=$(mktemp tmp.XXXX)
  grep -v -i -e readinitialcharges -e readchargesastext ${QMINP} >> ${TMP}
  mv $TMP ${QMINP}
fi

# -----------------------------------------------
# SMP parallel setting
#   - check if QM_NUM_THREADS is undefined.
#   - same as "test -v"
#
if [ -z "$QM_NUM_THREADS" ] && [ "${QM_NUM_THREADS:-A}" = "${QM_NUM_THREADS-A}" ]; then
  export OMP_NUM_THREADS=1
else
  export OMP_NUM_THREADS=${QM_NUM_THREADS}
fi

# -----------------------------------------------
# Now exe DFTB+
#
cp ${QMINP} dftb_in.hsd
dftb+ >& ${QMOUT}

# -----------------------------------------------
# Remove unnecessary files
#
rm dftb_in.hsd
rm band.out

