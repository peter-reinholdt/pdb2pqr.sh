#!/bin/bash
PDB=$1
BASE=$(echo $PDB | sed s/.pdb//)
cat << EOF > ${BASE}_leap.in
source leaprc.protein.ff14SB
pdb = loadpdb $BASE.pdb
check pdb
saveamberparm pdb $BASE.prmtop $BASE.inpcrd
quit
EOF
tleap -f ${BASE}_leap.in && rm ${BASE}_leap.in  && ambpdb -pqr -c $BASE.inpcrd -p $BASE.prmtop > $BASE.pqr && rm $BASE.prmtop $BASE.inpcrd leap.log
