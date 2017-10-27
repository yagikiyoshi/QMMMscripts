#!/bin/sh
#------ pjsub option --------#
#PJM -L rscunit=bwmpc
#PJM -L rscgrp=gaussian
#PJM -L vnode=1
#PJM -L vnode-core=20
#PJM -L elapse=24:00:00
#PJM -g G17024
#PJM -N qmmm
#PJM -j
#------- Program execution -------#

# ==============================================================
# Now execute Genesis
#
   module load intel
   export OMP_NUM_THREADS=20

   GENESIS=/home/kyagi/devel/genesis/genesis.gat_qmmm/bin/atdyn
   mpirun -np 1 $GENESIS genesis_qmmm_min.inp >& genesis_qmmm_min.out

# ==============================================================

   exit 0

