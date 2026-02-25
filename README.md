**Motor Oddball Task EEG Analysis Pipeline
**

This repository contains the full EEG analysis pipeline for a motor oddball task, covering preprocessing, ERP extraction, time-frequency analysis, statistical modeling, and figure generation. This code accompanies the paper:

Malan et al., 2025 – Neural mechanisms of motor and cognitive processing revealed using EEG and neural modeling.
PubMed: https://pubmed.ncbi.nlm.nih.gov/40372092/

Step 1: MATLAB Preprocessing

Script: Matlab code/Oddball_Griptask_all_subjects.m

Preprocess EEG, DBS, EMG, and force recordings.

Artifact removal, surface Laplacian (SCD), trial alignment.

Saves clean datasets for downstream analysis.

Requirements: MATLAB R2020a+, FieldTrip, EEGLAB

Step 2: Clean and Standardize Data

Script: Matlab code/Data_clean_Save.m

Compute SCD (or CMA).

Redefine trials based on task events.

Filter, baseline-correct, standardize, and artifact-clean EEG.

Normalize hemispheres (affected hand → left).

Input: data_eogclean_ALL*.mat
Output: data_cleanimplant.mat, data_cleanexplant.mat

Step 3: ERP Plots (Figure 2)

Notebook: Notebook/Oddball_final_plots.ipynb

Load cleaned EEG/DBS/EMG data.

Separate trials into Oddball vs Standard and Error vs No Error.

Compute trial-averaged ERPs per electrode or selected electrodes (CP1, CP2, Cz, Pz).

Apply smoothing, compute SEM, and plot time-series ERPs & topographies.

Compare responders vs non-responders.

Output: Figure 2 – ERP curves and scalp maps.
Dependencies: Python 3, MNE-Python, NumPy, SciPy, Matplotlib, Seaborn

Step 4: Average ERDS Plots (Figures 3 & 4)

Notebook: Oddball_ERDS_avg_plots.ipynb

Load preprocessed EEG & DBS epochs per subject/condition.

Separate trials into Error (E) and No Error (NE).

Compute TFRs (1–30 Hz) using Morlet wavelets, crop -1.5 to 4 s.

Apply baseline normalization and average across responders/non-responders and channels.

Compute ERDS differences (Oddball − Standard).

Generate Figures 3 & 4: averaged ERDS plots per condition/group.

Input: Oddball Data/EDEN/ANALYSIS/data_clean.mat
Output: Results/TFR_.fif, ERDS plots per region/group
Dependencies: mne, mne-connectivity, numpy, matplotlib, pandas, seaborn
