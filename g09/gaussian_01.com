%chk=gaussian.chk
%NProcShared=20
%mem=1gb
#P b3lyp/cc-pVDZ EmpiricalDispersion=GD3 
scf(conver=8) iop(4/5=100) NoSymm
Charge Force Prop=(Field,Read) pop=mk

Gaussian run for QMMM in genesis

0 1
#coordinate#
#charge#
#elec_field#

