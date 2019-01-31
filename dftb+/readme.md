# Sample files for DFTB+/GENESIS

## Description
"dftb_xx.hsd" are template files to generate input files for DFTB+

The following options are added by GENESIS.

- Geometry
- ElectricField

Note that the program stops with error if these options are 
present in the template.

## List of Contents
dftb_01.hsd  
  Sample for minimization with macro/micro-iteration. Self-consistent
  charges are used for macro-iteration. ReadInitialCharges is used 
  for restarting the charge.

dftb_02.hsd  
  Sample for writing the charges in text. ReadChargesAsText is
  needed for restarting the charge.
