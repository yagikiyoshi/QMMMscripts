# Script files to run DFTB+

## Description
GENESIS calls a script to run DFTB+ with three arguments as follow,

    > runDFTB.sh INPUT OUTPUT NSTEP

Given an input file in the 1st arg., the script produces an output file 
with a name given in the 2nd arg.  The 3rd arg. is the number of step 
in the simulation (the first step is 0).  "runDFTBXX_xxx.sh" in this 
folder are examples of such script files.

## List of Content

1. runDFTB01_standard.sh  
  Standard script to run DFTB+. You need to modify at least the following for your system.

        # -----------------------------------------------
        # Settings for DFTB+
        #
        # --- Set the path for DFTB+ ---
        export PATH=/path/to/dftbplus-18.1/_install/bin:$PATH  --> (1)

        # (optional) 
        # --- Set a file to read initial charges ---
        #initial='../charges.bin_save'  --> (2)

   (1) The folder where DFTB+ is installed.  
   (2) Optionally, a file to read initial charges

2. runDFTB02_wako.sh  
  Script to run DFTB+ in Sugita-lab's cluster in Wako.

