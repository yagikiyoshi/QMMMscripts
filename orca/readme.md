# Sample files for ORCA/GENESIS

## Important Notice
As of today (Oct. 2023), the only parallel run mode of ORCA is MPI. However,
this feature causes some limitations in the usage because calling an MPI 
parallelized program (ORCA) from another MPI parallelized program (GENESIS) 
is not feasible. Therefore, one need to choose which program you would like 
to use the MPI. If you want to use it in orca, you need to compile GENESIS
without MPI, i.e.,

    ./configure --disable-mpi

Note that, in this case, you cannnot use replica-parallel jobs such as REMD.
If you choose MPI in GENESIS, ORCA jobs run using single core.


## Description
Template files to generate input files for ORCA

The following information is added to the file by GENESIS.

- Coordinates of QM atoms  
  The template file must have this line

      *xyzfile 0 1

  On runtime, GENESIS generates a xyz file and adds the file name at the 
  end of this line like this

      *xyzfile 0 1 jobXXXX_qm.xyz

- Point charges  
  The entry is added by GENESIS

      %pointcharges "jobXXXX_pc.xyz"

## List of Contents
1. orca_01.inp  
  Sample for minimization with macro/micro-iteration. 
  CHELPG charges are used for the QM charges.

2. orca_02.inp  
  Sample for vibrational calculations.

3. orca_03.inp  
  Sample for energy calc. without force. This is used for generating 
  grid potential in anharmonic calc. 

