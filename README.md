Motor Oddball Task EEG Analysis Pipeline

This repository contains the complete analysis pipeline for EEG data acquired during a motor oddball task, including preprocessing, ERP extraction, time-frequency analysis, statistical modeling, and figure generation. This code accompanies the paper:

Malan et al., 2025
Neural mechanisms of motor and cognitive processing revealed using EEG and neural modeling.
PubMed: https://pubmed.ncbi.nlm.nih.gov/40372092/

Step 1: MATLAB Preprocessing Pipeline

Main script:

Matlab code/Oddball_Griptask_all_subjects.m

This script is the primary entry point for preprocessing EEG, DBS, EMG, and force recordings from the motor oddball task. It performs artifact removal, surface Laplacian transformation, trial alignment, preprocessing, and saves clean datasets for downstream analysis.
Requirements
Software:
MATLAB R2020a or newer
FieldTrip toolbox
EEGLAB toolbox

Step 2: Clean and Standardize Data

Script:

Matlab code/Data_clean_Save.m

Purpose:

Compute surface Laplacian (SCD) or optionally CMA.

Redefine trials based on task events.

Preprocess EEG (filtering, baseline correction) and standardize signals.

Remove artifacts.

Normalize hemispheres (affected hand → left).

Save cleaned datasets for analysis.

Input:
Output from Step 1: data_eogclean_ALL*.mat per subject and stage.

Output:
Cleaned files per subject and stage:

data_cleanimplant.mat

data_cleanexplant.mat

Step 3: Generate ERP Plots (Figure 2)

Notebook:

Notebook/Oddball_final_plots.ipynb

Purpose:

Load preprocessed and cleaned EEG/DBS/EMG data (data_clean*.mat).

Organize data per subject, stage, and hand (affected/non-affected).

Separate trials into “Oddball” vs “Standard” and “Error” vs “No Error” subsets.

Compute trial-averaged ERPs per electrode or across selected electrodes.

Apply moving average smoothing and compute SEM for visualization.

Plot ERPs over time and topographies for responders vs non-responders.

Key Steps:

Define channel dictionaries for each subject and stage.

Load epochs using mne.read_epochs_fieldtrip.

Set EEG reference, montage, and channel types.

Crop, filter, and equalize trial counts between conditions.

Compute mean and SEM ERPs for selected electrodes (CP1, CP2, Cz, Pz for Pe).

Plot:

Time-series ERP curves with shaded error bands.

Scalp topographies at defined time windows.

Output:

Figure 2 in the manuscript: ERP curves and topographic maps of Oddball vs Standard conditions for responders and non-responders.

Dependencies:

Python 3, MNE-Python, NumPy, SciPy, Matplotlib, Seaborn.
