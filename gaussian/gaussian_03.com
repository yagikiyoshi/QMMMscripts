%chk=gaussian.chk
%NProcShared=20
%mem=1gb
#P b3lyp/gen EmpiricalDispersion=GD3 
scf(conver=8) iop(4/5=100) NoSymm
Charge Force Prop=(Field,Read) pop=mk

Gaussian run for QMMM in genesis

0 1
#coordinate#
#charge#
1 2 3 4 5 6 9 10 11 12 0
cc-pVDZ
****
7 8 0
aug-cc-pVDZ
****

#elec_field#

