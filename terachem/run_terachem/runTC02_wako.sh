#!/bin/bash

# -----------------------------------------------
QMINP=$1
QMOUT=$2
NSTEP=$3
MOL=${QMINP%.*}

initialmo='../initial.c0'

# -----------------------------------------------
# Settings for TeraChem
#
export TeraChem=/home/yagi/pgm/terachem1.93P/TeraChem
export NBOEXE=/home/yagi/pgm/terachem1.93P/TeraChem/bin/nbo6.i4.exe
export LD_LIBRARY_PATH=/home/yagi/pgm/terachem1.93P/TeraChem/lib:$LD_LIBRARY_PATH
export PATH=/home/yagi/pgm/terachem1.93P/TeraChem/bin:$PATH

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
if [ $NSTEP -eq 0 ] && [ -e ${initialmo} ]; then
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



