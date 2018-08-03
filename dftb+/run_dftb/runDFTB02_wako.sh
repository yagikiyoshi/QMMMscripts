#!/bin/bash

# -----------------------------------------------
QMINP=$1
QMOUT=$2
NSTEP=$3
MOL=${QMINP%.*}

initial='../charges.bin_save'

# -----------------------------------------------
# Settings for DFTB+
#
export PATH=/home/yagi/pgm/dftb/dftbplus-18.1/_install/bin:$PATH

# -----------------------------------------------
# Initial charge
#
if [ $NSTEP -eq 0 ] && [ -e ${initial} ]; then
  cp ${initial} charges.bin
fi

if [ ! -e charges.bin ] && [ ! -e charges.dat ]; then
  TMP=$(mktemp tmp.XXXX)
  grep -v -i -e readinitialcharges -e readchargesastext ${QMINP} >> ${TMP}
  mv $TMP ${QMINP}
fi

# -----------------------------------------------
# SMP parallel setting
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

