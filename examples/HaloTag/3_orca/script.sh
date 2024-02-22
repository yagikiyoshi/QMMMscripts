
# Here we use GENESIS (atdyn) complied with "--disable-mpi" option,
# and leave the MPI for ORCA.
#
export PATH=/path/to/genesis-2.1_nompi/bin:$PATH
atdyn qmmm_nvt.inp >& qmmm_nvt.out

exit 0

