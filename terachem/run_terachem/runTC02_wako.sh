#!/bin/bash

# -----------------------------------------------
# Settings for TeraChem
#
export TeraChem=/home/yagi/pgm/terachem1.93P/TeraChem
export NBOEXE=/home/yagi/pgm/terachem1.93P/TeraChem/bin/nbo6.i4.exe
export LD_LIBRARY_PATH=/home/yagi/pgm/terachem1.93P/TeraChem/lib:$LD_LIBRARY_PATH
export PATH=/home/yagi/pgm/terachem1.93P/TeraChem/bin:$PATH

# GPU settings
#
export CUDA_VISIBLE_DEVICES="0,1,2,3"

# (optional) 
# --- Set a file to read initial MOs ---
initial='../initial.c0'

# -----------------------------------------------

QMINP=$1
QMOUT=$2
NSTEP=$3
MOL=${QMINP%.*}

# -----------------------------------------------
# Scratch folder settings
#
SCR=$(grep -i scrdir ${QMINP} |awk '{print $2}')
if [ -z "${SCR}" ]; then
  SCR=scr
fi
mkdir -p ${SCR}

# -----------------------------------------------
# Initial MO
#
# The initial MO is copied only for the 1st step 
# in MD.
#
if [ $NSTEP -eq 0 ] && [ -n "${initial}" ] && [ -e ${initial} ]; then
  cp ${initial} ${SCR}/c0
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
# Now exe terachem 
#
terachem ${QMINP} >& ${QMOUT}

# -----------------------------------------------
# Remove unnecessary files
#
rm -rf ${SCR}/${MOL}*
rm -rf ${SCR}/charge_mull.xls
rm -rf ${SCR}/esp.xyz
rm -rf ${SCR}/mullpop



