## Script to run Gaussian09/16.

1. runGau01_standard.sh  
  Standard script to run GAUSSIAN. You need to modify 
  the following for your system.

   - The folder where Gaussian is installed.  
       line  7: export g09root=/usr/local/gaussian

   - The folder where Gaussian reads or writes scratch files.  
       line 14: scratch=./

   - Optionally, the initial MO.
       line 18: initialchk='../initial.chk'

2. runGau02_wako.sh  
  Script to run Gaussian09 in Sugita-lab's cluster in Wako.

3. runGau03_hokusai.sh  
  Script to run Gaussian09 in HOKUSAI supercomputer in RIKEN.

4. runGau04_hokusai.sh  
  Script to run Gaussian16 in HOKUSAI supercomputer in RIKEN.

5. runGau05_standard.sh  
  Script to always use the same initial MO for QM jobs. 
  It is useful for a PES generation in anharmonic vibrational 
  calculations.
  
