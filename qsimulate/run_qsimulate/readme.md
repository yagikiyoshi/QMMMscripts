# Script files to run QSimulate-QM/GENESIS

## Description
The files in this folder show how to run GENESIS/QSimulate-QM 
through singularity.  Singularity (ver 3.7 or newer) and Intel 
MPI are required to run the program.  

- genesis_qsimulate.sh  
  Set the license keys in the environment variables, `QSIMULATE_KEY` and 
  `QSIMULATE_VALUE`.  `mpirun -n XX sinularity exec QSimualte-QM.sif atdyn`
  invokes atdyn with XX MPI-processes.

