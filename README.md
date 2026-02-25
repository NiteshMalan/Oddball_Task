**Motor Oddball Task EEG Analysis Pipeline
**

This repository contains the EEG analysis pipeline for a motor oddball task, covering preprocessing, ERP extraction, time-frequency analysis, statistical modeling, and figure generation.

Reference:
Malan et al., 2025 – Neural mechanisms of motor and cognitive processing revealed using EEG and neural modeling
PubMed: 40372092

**Step 1: MATLAB Preprocessing
**

Script: Oddball_Griptask_all_subjects.m

Preprocess EEG, DBS, EMG, and force data.

Remove artifacts, apply surface Laplacian (SCD), align trials.

Saves clean datasets for downstream analysis.
Requirements: MATLAB R2020a+, FieldTrip, EEGLAB

**Step 1b: Clean & Standardize EEG Data
**

Script: Data_clean_Save.m

Compute SCD/CMA, redefine trials based on task events.

Filter, baseline-correct, standardize, and artifact-clean EEG.

Normalize hemispheres (affected hand → left).
Input: data_eogclean_ALL*.mat
Output: data_cleanimplant.mat, data_cleanexplant.mat

Step 2: Behavioral Analysis & Correlation (Figure 2)

Notebook: Oddball_Behavioral_analysis_Correlation.ipynb

Analyze force profiles, compute overshoot and reaction slopes.

Identify outlier trials and equalize trial counts across conditions.

Aggregate mean ± SEM, plot force profiles, highlight peaks.

Correlate error rates and slopes across subjects (responders vs non-responders).
Outputs: Force profiles (Fig. 1), behavioral metrics per subject
Dependencies: Python (MNE, NumPy, SciPy, Matplotlib, Seaborn, pandas)

**Step 3: ERP Plots (Figure 3)
**

Notebook: Oddball_final_plots.ipynb

Load cleaned EEG/DBS/EMG data.

Separate trials into Oddball vs Standard, Error vs No Error.

Compute trial-averaged ERPs, smooth, compute SEM, plot ERPs and topographies.

Compare responders vs non-responders.
Output: Figure 2 (ERP curves & scalp maps)
Dependencies: Python 3, MNE-Python, NumPy, SciPy, Matplotlib, Seaborn

**Step 4: Average ERDS Plots (Figures 4 & 5)
**

Notebook: Oddball_ERDS_avg_plots.ipynb

Load preprocessed EEG & DBS epochs per subject/condition.

Separate trials into Error (E) and No Error (NE).

Compute TFRs (1–30 Hz) using Morlet wavelets, crop -1.5 to 4 s.

Apply baseline normalization, average across responders/non-responders and channels.

Compute ERDS differences (Oddball − Standard), generate plots.
Input: data_clean.mat
Output: TFR_.fif, ERDS plots per region/group
Dependencies: mne, mne-connectivity, numpy, matplotlib, pandas, seaborn
