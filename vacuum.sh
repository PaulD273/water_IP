#!/bin/bash

#Convergence of energy differences with respect to the vacuum size.

bindir=/home/paolo/QEdir/bin

jobdir=/home/paolo/water_2
filedir=$jobdir/vacuum_file

ec=25
alat="20 25 30 35 40 45"

for a in $alat
do

  label="vac${a}_ecut${ec}"
  
  filein=$filedir/pw_${label}.in
  fileout=$filedir/pw_${label}.out

# generate input file

  cat > $filein <<EOF
  	
  &CONTROL
    prefix='water',
    calculation = 'scf'
    restart_mode='from_scratch',
    pseudo_dir = '/home/paolo/water_2/pp'
    outdir = '/home/paolo/water_2/vacuum_file'
  /
  &SYSTEM
    ibrav           = 1
    celldm(1)       = $a
    nat             = 3
    ntyp            = 2
    nbnd            = 10
    ecutwfc         = $ec
    assume_isolated ='mp'
  /
  &electrons
    diago_full_acc = .TRUE.
/
ATOMIC_SPECIES
H  1.00794   H_ONCV_PBE-1.2.upf
O 15.999 O_ONCV_PBE-1.2.upf
ATOMIC_POSITIONS angstrom
O                2.0117535901        2.4187291367        0.0157800323
H                3.0568614517        2.3127773482       -0.0083151813
H                1.7671549581        1.4228935152       -0.2087748510
K_POINTS {gamma}

EOF
 #running
 echo "Running $label"
 $bindir/pw.x < $filein > $fileout
done