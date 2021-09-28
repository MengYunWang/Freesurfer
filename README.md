# Freesurfer
Learning notes of how to use freesurfer to analyze structural data
## 1. Organize the data into one folder
- See example ***T1\_organize.sh***
## 2. Execute preprocessing shell script
  
   ### 2.1 recon-all with parallell processing
   - Use the ***FS_preprocess.sh*** 
   - View the results with **freeview**
   ### 2.2 orgnaize the output data for the next step.
   - Creat three folders, FS, FSGD, Contrasts
   - Put all output data into FS
   - Creat [FSGD file](https://surfer.nmr.mgh.harvard.edu/fswiki/FsgdExamples) (.fsgd) under FSGD
   - Creat [Contrast file](https://surfer.nmr.mgh.harvard.edu/fswiki/FsgdExamples) (.mtx) under Contrasts


## 3. Execute postprocessing shell script

   ### 3.1 Concatnating all subfiles into one big file 
   with ***mris_preproc***
  
   ### 3.2 Fitting the general linear model 
   with ***mri_glmfit***
  
   ### 3.3 Cluster correction 
   with ***mri_glmfit-sim***
