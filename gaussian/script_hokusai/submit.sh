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
#  GENESIS job with IntelMPI
#
   module load intel
   export OMP_NUM_THREADS=20
   export  QM_NUM_THREADS=${OMP_NUM_THREADS}
   export KMP_AFFINITY=none

#  Note: KMP_AFFINITY=none is needed for QM jobs to run in 
#  thread parallel. This option must be used in a node-closed
#  fashion, i.e., vnode-core=40 for bwmpc.

   GENESIS=/home/kyagi/devel/genesis/genesis.gat_qmmm/bin/atdyn

#  Note: GENESIS needs to be complied with IntelMPI:
#  > ./configure FC=mpiifort CC=mpiicc

   mpirun -np 8 -ppn 2 $GENESIS genesis_qmmm.inp >& genesis_qmmm.out

# ==============================================================

   exit 0

