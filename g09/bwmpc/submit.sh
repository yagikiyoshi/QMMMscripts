#!/bin/sh
#------ pjsub option --------#
#PJM -L rscunit=bwmpc
#PJM -L vnode=4
#PJM -L vnode-core=40
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
   export KMP_AFFINITY=none

   GENESIS=/home/kyagi/devel/genesis/genesis.gat_qmmm/bin/atdyn
   mpirun -np 8 -ppn 2 $GENESIS genesis_qmmm.inp >& genesis_qmmm.out

# ==============================================================

   exit 0

