function [data_Nfreqa, data_Nfreqi]= P1_data_time_freq_proc(varargin) % data,cond,blk,impl_trials
data_clean=varargin{1};
cond=varargin{2};


cfgwl                 = [];
% wavelet
cfgwl.method = 'tfr'; 
cfgwl.pad='nextpow2';

cfgwl.channel         = 1:length(data_clean.label);
% set the frequencies of interest
cfgwl.foi             = 1:1:40;
% set the timepoints of interest: from -0.8 to 1.1 in steps of 100ms
cfgwl.toi             = round(data_clean.time{1}(1),2):.01:round(data_clean.time{1}(end),2);
cfgwl.width      = 7; % linspace(7, 13, length(cfgwl.foi));
% average over trials
cfgwl.keeptrials      = 'yes';

if (nargin==4)
    blk=varargin{3}; 
    impl_trials=varargin{4};
    if ~isempty(blk) % match block and match implant trials
       % cfgwl.trials = datasample(find(data_clean.trialinfo(:,1)==cond & data_clean.trialinfo(:,2)==blk),impl_trials,'Replace',false);
    else
       % cfgwl.trials = datasample(find(data_clean.trialinfo(:,1)==cond),impl_trials,'Replace',false);
        if impl_trials<numel(find(ismember(data_clean.trialinfo(:,1),cond)))
            trials=find(ismember(data_clean.trialinfo(:,1),cond));
            cfgwl.trials = trials(1:impl_trials);% datasample(trials,impl_trials,'Replace',false); %
        else % if explant has less number of trials than implant.
            cfgwl.trials = find(ismember(data_clean.trialinfo(:,1),cond));
        end
    end
elseif (nargin==3)
    blk=varargin{3};
    if ~isempty(blk)
        cfgwl.trials = find(ismember(data_clean.trialinfo(:,1),cond) & data_clean.trialinfo(:,2)==blk);
    else
     %   if numel(cond)==1
        cfgwl.trials = find(ismember(data_clean.trialinfo(:,1),cond));
     %   else % oddball
%            oddtrials=find(ismember(data_clean.trialinfo(:,1),cond(2))); % get number of oddballs
%            normtrials=find(ismember(data_clean.trialinfo(:,1),cond(1))); % get number of oddballs
%            normtrials2=datasample(normtrials,numel(oddtrials),'Replace',false);
%            cfgwl.trials = [normtrials2; oddtrials];
%         end
    end
else
    cfgwl.trials =find(ismember(data_clean.trialinfo(:,1),cond)); % | data_preproc.trialinfo(:,1)==4);
end

%         %compute evoked activity and subtract from each trial
%         cfgev=[]; cfgev.trials=cfgwl.trials;
%         data_evoked = ft_timelockanalysis(cfgev,data_preproc);
%         for mc=1:numel(cfgev.trials)
%             tr=cfgev.trials(mc);
%             data_preproc.trial{tr}=data_preproc.trial{tr}-data_evoked.avg;           
%         end
data_freq               = ft_freqanalysis(cfgwl, data_clean);

% log-transform
cfglog           = [];
cfglog.parameter = 'powspctrm';
cfglog.operation = 'log10';
data_logfreq    = ft_math(cfglog, data_freq);
% baseline
cfgtf=[];
cfgtf.blavgopt ='yes';
cfgtf.baseline = [cfgwl.toi(1)+1 cfgwl.toi(end)-1];
cfgtf.baselinetype = 'relchange'; % compute z-score w.r.t baseline
data_Nfreqi = ft_freqbaseline(cfgtf, data_logfreq);
% average
cfgav.trials = 'all';%find(data_freq1.trialinfo(:,1)==1); % | data_preproc.trialinfo(:,1)==4);
cfgav.avgoverrpt  = 'yes';
data_Nfreqa = ft_selectdata(cfgav,data_Nfreqi);
% smooth data
for jk=1: size(data_Nfreqa.powspctrm,1)
    temp=squeeze(data_Nfreqa.powspctrm(jk,:,:));
    temp=smoothdata(temp,2,'gaussian',100);
    data_Nfreqa.powspctrm(jk,:,:)=temp;
end

end
