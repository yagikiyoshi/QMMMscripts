#!/bin/bash

# -----------------------------------------------
# Settings for ORCA
#
# --- Set the path for ORCA ---
. /home/mdsoft/mpi-selector/data/eth-openmpi-4.1.1_intel-21.4.0_cuda-11.4_rockylinux8.sh
ORCADIR=/home/yagi/pgm/orca_5_0_4_linux_x86-64_openmpi411
export PATH=${ORCADIR}:${PATH}

# --- Set the path for a scratch folder ---
scratch=/scr/$USER

# (optional)
# --- Set a gbw file to read initial MOs ---
#initialgbw='../moinp.gbw'

# -----------------------------------------------

QMINP=$1
QMOUT=$2
NSTEP=$3
MOL=${QMINP%.*}

# -----------------------------------------------
# Scratch file
#
QMDIR=$(pwd)
ORCA_SCRDIR=$scratch/$(mktemp -u $MOL.XXXX)
mkdir -p ${ORCA_SCRDIR}

cp ${QMINP}  $ORCA_SCRDIR
cp *.xyz     $ORCA_SCRDIR

# -----------------------------------------------
# Initial MO
#
# The initial MO is copied only for the 1st step
# in MD.
#
moinp=$(grep -i moinp $QMINP |awk '{print $2}' |sed 's/"//g')
if [ -n "${moinp}" ]; then
  if [ $NSTEP -eq 0 ]; then
    if [ -n "${initialgbw}" ] && [ -e ${initialgbw} ]; then
      cp ${initialgbw} $ORCA_SCRDIR/${moinp}
    else
      aa=$(mktemp -u ${QMINP}.XXXX)
      grep -i -v guess ${QMINP} > $aa
      grep -i -v moinp $aa      > ${QMINP}
      rm $aa
      cp ${QMINP}  $ORCA_SCRDIR
    fi
  else
    cp ${moinp} $ORCA_SCRDIR
  fi
fi

cd $ORCA_SCRDIR

# -----------------------------------------------
# Now run ORCA
#
(time ${ORCADIR}/orca $QMINP) > ${QMDIR}/${QMOUT} 2>&1

# -----------------------------------------------
# Save necessary data and remove others
#
if [ -e $MOL.engrad ]; then
  cp $MOL.engrad ${QMDIR}
  cp $MOL.pcgrad ${QMDIR}
fi
if [ -n "${moinp}" ]; then
  cp $MOL.gbw ${QMDIR}/${moinp}
fi

rm -rf $ORCA_SCRDIR

