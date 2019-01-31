## Script files to run Q-Chem

## Description
GENESIS calls a script to run Q-Chem with three arguments as follow,

    > runGau.sh INPUT OUTPUT NSTEP

Given an input file in the 1st arg., the script produces an output file 
with a name given in the 2nd arg.  The 3rd arg. is the number of step 
in the simulation (the first step is 0).  "runqchemXX_xxx.sh" in this 
folder are examples of such script files.

## List of Content

1. runqchem01_standard.sh  
   Standard script to run Q-Chem4.x. You need to modify the following for your system.

        # --- Set the path for Q-Chem ---
        export QC=/usr/local/qchem          --> (1)
        export QCAUX=$QC/qcaux
        export QCSCRATCH=$(pwd)
        . $QC/qcenv.sh
        export PATH=$QC/bin:$QC/exe:${PATH}
        
        # --- Set the path for a scratch folder ---
        scratch=./  --> (2)
        
        # (optional) 
        # --- Set a folder where initial MOs are stored ---
        #initial='../initial_save'    --> (3)

   (1) The folder where Q-Chem is installed.  
   (2) The folder where Q-Chem reads or writes scratch files.  
   (3) Optionally, the folder where initial MOs are stored. 

2. runqchem02_wako.sh  
   Script to run Q-Chem4.4 in Sugita-lab's cluster in Wako.

