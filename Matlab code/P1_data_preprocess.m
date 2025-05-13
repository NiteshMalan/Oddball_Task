%%
function data_preproc = P1_data_preprocess(data_scd_redef, subj_id)

data_scd_redef.label=regexprep(data_scd_redef.label, '\s', ''); % remove spaces from label names DBS 1 to DBS1
% Preprocess

% Baseline-correction options
cfgpp=[];
cfgpp.demean          = 'yes';
% cfgpp.baselinewindow  = 'all';%[-1 0];%'all'; %// USER INPUT
cfgpp.detrend ='yes'; % removes linear trend

% % Fitering options (bandpass) if needed
% cfgpp.lpfilter        = 'no';
% cfgpp.lpfreq          = 30;
% cfgpp.padding        = 20; % secs includin trial length
% cfgpp.padtype        = 'mirror';
% cfgpp.bpfilter        = 'yes';
% cfgpp.bpfreq          = [1 30];
% cfgpp.padding        = 20; % secs includin trial length
% cfgpp.padtype        = 'mirror';
% % reref EEG
% cfgpp.channel       = 'eeg'; %'DBS*'; %DBS* or eeg
eeg_preproc = ft_preprocessing(cfgpp, data_scd_redef);

% % for explant I just filtered it
% if strcmp(subj_id,'004')
%     cfgpp.bpfreq          = [5 15];
%     cfgpp.bpfilter        = 'yes';
% end

% reref DBS
DBSindx=find( ~cellfun( @(c)isempty(strfind(c,'DBS')),data_scd_redef.label));
if ~isempty(DBSindx)
    cfgpp.channel       = DBSindx;
    
    if strcmp(subj_id,'001') || strcmp(subj_id,'002') || strcmp(subj_id,'003') || strcmp(subj_id,'011') || strcmp(subj_id,'013') ||  strcmp(subj_id,'014') ||  strcmp(subj_id,'015')
        
        cfgpp.reref         = 'yes';
        %  cfgpp.refchannel ='all';
        cfgpp.refmethod   = 'bipolar'; % {'A1' 'A2'} or {'FT9' 'FT10'} for mastoids , 'all' for common avg ref
    else % directional leads
                bipolar_directional.labelold  = {'DBS1', 'DBS2', 'DBS3', 'DBS4', 'DBS5', 'DBS6', 'DBS7', 'DBS8' };
                bipolar_directional.labelnew  = {'DBS1-2', 'DBS1-3', 'DBS1-4','DBS2-5', 'DBS3-6', 'DBS4-7', 'DBS5-8', 'DBS6-8', 'DBS7-8'};
                bipolar_directional.tra       = [
                    +1 -1  0  0  0  0  0  0
                    +1  0 -1  0  0  0  0  0
                    +1  0  0 -1  0  0  0  0
                    0 +1  0  0 -1  0  0  0
                    0  0 +1  0  0 -1  0  0
                    0  0  0 +1  0  0 -1  0
                    0  0  0  0 +1  0  0 -1
                    0  0  0  0  0 +1  0 -1
                    0  0  0  0  0  0 +1 -1
                    ];

                cfgpp.montage       = bipolar_directional;
        
        % bipolar_pool.labelold  = {'DBS1', 'DBS2', 'DBS3', 'DBS4', 'DBS5', 'DBS6', 'DBS7', 'DBS8' };
        % bipolar_pool.labelnew  = {'DBS1-234', 'DBS234-567', 'DBS567-8'};
        % 
        % bipolar_pool.tra       = [
        %     1   -1/3  -1/3  -1/3    0     0     0     0
        %     0    1/3   1/3   1/3  -1/3  -1/3  -1/3    0
        %     0     0     0     0    1/3   1/3   1/3   -1
        % 
        %     ];
        % 
        % cfgpp.reref=[];
        % cfgpp.montage       = bipolar_pool;
    end
    dbs_preproc = ft_preprocessing(cfgpp, data_scd_redef);
else
    dbs_preproc=[];
end

cfga=[];
cfga.avgoverchan = 'yes';
dbs_preproc_mean=ft_selectdata(cfga,dbs_preproc);

% preproc EMG
EMGindx=find( ~cellfun( @(c)isempty(strfind(lower(c),lower('Emg'))),data_scd_redef.label));
if ~isempty(EMGindx)
    cfgemg              = [];
    cfgemg.demean       = 'yes';
    cfgemg.channel      = EMGindx;
    cfgemg.bpfilter     = 'no';
    cfgemg.bpfreq       = [1 40];
    cfgemg.hpfilter     = 'no';
    cfgemg.hpfreq       = 5;
    cfgemg.rectify      = 'yes';
    cfgemg.hilbert       = 'no';
    emg_preproc = ft_preprocessing(cfgemg, data_scd_redef);
    emg_preproc.time=eeg_preproc.time;
else
    emg_preproc=[];
end

% preproc dyn
DYNindx=find( ~cellfun( @(c)isempty(strfind(c,'Dyn')),data_scd_redef.label));
if ~isempty(DYNindx)
    cfgdyn=[];
    cfgdyn.channel = DYNindx; %{'DYNL' 'DYNR'};
    dyn_preproc = ft_preprocessing(cfgdyn, data_scd_redef);
else
    dyn_preproc=[];
end


cfga=[];
if ~isempty(DBSindx) && ~isempty(DYNindx) && ~isempty(EMGindx)
    cfga.appenddim='chan';
    data_preproc=ft_appenddata(cfga,eeg_preproc, dbs_preproc, dbs_preproc_mean, dyn_preproc, emg_preproc);
elseif ~isempty(DBSindx) && isempty(DYNindx) && ~isempty(EMGindx)
    cfga.appenddim='chan';
    data_preproc=ft_appenddata(cfga,eeg_preproc, dbs_preproc, dbs_preproc_mean, emg_preproc);
elseif isempty(DBSindx) && ~isempty(DYNindx) && ~isempty(EMGindx)
    cfga.appenddim='chan';
    data_preproc=ft_appenddata(cfga,eeg_preproc, dyn_preproc, emg_preproc);
elseif ~isempty(DBSindx) && ~isempty(DYNindx) && isempty(EMGindx)
    cfga.appenddim='chan';
    data_preproc=ft_appenddata(cfga,eeg_preproc, dbs_preproc, dbs_preproc_mean, dyn_preproc);
elseif ~isempty(DBSindx) && isempty(DYNindx) && isempty(EMGindx)
    cfga.appenddim='chan';
    data_preproc=ft_appenddata(cfga,eeg_preproc, dbs_preproc, dbs_preproc_mean);
else
    data_preproc=eeg_preproc;
end

end

