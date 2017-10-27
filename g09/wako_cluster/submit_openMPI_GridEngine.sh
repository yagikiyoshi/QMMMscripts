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
#$ -pe ompi 12
#$ -q kushana.q
######################################################
#

GENESIS=/home/yagi/devel/genesis/genesis.gat_qmmm_diva/bin/atdyn

export OMP_NUM_THREADS=12
mpirun -machinefile $TMP/machines -np 1 --map-by slot:pe=12 $GENESIS genesis_qmmm.inp >& genesis_qmmm.out

exit 0

