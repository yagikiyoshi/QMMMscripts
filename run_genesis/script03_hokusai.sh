#!/bin/sh
#------ pjsub option --------#
#PJM -L rscunit=bwmpc
#PJM -L vnode=4
#PJM -L vnode-core=40
#PJM -L elapse=24:00:00
#PJM -g G1xxxx
#PJM -N qmmm
#PJM -j
#------- Program execution -------#

# ==============================================================
#  HOKUSAI with IntelMPI
#
#  Note: GENESIS needs to be complied with IntelMPI:
#  > ./configure FC=mpiifort CC=mpiicc

# ==============================================================
# Load Intel module
#
   module load intel
   export KMP_AFFINITY=none
   #  KMP_AFFINITY=none is needed for QM jobs to run in 
   #  thread parallel. This option must be used in a node-closed
   #  fashion, i.e., vnode-core=40 for bwmpc.

# ==============================================================
# Path to atdyn
#
   GENESIS=/home/kyagi/devel/genesis/genesis.gat_qmmm/bin/atdyn

# ==============================================================
# Example:
# The following command runs GENESIS with 8 MPI processes with 20 OMP 
# thread parallel, and QM jobs with 20 thread parallel each. This is 
# typically the case for a vibration job.
#
export  QM_NUM_THREADS=20
export OMP_NUM_THREADS=20
mpirun -np 8 -ppn 2 $GENESIS genesis_qmmm.inp >& genesis_qmmm.out

exit 0


