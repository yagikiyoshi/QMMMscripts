## Script files to run ORCA

## Description
GENESIS calls a script to run ORCA with three arguments as follow,

    > runORCA.sh INPUT OUTPUT NSTEP

Given an input file in the 1st arg., the script produces an output file 
with a name given in the 2nd arg.  The 3rd arg. is the number of step 
in the simulation (the first step is 0). 

## List of Content

1. runORCA01_standard.sh  
   Standard script to run ORCA. You need to modify the following for your system.

        # --- Set the path for ORCA ---
        ORCADIR=/path/to/orca_5_0_4_linux_x86-64_openmpi411   --> (1)
        export PATH=${ORCADIR}:${PATH}
        
        # --- Set the path for a scratch folder ---
        scratch=./  --> (2)
           	
        # (optional)
        # --- Set a checkpoint file to read initial MOs ---
        # initialchk='../moinp.gbw'  --> (3)

   (1) The folder where ORCA is installed.  
   (2) The folder where ORCA reads or writes scratch files.  
   (3) Optionally, the gbw file to restart MO.  

2. runORCA02_wako.sh  
   Script to run ORCA in Sugita-lab's cluster in Wako.

