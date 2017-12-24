######################################################
# Batch file for running Genesis                     #
#                                    (SMP Parallel)  #
#   Written by K.Yagi                                #
#   Last modified  :   2015/08/31                    #
#
#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -N test_min
#$ -j y
#$ -pe ompi 16
#$ -q y2.q
######################################################
#

GENESIS=/home/yagi/devel/genesis/genesis.gat_qmmm_beluga/bin/atdyn

export  QM_NUM_THREADS=16
export OMP_NUM_THREADS=16
mpirun -machinefile $TMP/machines -np 1 --map-by slot:pe=${QM_NUM_THREADS} $GENESIS genesis_qmmm.inp >& genesis_qmmm.out

export  QM_NUM_THREADS=4
export OMP_NUM_THREADS=4
mpirun -machinefile $TMP/machines -np 4 --map-by slot:pe=${QM_NUM_THREADS}$GENESIS genesis_qmmm_vib.inp >& genesis_qmmm_vib.out

exit 0

