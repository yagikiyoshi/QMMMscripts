######################################################
# Batch file for Grid Engine                         #
#
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -N test_min
#$ -j y
#$ -pe ompi 16
#$ -q y2.q
######################################################
#

# ==============================================================
#  GENESIS job with OpenMPI

GENESIS=/home/yagi/devel/genesis/genesis.gat_qmmm_beluga/bin/atdyn

# In OpenMPI, "--map-by slot:pe=N" is needed for a child process (i.e., a QM job) to 
# run in N-thread parallel.
#
# The following command runs GENESIS with 1 MPI process with 16 OMP thread parallel, and
# a QM job with 16 thread parallel. This is typically the case for a minimize job.
#
export  QM_NUM_THREADS=16
export OMP_NUM_THREADS=16
mpirun -machinefile $TMP/machines -np 1 --map-by slot:pe=${QM_NUM_THREADS} $GENESIS genesis_qmmm_min.inp >& genesis_qmmm_min.out

# ==============================================================
# The following command runs GENESIS with 4 MPI processes with 4 OMP thread parallel, and
# QM jobs with 4 thread parallel each. This is typically the case for a vibration job.
#
export  QM_NUM_THREADS=4
export OMP_NUM_THREADS=4
mpirun -machinefile $TMP/machines -np 4 --map-by slot:pe=${QM_NUM_THREADS} $GENESIS genesis_qmmm_vib.inp >& genesis_qmmm_vib.out

# ==============================================================

exit 0

