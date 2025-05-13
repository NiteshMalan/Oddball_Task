function data_scd_redef=P1_data_redefine(subj,data_scd,timelock,prestim,poststim)

% the following is for programming data
% if strcmp(subj,'011') || strcmp(subj,'010') || strcmp(subj,'008')
%     RTcol=2; MTcol=3;
% else
%     RTcol=4; MTcol=5;
% end
%RTcol=4; MTcol=5; % other tasks
RTcol=2; MTcol=3;% for oddball
if ~strcmp(timelock,'go')
    if strcmp(timelock,'onset')
        % redefine to onset
        shift=round(data_scd.trialinfo(:,RTcol)); %onset
    elseif strcmp(timelock,'offset')
        % redefine to offset
        shift=round(data_scd.trialinfo(:,RTcol))+round(data_scd.trialinfo(:,MTcol));
    elseif strcmp(timelock,'prep')
        shift=round(data_scd.trialinfo(:,3)); % prep
    end
    movt_time_column=5;
    
  %  prestim     = 4;%4;%8;%3; %for an actual_TOI=[-2 7];
  %  poststim    = 12;%12;%8;%12; %for an actual_TOI=[-2 7];
    zero_sam = nearest(data_scd.time{1},0);
    
    cfgrdt           = []; newFs=round(1/(data_scd.time{1}(2)-data_scd.time{1}(1)));
    cfgrdt.begsample = repmat(zero_sam,size(shift,1),1) + shift - repmat(prestim*newFs,size(shift,1),1);
    cfgrdt.endsample = repmat(zero_sam,size(shift,1),1) + shift + repmat(poststim*newFs,size(shift,1),1);
    short_trials=find(cfgrdt.endsample>length(data_scd.time{1}) | cfgrdt.begsample<=0);
    % eliminate outliers, check which column has movement time
    outlier_trials=find(data_scd.trialinfo(:,movt_time_column)==0 );%| data_scd.trialinfo(:,3)<400
    bad_trials=unique([short_trials; outlier_trials]);
    cfgrdt.trials=find(~ismember(1:length(shift),bad_trials));
    temp = ft_redefinetrial(cfgrdt, data_scd);
    % then shift the time axis
    cfgrdt1 = [];
    cfgrdt1.offset = -shift(cfgrdt.trials);
    data_scd_redef = ft_redefinetrial(cfgrdt1, temp);
else
    data_scd_redef=data_scd;
end


end