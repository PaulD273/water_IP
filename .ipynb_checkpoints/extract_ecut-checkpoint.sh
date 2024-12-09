#! /bin/bash

#Script that extract data from file with different vacuum sizes. Coupled to the main code vacuum.sh 

filedir=/home/paolo/water_2/vacuum_file

ec=25
alat="20 25 30 35 40 45"

#echo " Etot[Ry] ,  Ecut[Ry],   homo[eV],   convergence time" >> $filedir/energy_ecut.txt
for a in $alat
do
 label="vac${a}_ecut${ec}"
 file=$filedir/pw_${label}.out 
 # selects the penultimum field counted by awk
 #etot=`grep '!' $file | awk '{print $(NF-1)}'`
 conv_time=`grep 'PWSCF  ' $file | awk '{print $(NF-3)}'`
 homo=`grep 'highest occupied, lowest unoccupied level (ev):    ' $file | awk '{print $(NF-1)}'`
 echo  $a, $homo, $conv_time >> $filedir/energy_ecut.txt
done
exit 0