# Sample files for TeraChem/GENESIS

## Description
"terachem_xx.inp" are template files to generate input files for TeraChem.

GENESIS adds following options in the input file:

- `coordinates   JOBNAME_qm.xyz`  prints coordinates of a QM system to a file
- `pointcharges  JOBNAME_pc.xyz`  prints coordinates of point charges to a file
- `amber         yes           `  prints the energy without charge-charge interaction

Some relevant keywords to control TeraChem:
- `convthre     3.0e-05` is a SCF convergene criterion. It is scaled by 10 if SCF fails to converge.
- `resp         yes` is needed for macro/micro-iteration.
- `guess scr/c0` (for RHF and RKS) or `guess scr/ca0 scr/cb0` (for UHF and UKS) restart from MO of the previous step

## List of Contents
1. terachem_01.inp  
   Sample for minimization with macro/micro-iteration.

