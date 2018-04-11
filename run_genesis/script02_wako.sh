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
#  In OpenMPI, "--map-by slot:pe=N" is needed for a child process 
#  (i.e., a QM job) to run in N-thread parallel.

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
mpirun -machinefile $TMP/machines -np 1 --map-by slot:pe=${QM_NUM_THREADS} $GENESIS genesis_qmmm_min.inp >& genesis_qmmm_min.out

# ==============================================================
# Example2:
# The following command runs GENESIS with 4 MPI processes and 4 
# OMP thread parallel, and QM jobs with 4 thread parallel each. 
# This is typically the case for a vibration job.
#
export  QM_NUM_THREADS=4
export OMP_NUM_THREADS=4
mpirun -machinefile $TMP/machines -np 4 --map-by slot:pe=${QM_NUM_THREADS} $GENESIS genesis_qmmm_vib.inp >& genesis_qmmm_vib.out

exit 0

