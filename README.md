# Freesurfer
Learning notes of how to use freesurfer to analyze structural data
## 1. Organize the data into one folder
- See example _T1\_organize.shell_
## 2. Execute preprocessing shell script
  
   ### 2.1 recon-all with parallell processing
   - view the results with freeview
   ### 2.2 orgnaize the output data for the next step.
   - creat three folders, FS, FSGD, Contrasts
   - put all output data into FS
   - creat FSGD file (.fsgd) under FSGD
   - creat Contrast file (.mtx) under Contrasts
## 3. Execute postprocessing shell script

   ### 3.1 Concatnating all subfiles into one big file 
   with ***mris_preproc***
  
   ### 3.2 Fitting the general linear model 
   with ***mri_glmfit***
  
   ### 3.3 Cluster correction 
   with ***mri_glmfit-sim***
