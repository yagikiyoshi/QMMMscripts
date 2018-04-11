#
# An example to run 2 replicas (= MPI processes) in GENESIS each with 
# a QM job in 8-thread parallel, using 2 nodes of 8-core machine.

# Path to atdyn
#
GENESIS=${HOME}/pgm/genesis/bin/atdyn

# QM_NUM_THREADS is for QM jobs, while OMP_NUM_THREADS is for atdyn.
# They are usually equal except for some special types of test.
#
export  QM_NUM_THREADS=8
export OMP_NUM_THREADS=8


# 1) Open MPI
#    "--map-by slot:pe=N" is needed for a child process (i.e., a QM job) to 
#    run in N-thread parallel. With this command, atdyn runs in 2 nodes.
#    Note that "-npernode 1" is not needed (it actually causes an error).
#
mpirun -np 2 --map-by slot:pe=${QM_NUM_THREADS} $GENESIS qmmm.inp >& qmmm.out

# 2) Intel MPI
#    "-ppn 1" is needed to specify that 1 replica runs in 1 node. With
#    this command, atdyn runs in 2 nodes.
#
mpirun -np 2 -ppn 1 $GENESIS genesis_qmmm.inp >& genesis_qmmm.out

exit 0

