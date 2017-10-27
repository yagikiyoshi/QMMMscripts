#!/bin/bash

# -----------------------------------------------
# restart from given log and Fchk file
# -----------------------------------------------

if [ -e ${MOL}.Fchk ]; then
   cp ${MOL}.Fchk gaussian.Fchk
   exit 0
fi

