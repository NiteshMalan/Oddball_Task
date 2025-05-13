tic;
% function to read files from EDEN patients and combine in one strudcture
% for avg or plotting
% close all
%clear all;
clc;
addpath 'E:\Oddball Data\Matlab code';
addpath C:\Users\malann\Documents\MATLAB\fieldtrip-20230613 

ft_defaults;

% Define subjects list
%subj_list={'003','004','005','007','008','011','013','014','015'}; % prep/go
subj_list={'007','008','011','013','014','015'}; % prepballistic/goballistic
subj_list={'011','013','014','015'}; % prepballistic/goballistic

base_dir='E:\Oddball Data\';
task='ODD'; % 'BLK' 'GO' 'GOBALLISTIC' 'PREP' 'PREPBALLISTIC'
timelock='onset'; % go, onset, offset, prep
aff_cond=[1 101];naff_cond=[10 110];
cond=aff_cond;
stage={'implant' 'explant'}; % implant or explant

data_Nfreq_aff_odd{numel(subj_list),numel(stage)} = [];
data_Nfreq_aff_typ{numel(subj_list),numel(stage)} = [];
data_clean=[];

cond_A = cond(1);
cond_B = cond(2);
%
L = numel(stage);

my_pool = parpool(numel(subj_list));

parfor sb=1:numel(subj_list)
    %sb = spmdIndex;
    for st=1: L
        data_dir=[base_dir 'EDEN' subj_list{sb} filesep '\ANALYSIS' filesep];
        cd(data_dir);
        stage={'implant' 'explant'};
        data_file=['data_eogclean_ALL' stage{st} '_' task '_timelock_to_go_DYNOnOffset.mat'];
        
        if isfile(data_file)
            datadd = load(data_file);            

            %% convert data_eogclean to data_scd

             data_scd = Griptask_RT_compute_scd(datadd.data_eogclean);
            % data_scd = Griptask_RT_compute_cma(data_eogclean);
            % data_scd=data_eogclean;
            datadd = []
            %% redefine if needed
            if strcmp(task,'BLK') || strcmp(task,'SIN2') || strcmp(task,'SIN4')
                data_scd_redef=data_scd;
            else % redefine if needed
                data_scd_redef=P1_data_redefine([],data_scd,timelock,3,6);
            end
            data_scd = [];
            %% Preprocess
            data_preproc=P1_data_preprocess(data_scd_redef,subj_list{sb});
            data_preproc=standadize_eeg(data_preproc);
            %% Artifact removal
            % data_clean{sb}=data_artifact_reject(data_preproc, actual_TOI);
            data_clean = data_preproc;
            data_clean.subj=subj_list{sb};
            data_preproc = [];

            %% swap eeg , emg, dyn electrodes
            % make left hand affected for all subjects and right hand
            % non-affected
            [cond1,hand1]=EDEN_motor_extremity_lookup(subj_list{sb},'Affected',task);
            [cond2,hand2]=EDEN_motor_extremity_lookup(subj_list{sb},'NonAffected',task);
            data_clean=P1_swap_eeg_labels(data_clean,cond1,cond2,subj_list{sb});
            fname = ['data_clean' stage{st} '.mat']
            parsave(sprintf(fname), data_clean);

        else
            warning('File does not exist');
        end
    end
end
toc;
delete(my_pool)

