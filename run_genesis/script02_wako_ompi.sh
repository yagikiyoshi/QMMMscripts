######################################################
# Batch file for Univa Grid Engine
#
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -N test_qmmm
#$ -j y
#$ -pe ompi 16
#$ -q y2.q
######################################################
#
# ==============================================================
# Wako clusters with OpenMPI
#
. /home/mdsoft/mpi-selector/data/eth-openmpi-4.1.5_intel-23.1.0_cuda-12.1_rockylinux8.sh

# ==============================================================
# Path to atdyn
#
GENESIS=/home/yagi/devel/genesis/genesis2xx_pepper_openmpi-4.1.5_intel-23.1/bin/atdyn

# ==============================================================
# Example1: 
# The following command runs GENESIS with 1 MPI process and 16 
# OMP thread parallel, and a QM job with 16 thread parallel. 
# This is typically the case for a minimize job.
#
export  QM_NUM_THREADS=16
export OMP_NUM_THREADS=16

mpirun -np 1 --map-by node:pe=${QM_NUM_THREADS} $GENESIS genesis_qmmm.inp >& genesis_qmmm.out

# ==============================================================
# Example2:
# The following command runs GENESIS with 4 MPI processes and 4 
# OMP thread parallel, and QM jobs with 4 thread parallel each. 
# This is typically the case for a vibration job.
#
export  QM_NUM_THREADS=4
export OMP_NUM_THREADS=4

mpirun -np 4 --map-by node:pe=${QM_NUM_THREADS} $GENESIS genesis_qmmm.inp >& genesis_qmmm.out

exit 0

