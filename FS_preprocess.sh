#! /bin/bash
# created by M.Y. WANG 30-AUG-2021

# to check how many cores in CPU,use the logicalcup number:
sysctl hw.physicalcpu hw.logicalcpu #the results should like the following   
#hw.physicalcpu: 4
#hw.logicalcpu: 8

# to install parallel, but first need to install Xcode and Homebrew
brew install parallel 

# to check which shell you are working in
echo $0

# to creat variables, especially the SUBJECTS_DIR
export FREESURFER_HOME=/Applications/freesurfer/7.2.0
export SUBJECTS_DIR=/Users/wang/Desktop/BBSC/Functional/anat/sub-1
#setenv SUBJECTS_DIR `pwd`
source $FREESURFER_HOME/SetUpFreeSurfer.sh

# run the main commandline
cd SUBJECTS_DIR

ls *.nii | parallel --jobs 8 recon-all \  #parallel processing the data using 8 cores
                                 -i {} \  #files need to be processed
                                 -s {.} \ #directory names under SUBDIR
                                 -all \   #do all things
                                 -qcache  #use different smooth parameter, like 0 10 20


# use freeview to look at the results
freeview -v mri/orig.mgz mri/aseg.mgz:colormap=LUT\  # -v means volume
         -f surf/lh.pial:edgecolor=yellow            # -f means surface
# demo: https://inespereira.com/post/freeview/




# organize the directories for further analysis
mkdir $SUBJECTS_DIR/FS $SUBJECTS_DIR/FSGD $SUBJECTS_DIR/Contrasts # creat three folders
cp -R $FREESURFER_HOME/subjects/fsaverage $SUBJECTS_DIR           # cope fsaverage into SUBDIR
mv $SUBJECTS_DIR/*T1w $SUBJECTS_DIR/FS                            # move all recon-all directories into FS folder
#cp ../particpants.tsv FSGD/CannabisStudy.tsv.                    #copy or creat FSGD file including particpants variable
                                                                    # like age, onset age, group in FSGD directory
# to creat FSGD file, see example https://surfer.nmr.mgh.harvard.edu/fswiki/FsgdExamples 
                                # https://andysbrainbook.readthedocs.io/en/latest/FreeSurfer/FS_ShortCourse/FS_07_FSGD.html 
cd $SUBJECTS_DIR/FSGD
echo GroupDescriptorFile 1'\n'Title Development'\n'Class Elder'\n'Class Young'\n'Variables Age Weight \
     '\n'Input sub-1 Young 30 100'\n'Input sub-2 Elder 70 120 > Development_study.txt #two groups with two covariaes
tr '\r' '\n' < Development_study.txt > Development_Study.fsgd   # This will remove any DOS carriage returns, which Unix cannot interpret, 
                                                               # and replaces them with newline characters. This will prevent any errors 
                                                               # when using the FSGD file with FreeSurfer commands.
# to creat contrast file 
cd $SUBJECTS_DIR/Contrasts                                               # navigate to contrast and creat contrast file
echo "1 -1 0 0 0 0" > group.diff.mtx #creat contrast between two groups without covariaes
echo "0 0 -1 1 0 0" > group-x-age.mtx #Null Hypothesis: is there a difference between the group age slopes regressing out the effect of weight? 
                                      #Note: this is an interaction between group and age. 
echo "0 0 0 0 1 -1" > group-x-weight.mtx #Null Hypothesis: is there a difference between the group weight slopes regressing out the effect of age? 
                                      #Note: this is an interaction between group and weight. 
echo "0 0 1 -1 0 0"'\n'"0 0 0 0 1 -1" > group-x-age-x-weight.mtx #Null Hypothesis: does Group1 differ from Group2 in age or weight? Is there an interaction between group, age, and weight?
                                      #Note: this is an F-test (and hence unsigned). Reversing the signs will have no effect.                                       
echo "0.5 0.5 0 0 0 0" > g1g2.intercept.mtx #does mean of group intercepts differ from 0
                                      #Note: This is a t-test with (Group1+Group2)/2 > 0 being positive (red/yellow). If the mean is < 0, then it will be displayed in blue/cyan.
echo "0 0 0.5 0.5 0 0" > g1g2.age.mtx #does mean of group age slope differ from 0? Is there an average affect of age regressing out the effect of group and weight?
                                      #Note: This is a t-test with (Group1+Group2)/2 > 0 being positive (red/yellow). If the mean is < 0, then it will be displayed in blue/cyan.


# post processing the data:
# 1. Creating a group file with mris_preproc
# 2. Fitting the general linear model with mri_glmfit
# 3. Cluster Correction with mri_glmfit-sim