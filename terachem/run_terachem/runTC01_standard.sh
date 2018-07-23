#!/bin/bash

# -----------------------------------------------
QMINP=$1
QMOUT=$2
NSTEP=$3
MOL=${QMINP%.*}
SCR=scr

initialmo='../initial.c0'

# -----------------------------------------------
# Settings for TeraChem
#

export TeraChem=/path/to/terachem1.93P/TeraChem
export NBOEXE=/path/to/terachem1.93P/TeraChem/bin/nbo6.i4.exe
export LD_LIBRARY_PATH=/path/to/terachem1.93P/TeraChem/lib:$LD_LIBRARY_PATH
export PATH=/path/to/terachem1.93P/TeraChem/bin:$PATH

# -----------------------------------------------
# Initial MO
#
if [ $NSTEP -eq 0 ] && [ -e ${initialmo} ]; then
  mkdir ${SCR}
  cp ${initialmo} ${SCR}/c0
fi

# -----------------------------------------------
# SMP parallel setting
#
export OMP_NUM_THREADS=1

# -----------------------------------------------
# GPU settings
#
export CUDA_VISIBLE_DEVICES="0,1"

# -----------------------------------------------
# Now exe terachem and create a formatted chk file
#
terachem ${QMINP} >& ${QMOUT}

# -----------------------------------------------
# Remove unnecessary files
#
rm -rf ${SCR}/${MOL}*
rm -rf ${SCR}/charge_mull.xls
rm -rf ${SCR}/esp.xyz
rm -rf ${SCR}/mullpop



