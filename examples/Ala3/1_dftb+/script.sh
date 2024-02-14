
# QM_NUM_THREADS is for QM jobs, while OMP_NUM_THREADS is for atdyn.
# They are usually set to be equal.
#
export  QM_NUM_THREADS=16
export OMP_NUM_THREADS=16

# GENESIS (atdyn) and QM both run with 1 MPI x 16 threads
#
export PATH=/path/to/genesis-2.1/bin:$PATH
mpirun -np 1 -ppn 1 atdyn qmmm_min.inp >& qmmm_min.out
mpirun -np 1 -ppn 1 atdyn qmmm_nvt.inp >& qmmm_nvt.out

exit 0

