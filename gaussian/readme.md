# Sample files for Gaussian/GENESIS

## Description
"gaussian_xx.com" are template files to generate input files for Gaussian09/16.

GENESIS requires following flags in a template file:

- `%chk=gaussian.chk` The checkpoint file is always gaussian.chk.
- `#coordinate#` is replaced by the coordinates of QM atoms.  
- `#charge#` is replaced by the coordinates of MM charges.   
- `#elec_field#` is replaced by the coordinates of MM charges to calculate the electric field. 

Some relevant keywords to control GAUSSIAN.

- `scf(conver=N)` sets a SCF convergence criterion to 10^-N. N will be reduced when the QM calculation failed.
- `iop(4/5=100)` reads initial guess from a checkpoint file if the previous MOs exist.
- `NoSymm` prevents a re-orientation of coordinates.
- `Charge` reads and places points charges.
- `Force` calculates gradient.
- `Prop=(Field,Read)` calculates the electric field.

## List of Contents

1. gaussian_01.com  
  Sample for minimization. Macro/micro-iteration scheme requires `pop=mk`.

2. gaussian_02.com  
  Sample for vibrational calculations.

3. gaussian_03.com  
  Sample for using customized basis sets `gen`. The basis sets 
  must be between `#charge#` and `#elec_field#`.

4. gaussian_04.com  
  Sample for energy calc. without force. This is used for generating 
  grid potential in anharmonic calc. Note that `#elec_field#` is still
  needed even without `Prop=(Field,Read)`.

