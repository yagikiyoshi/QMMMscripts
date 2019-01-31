# Script files to run GENESIS for QM/MM

## Description
"script_xx.sh" are examples to run/submit GENESIS for QM/MM calculations. QM/MM specific setting is,

- `QM_NUM_THREADS` The number of threads for QM jobs, which is referred in a script to run QM jobs.

One may also need to add flags in `mpirun` to invoke right number of MPI processes in each node,

- `--map-by node:pe=N` for Open MPI. N is the number of threads of QM jobs.
- `-ppn n` for Intel MPI. n is the number of processes in each node.

For example, let's say we have 16-core x 2 nodes and run 8-thread x 4 QM jobs. This means 
we want to run 2 QM jobs in each nodes. This can be done by,

    # Open MPI
    > export  QM_NUM_THREADS=8
    > mpirun -np 4 -map-by node:pe=8 atdyn INP >& OUT

and

    # Intel MPI
    > export  QM_NUM_THREADS=8
    > mpirun -np 4 -ppn 2 atdyn INP >& OUT

## List of Contents

1. script01_standard.sh  
  Standard script to run GENESIS

2. script02_wako.sh  
  Script to submit GENESIS in Sugita-lab's cluster in Wako.

3. script03_hokusai.sh  
  Script to submit GENESIS in HOKUSAI supercomputer in RIKEN.

