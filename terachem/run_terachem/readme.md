# Script files to run TeraChem

## Description
GENESIS calls a script to run TeraChem with three arguments as follow,

    > runTC.sh INPUT OUTPUT NSTEP

Given an input file in the 1st arg., the script produces an output file 
with a name given in the 2nd arg.  The 3rd arg. is the number of step 
in the simulation (the first step is 0).  "runTCXX_xxx.sh" in this 
folder are examples of such script files.

## List of Content

1. runTC01_standard.sh  
  Standard script to run TeraChem. You need to modify at least the following for your system.

        # -----------------------------------------------
        # Settings for TeraChem
        #
        # --- Set the path for TeraChem ---
        export TeraChem=/path/to/terachem1.93P/TeraChem   --> (1)
        export NBOEXE=/path/to/terachem1.93P/TeraChem/bin/nbo6.i4.exe
        export LD_LIBRARY_PATH=/path/to/terachem1.93P/TeraChem/lib:$LD_LIBRARY_PATH
        export PATH=/path/to/terachem1.93P/TeraChem/bin:$PATH
        
        # GPU settings
        #
        export CUDA_VISIBLE_DEVICES="0,1"   --> (2)
        
        # (optional) 
        # --- Absolute path to initial MOs ---
        #c0='/home/mo/initial.c0' --> (3)

   (1) The folder where TeraChem is installed.  
   (2) The number and ID of GPU to use in this calculations.  
   (3) Optionally, absolute path to the initial MO  

2. runTC02_wako.sh  
   Script to run TeraChem in Sugita-lab's cluster in Wako.

