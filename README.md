# Freesurfer
Learning notes on how to use freesurfer to analyze structural data
## 1. Organize the data into one folder
- See example ***T1\_organize.sh***
## 2. Execute preprocessing shell script
  
   ### 2.1 recon-all with parallel processing
   - Use the ***FS_preprocess.sh*** 
   - View the results with **freeview**
   ### 2.2 orgnaize the output data for the next step.
   - Create three folders, FS, FSGD, Contrasts
   - Put all output data into FS
   - Creat [FSGD file](https://surfer.nmr.mgh.harvard.edu/fswiki/FsgdExamples) (.fsgd) under FSGD
   - Creat [Contrast file](https://surfer.nmr.mgh.harvard.edu/fswiki/FsgdExamples) (.mtx) under Contrasts


## 3. Execute postprocessing shell script

   ### 3.1 Concatenating all subfiles into one big file 
   with ***mris_preproc***
  
   ### 3.2 Fitting the general linear model 
   with ***mri_glmfit***
  
   ### 3.3 Cluster correction 
   with ***mri_glmfit-sim***
   
## 4. Folders meaning
[Introduction to Freesurfer Output](https://surfer.nmr.mgh.harvard.edu/fswiki/FsTutorial/OutputData_freeviewV6.0)

Video [Part I](https://www.youtube.com/watch?v=8Ict0Erh7_c)    [Part II](https://www.youtube.com/watch?v=KncPouQWAp0) 

? was often used to represent left or right
### label:
It includes labels of several brain atlas, such as 

?h.apar.DKTatlas.annot  >>> Desikan-Killiany atlas

?h.aparc.a2009s.annot >>> Destrieax atlas

### MRI:
compasses all the volume data

raw_avg.mgz >>> the raw volume data in raw space resolution

others >>> in the normalized space

### scripts:
it contains the scripts or logs when it goes through processing

recon-all.log  >>> the log file you can go through if there is something wrong

### stats:
contains the statistics of the brain, such as the thickness or volume of different brain regions.

### surf:
includes all the surface files

?h.orig & ?h.white >>> the boundary between the white matter and the grey matter

?h.pial >>> the boundary between the grey matter and the pia matter

?h.inflated >>> inflated brain 

?h.thickness or ?h.volume >>> values of the thickness or volume projected onto the inflated brain

## 5. conversation between MNI space and surface space
### 5.1 freesurf (Affine and MNIsurf)

***mri_vol2surf***   ***mri_surf2vol*** ***mri_surf2surf***
https://github.com/ThomasYeoLab/CBIG/tree/master/stable_projects/registration/Wu2017_RegistrationFusion/freesurfer_baseline/utilities

### 5.2 Registration fusion (RF-M3Z and RF-ANTs)
https://github.com/ThomasYeoLab/CBIG/tree/master/stable_projects/registration/Wu2017_RegistrationFusion

Wu J, Ngo GH, Greve DN, Li J, He T, Fischl B, Eickhoff SB, Yeo BTT. Accurate nonlinear mapping between MNI volumetric and FreeSurfer surface coordinate systems, Human Brain Mapping 39:3793–3808, 2018.

**The two methods mentioned above can only convert the data from the MNI to fsaverage, and within fsaverage, but can not project into fsLR format.**

### 5.3 neuromap
Markello, RD, Hansen, JY, Liu, ZQ, Bazinet, V, Shafiei, G, Suarez, LE, Blostein, N, Seidlitz, J, Baillet, S, Satterthwaite, TD, Chakravarty, MM, Raznahan, A, Misic, B. (2022). neuromaps: structural and functional interpretation of brain maps. Nature Methods. doi:10.1038/s41592-022-01625-w

https://netneurolab.github.io/neuromaps/user_guide/atlases.html
