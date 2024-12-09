#! /bin/bash

#Script that extract data from file with different wfc cutoff energies and stretched lattice parameter. Coupled to the main code ediff.sh 

filedir=/home/paolo/water_2/ediff_file

alat=30.6

ecut="20 25 30 35 40 60 80 100"

#echo " Etot[Ry] ,  Ecut[Ry],   homo[eV],   convergence time" >> $filedir/energy_ecut.txt
for ec in $ecut
do
 label="vac${alat}_ecut${ec}"
 file=$filedir/pw_${label}.out 
 # selects the penultimum field counted by awk
 #etot=`grep '!' $file | awk '{print $(NF-1)}'`
 conv_time=`grep 'PWSCF  ' $file | awk '{print $(NF-3)}'`
 homo=`grep 'highest occupied, lowest unoccupied level (ev):    ' $file | awk '{print $(NF-1)}'`
 echo  $ec, $homo, $conv_time >> $filedir/energy_ecut.txt
done
exit 0