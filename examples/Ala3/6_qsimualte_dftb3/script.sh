
# Set the license keys provided by QSimulate Inc.
#
export QSIMULATE_KEY="xxxx"
export QSIMULATE_VALUE="xxxx"

# GENESIS (atdyn) and QSimulate-QM run with 4 MPI x 8 threads
#
export OMP_NUM_THREADS=8
mpirun -n 4 singularity exec QSimulate-QM.sif atdyn inp > out
