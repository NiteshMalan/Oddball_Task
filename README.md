# Motor Oddball Task EEG Analysis Pipeline

This repository contains the EEG analysis pipeline for a **motor oddball task**, covering preprocessing, ERP extraction, time-frequency analysis, statistical modeling, and figure generation.


# 🧠 Pipeline Overview

The workflow consists of:

1. MATLAB preprocessing
2. EEG cleaning & standardization
3. Behavioral analysis
4. ERP analysis
5. Time-frequency (ERDS) analysis

---

# Step 1 — MATLAB Preprocessing

**Script:** `Oddball_Griptask_all_subjects.m`

This script:

* Preprocesses EEG, DBS, EMG, and force data
* Removes artifacts
* Applies surface Laplacian (SCD)
* Aligns trials
* Saves clean datasets for downstream analysis

**Requirements**

* MATLAB R2020a+
* FieldTrip
* EEGLAB

---

# Step 1b — Clean & Standardize EEG Data

**Script:** `Data_clean_Save.m`

This step:

* Computes SCD / CMA
* Redefines trials based on task events
* Filters and baseline corrects data
* Performs artifact cleaning
* Standardizes EEG
* Normalizes hemispheres (affected hand → left)

**Input**

```
data_eogclean_ALL*.mat
```

**Output**

```
data_cleanimplant.mat
data_cleanexplant.mat
```

---

# Step 2 — Behavioral Analysis & Correlation (Figure 2)

**Notebook:** `Oddball_Behavioral_analysis_Correlation.ipynb`

This notebook:

* Analyzes force profiles
* Computes overshoot and reaction slopes
* Identifies outlier trials
* Equalizes trial counts across conditions
* Aggregates mean ± SEM
* Plots force profiles
* Correlates behavioral metrics across subjects
* Compares responders vs non-responders

**Outputs**

* Force profiles (Figure 1)
* Behavioral metrics per subject

**Dependencies**

* Python
* MNE
* NumPy
* SciPy
* Matplotlib
* Seaborn
* pandas

---

# Step 3 — ERP Plots (Figure 3)

**Notebook:** `Oddball_final_plots.ipynb`

This notebook:

* Loads cleaned EEG/DBS/EMG data
* Separates trials:

  * Oddball vs Standard
  * Error vs No Error
* Computes trial-averaged ERPs
* Applies smoothing
* Computes SEM
* Generates ERP plots and topographies
* Compares responders vs non-responders

**Output**

* Figure 2 (ERP curves & scalp maps)

**Dependencies**

* Python 3
* MNE-Python
* NumPy
* SciPy
* Matplotlib
* Seaborn

---

# Step 4 — Average ERDS Plots (Figures 4 & 5)

**Notebook:** `Oddball_ERDS_avg_plots.ipynb`

This notebook:

* Loads preprocessed EEG & DBS epochs
* Separates trials into:

  * Error (E)
  * No Error (NE)
* Computes TFRs (1–30 Hz) using Morlet wavelets
* Crops time window: **-1.5 to 4 s**
* Applies baseline normalization
* Averages across:

  * Responders
  * Non-responders
  * Channels
* Computes ERDS differences (Oddball − Standard)
* Generates time-frequency plots

**Input**

```
data_clean.mat
```

**Outputs**

* `TFR_*.fif`
* ERDS plots per region and group

**Dependencies**

* mne
* mne-connectivity
* numpy
* matplotlib
* pandas
* seaborn

---

# 📂 Repository Structure

```
.
├── MATLAB/
│   ├── Oddball_Griptask_all_subjects.m
│   └── Data_clean_Save.m
│
├── notebooks/
│   ├── Oddball_Behavioral_analysis_Correlation.ipynb
│   ├── Oddball_final_plots.ipynb
│   └── Oddball_ERDS_avg_plots.ipynb
│
└── README.md
```

---

# 🚀 Usage Order

Run the pipeline in this order:

1. MATLAB preprocessing
2. Data cleaning
3. Behavioral analysis
4. ERP analysis
5. ERDS analysis

---

# 📊 Outputs

* Behavioral force profiles
* ERP plots
* Scalp topographies
* Time-frequency ERDS maps
* Statistical comparisons
* Publication-ready figures

---

# 🧪 Data Modalities

* EEG
* DBS
* EMG
* Force sensor

---

# 🧑‍🔬 Author

Nitesh Malan


