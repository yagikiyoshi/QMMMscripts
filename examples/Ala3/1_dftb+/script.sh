
# QM_NUM_THREADS is for QM jobs, while OMP_NUM_THREADS is for atdyn.
# They are usually set to be equal.
#
export  QM_NUM_THREADS=16
export OMP_NUM_THREADS=16


# 1) Open MPI
#
#mpirun -np 1 --map-by node:pe=${QM_NUM_THREADS} atdyn qmmm_min.inp >& qmmm_min.out
#mpirun -np 1 --map-by node:pe=${QM_NUM_THREADS} atdyn qmmm_nvt.inp >& qmmm_nvt.out

# 2) Intel MPI
#
mpirun -np 1 -ppn 1 atdyn qmmm_min.inp >& qmmm_min.out
mpirun -np 1 -ppn 1 atdyn qmmm_nvt.inp >& qmmm_nvt.out

exit 0

