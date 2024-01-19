export QSIMULATE_KEY="xxxx"
export QSIMULATE_VALUE="xxxx"

export OMP_NUM_THREADS=8
mpirun -n 4 singularity exec QSimulate-QM.sif atdyn inp > out
