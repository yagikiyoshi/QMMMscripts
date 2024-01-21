# Sample files for QSimulate-QM/GENESIS

## Description
A singularity image (QSimulate-QM.sif) is provided by QSimulate upon 
the purchase of the software.  The image includes GENESIS and 
QSimulate-QM, which are linked with dynamic libraries. Thus, "qmexe" is 
not required in the GENESIS input. 

The following files, "qsimulate_xx.json", are sample input files for 
QSimulate-QM.

## List of Contents
- qsimulate_01.json  
  Sample for DFTB3 calculations. "thresh=1.0e-7" leads to a better 
  performance than the default value (1.0e-8) without loss of accuracy.

- qsimulate_02.json  
  Sample for XTB calculations. "thresh=1.0e-7" leads to a better 
  performance than the default value (1.0e-8) without loss of accuracy.

- qsimulate_03.json  
  Sample for DFT calculations with PBE+D3 functional. "sparse=true" is
  recommended for pure functional.

- qsimulate_04.json  
  Sample for DFT calculations at the level of B3LYP+D3/aug-cc-pVDZ. "basis_link"
  specifies the basis set for link atoms. It is recommended NOT to add diffuse 
  basis sets to link atoms, since they often cause SCF conversion issues.

- qsimulate_05.json  
  Sample for RI-MP2 calculations.

- qsimulate_06.json  
  Sample for TD-DFT calculations with CAM-B3LYP+D3. "nstate=5" means to calculate 
  five electronic state, and "target=1" means to calculat the force of the first 
  excited states. "_opt" is needed to avoid the double calculation of the 
  reference energy. 

