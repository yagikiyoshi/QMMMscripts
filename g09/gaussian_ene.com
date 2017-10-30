%chk=SCRDIR/gaussian.chk
%NProcShared=20
%mem=1gb
#P b3lyp/cc-pVTZ EmpiricalDispersion=GD3 NoSymm Charge iop(4/5=100)

Gaussian run for QMMM in genesis

-1 1
#coordinate#
#charge#
#elec_field#

