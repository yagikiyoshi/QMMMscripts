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
#  Cluster in Wako uses Open MPI
#
#  OpenMPI without SGE Tight Integeration
. /home/mdsoft/mpi-selector/data/ib-openmpi-3.1.2_intel-18.0.1_cuda-9.1_cent7.sh

# ==============================================================
# Path to atdyn
#
GENESIS=/home/yagi/devel/genesis/genesis.gat_beluga/bin/atdyn

# ==============================================================
# Example1: 
# The following command runs GENESIS with 1 MPI process and 16 
# OMP thread parallel, and a QM job with 16 thread parallel. 
# This is typically the case for a minimize job.
#
export  QM_NUM_THREADS=16
export OMP_NUM_THREADS=16

# without UGE: requires a machine file
# mpirun -machinefile $TMP/machines -np 1 --map-by node:pe=${QM_NUM_THREADS} $GENESIS genesis_qmmm_min.inp >& genesis_qmmm_min.out

# with UGE
mpirun -np 1 --map-by node:pe=${QM_NUM_THREADS} $GENESIS genesis_qmmm_min.inp >& genesis_qmmm_min.out

# ==============================================================
# Example2:
# The following command runs GENESIS with 4 MPI processes and 4 
# OMP thread parallel, and QM jobs with 4 thread parallel each. 
# This is typically the case for a vibration job.
#
export  QM_NUM_THREADS=4
export OMP_NUM_THREADS=4

# without UGE: requires a machine file
#mpirun -machinefile $TMP/machines -np 4 --map-by node:pe=${QM_NUM_THREADS} $GENESIS genesis_qmmm_vib.inp >& genesis_qmmm_vib.out

# with UGE
mpirun -np 4 --map-by node:pe=${QM_NUM_THREADS} $GENESIS genesis_qmmm_vib.inp >& genesis_qmmm_vib.out

exit 0

