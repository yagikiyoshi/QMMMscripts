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
- `guess        c0` (or `guess        c0a c0b` for UHF/UKS) restarts from MO of the previous step

## List of Contents
1. terachem_01.inp  
   Sample for minimization with macro/micro-iteration.
2. terachem_02.inp  
   Sample for QM/MM-MD. RESP is turned off.
3. terachem_03.inp  
   Sample for single point energy.
