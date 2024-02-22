%chk=gaussian.chk
%NProcShared=20
%mem=1gb
#P b3lyp/cc-pVDZ EmpiricalDispersion=GD3 
scf(conver=8) iop(4/5=100) NoSymm
TDA=(singlets,root=1,nstates=5)
Charge Force Prop=(Field,Read) 

Gaussian run for QMMM in genesis

1 1
#coordinate#
#charge#
#elec_field#

