#! /bin/bash
# Created by M.-Y. WANG 30-AUG-2021

filepath=/Users/wang/Desktop/BBSC/Functional/
cd $filepath
mkdir ./anat

ls ./Morning | grep -i sub- > ./anat/subjList.txt # command grep is trying to filter the input with 'sub-'. -i ignore the high or low cases 

for sub in `cat ./anat/subjList.txt`; do 
    mkdir ./anat/$sub
    ls ./Morning/$sub | grep -i ses- > ./anat/sesList.txt #list files with 'ses-' in sub directories to sesList.txt 
    for ses in `cat ./anat/sesList.txt`; do
        gunzip -k  ./Morning/$sub/$ses/anat/*.gz # unpack the .gz file with gunzip and keep the .gz file
        mv ./Morning/$sub/$ses/anat/*.nii ./anat/$sub/ #-x means extraction, -v visible in terminal, -f file name, -c extract to the folder you want
    done
done
