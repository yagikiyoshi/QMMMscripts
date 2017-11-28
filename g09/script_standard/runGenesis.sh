
GENESIS=/Users/kyagi/Work/devel/genesis/genesis.gat_qmmm/bin/atdyn

export OMP_NUM_THREADS=2
mpirun -np 1 $GENESIS genesis_qmmm.inp >& genesis_qmmm.out

exit 0

