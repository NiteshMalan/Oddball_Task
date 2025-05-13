tic;
% function to read files from EDEN patients and combine in one strudcture
% for avg or plotting
% close all
clear all
clc
% Define subjects list
% subj_list={'003','004','005','007','008','011','013','014','015'}; % prep/go
subj_list={'007','008','011','013','014','015'}; % prepballistic/goballistic
subj_list={'007'}; % prepballistic/goballistic

base_dir='E:\Oddball Data\';
task='ODD'; % 'BLK' 'GO' 'GOBALLISTIC' 'PREP' 'PREPBALLISTIC'
timelock='onset'; % go, onset, offset, prep
aff_cond=[1 101];naff_cond=[10 110];
cond=aff_cond;
stage={'implant' 'explant'}; % implant or explant

%
for sb=1: numel(subj_list)
    for st=1:numel(stage)
        data_dir=[base_dir 'EDEN' subj_list{sb} filesep '\ANALYSIS' filesep];
        cd(data_dir);
        data_file=['data_eogclean_ALL' stage{st} '_' task '_timelock_to_go_DYNOnOffset.mat'];
        
        if isfile(data_file)
            load(data_file);            
            

            %% convert data_eogclean to data_scd
            
            data_scd = Griptask_RT_compute_scd(data_eogclean);
            %data_scd = Griptask_RT_compute_cma(data_eogclean);
            % data_scd=data_eogclean;
            clear data_eogclean
            %% redefine if needed
            if strcmp(task,'BLK') || strcmp(task,'SIN2') || strcmp(task,'SIN4')
                data_scd_redef=data_scd;
            else % redefine if needed
                data_scd_redef=P1_data_redefine([],data_scd,timelock,3,6);
            end
           clear data_scd
            %% Preprocess
            data_preproc=P1_data_preprocess(data_scd_redef,subj_list{sb});
            data_preproc=standadize_eeg(data_preproc);
            %% Artifact removal
            % data_clean{sb}=data_artifact_reject(data_preproc, actual_TOI);
            data_clean{sb,st}=data_preproc;
            data_clean{sb,st}.subj=subj_list{sb};
            clear data_preproc


            %% swap eeg , emg, dyn electrodes
            % make left hand affected for all subjects and right hand
            % non-affected
            [cond1,hand1]=EDEN_motor_extremity_lookup(subj_list{sb},'Affected',task);
            [cond2,hand2]=EDEN_motor_extremity_lookup(subj_list{sb},'NonAffected',task);
            data_clean{sb,st}=P1_swap_eeg_labels(data_clean{sb,st},cond1,cond2,subj_list{sb});

            
             % compute time-freq
             impl_trials=numel(find(data_clean{sb,st}.trialinfo(:,1)==cond(2))); % make st=1 to match implant trial number
             data_Nfreq_aff_odd{sb,st}=P1_data_time_freq_proc(data_clean{sb,st},cond(2),[]);
             data_Nfreq_aff_typ{sb,st}=P1_data_time_freq_proc(data_clean{sb,st},cond(1),[],impl_trials);
%              impl_trials=numel(find(data_clean{sb,1}.trialinfo(:,1)==naff_cond));
%               data_Nfreq_naff{sb,st}=P1_data_time_freq_proc(data_clean{sb,st},naff_cond,[],impl_trials);
        else
            warning('File does not exist');
        end
    end
end
toc;
%%

% use ft_timelockanalysis to compute the ERPs
cfg = [];
cfg.trials = find(data_clean{1,1}.trialinfo==1);
standard = ft_timelockanalysis(cfg, data_clean{1,1});

cfg = [];
cfg.trials = find(data_clean{1,1}.trialinfo==101);
oddball = ft_timelockanalysis(cfg, data_clean{1,1});

cfg = [];
cfg.layout = 'EDEN_eeg_layout_for_plots_v2.mat';
cfg.interactive = 'yes';
cfg.showoutline = 'yes';
ft_multiplotER(cfg, oddball)


cfg = [];
cfg.operation = 'subtract';
cfg.parameter = 'avg';
difference = ft_math(cfg, standard, oddball);

% note that the following appears to do the sam
% difference     = task1;                   % copy one of the structures
% difference.avg = task1.avg - task2.avg;   % compute the difference ERP
% however that will not keep provenance information, whereas ft_math will

cfg = [];
cfg.layout      = 'mpi_customized_acticap64.mat';
cfg.interactive = 'yes';
cfg.showoutline = 'yes';
ft_multiplotER(cfg, difference);


plot(oddball.avg(10,:))

%% Multiplot code

 
cfgplot=[];
cfgplot.xlim=[-2 4];
cfgplot.ylim=[1 30];
cfgplot.interactive     = 'yes';
cfgplot.showoutline     = 'yes';
cfgplot.layout          = 'EDEN_eeg_layout_for_plots_v2.mat';% if error check your matlab path
cfgplot.zlim            = [-0.1 0.1];
cfgplot.showoutline = 'yes';
cfgplot.showlabels    = 'yes';
cfgplot.colormap       = 'jet';
%cfgplot.trials = find(data_Nfreq.trialinfo(:,1)==3);

figure; %maximize;

ft_multiplotTFR(cfgplot,data_Nfreq_aff_odd{1,1});
