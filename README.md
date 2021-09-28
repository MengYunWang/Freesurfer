# Freesurfer
Learning notes of how to use freesurfer to analyze structural data
## 1. Organize the data into one folder
## 2. Execute preprocessing shell script
  
   ### 2.1 recon-all with parallell processing
   - view the results with freeview
   ### 2.2 orgnaize the output data for the next step.
   - creat three folders, FS, FSGD, Contrasts
   - put all output data into FS
   - creat FSGD file (.fsgd) under FSGD
   - creat Contrast file (.mtx) under Contrasts
## 3. Execute postprocessing shell script

   ### 3.1 concatnating all subfiles into one big file with ***mris_preproc***
  
   ### 3.2 fitting the general linear model with ***mri_glmfit***
  
   ### 3.3 cluster correction with ***mri_glmfit-sim***
