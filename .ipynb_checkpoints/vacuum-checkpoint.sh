#!/bin/bash

#Convergence of energy differences with respect to the energy cutoff.
#In this code we run the file with a stretched lattice parameter
#Based on ex.4 LABQSM Max

bindir=/home/paolo/QEdir/bin

jobdir=/home/paolo/water_2
filedir=$jobdir/scf_stretch_file

#alat0=6.7402778 with a 2% displacement
alat=6.875083356
#Percentage of stretch applied to the lattice param
stretch=2
k=8

ecut="20 40 60 80 100 120 140 160 180 200"

for ec in $ecut
do
  ecrho=$(($ec*4))

  label="nk${k}_stretch${stretch}_ecut${ec}"
  
  filein=$filedir/scf_${label}.in
  fileout=$filedir/scf_${label}.out

# generate output file

  cat > $filein <<EOF
  	
  &CONTROL
    prefix='diamond',
    calculation = 'scf'
    restart_mode='from_scratch',
    pseudo_dir = '/home/paolo/LABQSM/pseudo/'
    outdir = './SCRATCH'
    tprnfor=.true.
  /
  &SYSTEM
    ibrav = 2,
    celldm(1) = $alat
    nat = 2,
    ntyp = 1,
    ecutwfc =  $ec
    ecutrho = $ecrho
  /
  &ELECTRONS
    mixing_mode = 'plain'
    mixing_beta = 0.7
    conv_thr =  1.0d-8
  /
  ATOMIC_SPECIES
   C   12.011   C.pz-vbc.UPF
  ATOMIC_POSITIONS (alat)
   C 0.00 0.00 0.00
   C 0.25 0.25 0.25
  K_POINTS {automatic}
   $k $k $k   0 0 0

EOF
 #running
 echo "Running $label"
 $bindir/pw.x < $filein > $fileout
done