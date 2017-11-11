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

export OMP_NUM_THREADS=16
mpirun -machinefile $TMP/machines -np 1 --map-by slot:pe=16 $GENESIS genesis_qmmm.inp >& genesis_qmmm.out

export OMP_NUM_THREADS=4
mpirun -machinefile $TMP/machines -np 4 --map-by slot:pe=4 $GENESIS genesis_qmmm_vib.inp >& genesis_qmmm_vib.out

exit 0

