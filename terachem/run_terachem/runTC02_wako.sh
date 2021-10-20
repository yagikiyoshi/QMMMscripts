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
#ca0='/home/mo/initial.ca0'
#cb0='/home/mo/initial.cb0'

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
if [ ! -e ca0 ] && [ -n "${ca0}" ] && [ -e ${ca0} ]; then
  cp ${ca0} ca0
fi
if [ ! -e cb0 ] && [ -n "${cb0}" ] && [ -e ${cb0} ]; then
  cp ${cb0} cb0
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
(time terachem ${QMINP}) >& ${QMOUT}

# -----------------------------------------------
# Save MOs for restart
#
if [ -e ${SCR}/c0 ]; then
  cp ${SCR}/c0 c0
fi
if [ -e ${SCR}/ca0 ]; then
  cp ${SCR}/ca0 ca0
  cp ${SCR}/cb0 cb0
fi

# Remove unnecessary files
#
rm -rf ${SCR}/${MOL}*
rm -rf ${SCR}/charge_mull.xls
rm -rf ${SCR}/esp.xyz
rm -rf ${SCR}/mullpop



