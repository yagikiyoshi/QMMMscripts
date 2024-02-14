# Script files to run Gaussian09/16.

## Description
GENESIS calls a script to run GAUSSIAN with three arguments as follow,

    > runGau.sh INPUT OUTPUT NSTEP

Given an input file in the 1st arg., the script produces an output file 
with a name given in the 2nd arg.  The 3rd arg. is the number of step 
in the simulation (the first step is 0).  "runGauXX_xxx.sh" in this 
folder are examples of such script files.

## List of Content

1. runGau01_standard.sh  
   Standard script to run GAUSSIAN. You need to modify the following for your system.

        # --- Set the path for Gaussian ---
        export g16root=/path/to/gaussian16     --> (1)
        export GAUSS_EXEDIR=$g16root/g16
        export GAUSS_EXEBIN=$g16root/g16/g16
        export PATH=$PATH:$GAUSS_EXEDIR
        export LD_LIBRARY_PATH=${GAUSS_EXEDIR}:${LD_LIBRARY_PATH}
        
        # --- Set the path for a scratch folder ---
        scratch=./  --> (2)
           	
        # (optional)
        # --- Set a checkpoint file to read initial MOs ---
        # initialchk='../path/to/initial.chk'  --> (3)

   (1) The folder where GAUSSIAN is installed. Change "g16" to "g09" for GAUSSIAN09.  
   (2) The folder where GAUSSIAN reads or writes scratch files.  
   (3) Optionally, the checkpoint file for an initial MO.  

2. runGau02_wako.sh  
   Script to run Gaussian09 in Sugita-lab's cluster in Wako.

3. runGau03_hokusai.sh  
   Script to run Gaussian09 in HOKUSAI supercomputer in RIKEN.

4. runGau04_hokusai.sh  
   Script to run Gaussian16 in HOKUSAI supercomputer in RIKEN.

5. runGau05_standard.sh  
   Script to always use the same initial MO for QM jobs. 

        # --- Set a checkpoint file to read initial MOs ---
        initialchk='../initial.chk'
        ...
        # -----------------------------------------------
        # Initial MO - Always retrieve the MO from $initialchk
        #
        cp ${initialchk} gaussian.chk

   It is useful for the PES generation in anharmonic vibrational 
   calculations.
  

