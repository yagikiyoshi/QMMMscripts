#
# An example to run 4 replicas (= MPI processes) of QM jobs each in 8-thread 
# parallel using 2 nodes of 8-core x 2-cpu machine. We want to have 2 QM jobs
# running in each node.

# Path to atdyn
#
GENESIS=${HOME}/pgm/genesis/bin/atdyn

# QM_NUM_THREADS is for QM jobs, while OMP_NUM_THREADS is for atdyn.
# They are usually set to be equal.
#
export  QM_NUM_THREADS=8
export OMP_NUM_THREADS=8


# 1) Open MPI
#    "--map-by node:pe=8" specifies that 8-thread is assigned to each MPI process. 
#    Together with "-np 4", GENESIS runs in 2 nodes. 
#
#    Note that "--map-by ppr:2:node" (equivalent to "-npernode 2") may or may not map 
#    sufficient number of threads for QM jobs. Therefore, "--map-by node:pe=8" is 
#    recommended.
#
mpirun -np 4 --map-by node:pe=${QM_NUM_THREADS} $GENESIS genesis_qmmm.inp >& genesis_qmmm.out

# 2) Intel MPI
#    "-ppn 2" specifies that each node have 2 MPI processes. Together with "-np 4", 
#    GENESIS runs in 2 nodes. 
#
mpirun -np 4 -ppn 2 $GENESIS genesis_qmmm.inp >& genesis_qmmm.out

exit 0

