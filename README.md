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
