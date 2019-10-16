#!/bin/bash

# -----------------------------------------------
# Settings for TeraChem
#
export TeraChem=/home/yagi/pgm/terachem1.94V/TeraChem
export NBOEXE=${TeraChem}/bin/nbo6.i4.exe
export LD_LIBRARY_PATH=${TeraChem}/lib:$LD_LIBRARY_PATH
export PATH=${TeraChem}/bin:$PATH

# GPU settings
#
export CUDA_VISIBLE_DEVICES="0,1,2,3"

# (optional) 
# --- Absolute path to initial MOs ---
#c0='/home/mo/initial.c0'
#c0a='/home/mo/initial.c0a'
#c0b='/home/mo/initial.c0b'

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

# -----------------------------------------------
# Initial MO
#
# The initial MO is copied only for the 1st step 
# in MD.
#
if [ ! -e c0 ] && [ -n "${c0}" ] && [ -e ${c0} ]; then
  cp ${c0} c0
fi
if [ ! -e c0a ] && [ -n "${c0a}" ] && [ -e ${c0a} ]; then
  cp ${c0a} c0a
fi
if [ ! -e c0b ] && [ -n "${c0b}" ] && [ -e ${c0b} ]; then
  cp ${c0b} c0b
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
# Save MOs for restart
#
if [ -e ${SCR}/c0 ]; then
  cp ${SCR}/c0 c0
fi
if [ -e ${SCR}/c0a ]; then
  cp ${SCR}/c0a c0a
  cp ${SCR}/c0b c0b
fi

# Remove unnecessary files
#
rm -rf ${SCR}/${MOL}*
rm -rf ${SCR}/charge_mull.xls
rm -rf ${SCR}/esp.xyz
rm -rf ${SCR}/mullpop



