function dat= trybatch()
    addpath 'home/malann/Oddball Data/Matlab code'
    subj_list={'007','008','011','013','014','015'}; % prepballistic/goballistic
    subj_list={'007'}; % prepballistic/goballistic

    base_dir='home/malann/Oddball Data/';
    task='ODD'; % 'BLK' 'GO' 'GOBALLISTIC' 'PREP' 'PREPBALLISTIC'
    timelock='onset'; % go, onset, offset, prep
    aff_cond=[1 101];
    naff_cond=[10 110];
    cond=aff_cond;
    stage={'implant' 'explant'}; % implant or explant
    
    data_Nfreq_aff_odd{numel(subj_list),numel(stage)} = [];
    data_Nfreq_aff_typ{numel(subj_list),numel(stage)} = [];
    %data_clean{numel(subj_list),numel(stage)}=[];
    %datadd{numel(subj_list),numel(stage)}=[];
    
    cond_A = cond(1);
    cond_B = cond(2);     

    L = numel(stage);    
    
    for sb=1: numel(subj_list)
        for st=1: L
            data_dir=[ base_dir 'EDEN' subj_list{sb} '/ANALYSIS/'];
            stage={'implant' 'explant'};
            data_file=[data_dir 'data_eogclean_All' stage{st} '_' task '_timelock_to_go_DYNOnOffset.mat'];
            
            if isfile(data_file)
                dat = load(data_file);    
                %% convert data_eogclean to data_scd

                data_scd = Griptask_RT_compute_scd(dat.data_eogclean);
                % data_scd = Griptask_RT_compute_cma(data_eogclean);
                % data_scd=data_eogclean;
                %datadd = [];
    %             %% redefine if needed
    %             if strcmp(task,'BLK') || strcmp(task,'SIN2') || strcmp(task,'SIN4')
    %                 data_scd_redef=data_scd;
    %             else % redefine if needed
    %                 data_scd_redef=P1_data_redefine([],data_scd,timelock,3,6);
    %             end
    %             %data_scd = []
    %             %% Preprocess
    %             data_preproc=P1_data_preprocess(data_scd_redef,subj_list{sb});
    %             data_preproc=standadize_eeg(data_preproc);
    %             %% Artifact removal
    %             % data_clean{sb}=data_artifact_reject(data_preproc, actual_TOI);
    %             data_clean=data_preproc;
    %             data_clean.subj=subj_list{sb};
    %             %data_preproc = []
    % 
    %             %% swap eeg , emg, dyn electrodes
    %             % make left hand affected for all subjects and right hand
    %             % non-affected
    %             [cond1,hand1]=EDEN_motor_extremity_lookup(subj_list{sb},'Affected',task);
    %             [cond2,hand2]=EDEN_motor_extremity_lookup(subj_list{sb},'NonAffected',task);
    %             data_clean=P1_swap_eeg_labels(data_clean,cond1,cond2,subj_list{sb});
    %              %compute time-freq
    %              impl_trials=numel(find(data_clean.trialinfo(:,1)==cond_A)); % make st=1 to match implant trial number
    %              data_Nfreq_aff_odd{sb,st}=P1_data_time_freq_proc(data_clean,cond_B,[]);
    %              data_Nfreq_aff_typ{sb,st}=P1_data_time_freq_proc(data_clean,cond_A,[],impl_trials);
    % %              impl_trials=numel(find(data_clean{sb,1}.trialinfo(:,1)==naff_cond));
    % %               data_Nfreq_naff{sb,st}=P1_data_time_freq_proc(data_clean{sb,st},naff_cond,[],impl_trials);
            else
                warning('File does not exist');
            end
            
        end
    end
end