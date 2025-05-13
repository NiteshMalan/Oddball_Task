%% SWAP EEG labels

function data_clean = P1_swap_eeg_labels(data_clean,cond_aff,cond_naff,subj)
% swap the labels so affected is on the Right side of the brain (EEG only)
% chosse subjects with right affected and swap labels
%for sb=1: numel(subj_list)
   % cond=EDEN_motor_extremity_lookup(subj_list{sb},'Affected',task);
    if all(cond_aff~=1) % right affected / left infarct patient
        disp([subj ':Swap Label']);
        % swap left channels to right
        left_channels=ft_channelselection({'*1', '*3', '*5', '*7', '*9' '-DBS*'}, data_clean.label, 'eeg');
        left_ch_edited=cellfun(@(x) str2num(regexprep(x,'\D','')),left_channels)+1; 
        left_ch_edited_str=cellfun(@(x) strtrim(x), cellstr(num2str(left_ch_edited)),'UniformOutput',false);
        left_ch_char=cellfun(@(x) regexprep(x,'\d',''),left_channels,'UniformOutput',false);
        new_left_ch=cellfun(@(x1,x2) [x1 x2], left_ch_char, left_ch_edited_str,'UniformOutput',false);
        left_channels_indx=ismember(data_clean.label,left_channels);

        % swap right channels to left
        right_channels=ft_channelselection({'*2', '*4', '*6', '*8', '*10' '-DBS*'}, data_clean.label, 'eeg');
        right_ch_edited=cellfun(@(x) str2num(regexprep(x,'\D','')),right_channels)-1; 
        right_ch_edited_str=cellfun(@(x) strtrim(x), cellstr(num2str(right_ch_edited)),'UniformOutput',false);
        right_ch_char=cellfun(@(x) regexprep(x,'\d',''),right_channels,'UniformOutput',false);
        new_right_ch=cellfun(@(x1,x2) [x1 x2], right_ch_char, right_ch_edited_str,'UniformOutput',false);
        right_channels_indx=ismember(data_clean.label,right_channels);

        data_clean.label(left_channels_indx)=new_left_ch;       
        data_clean.label(right_channels_indx)=new_right_ch;    
        
        % swap EMG labels
        EMGRindx=find(strcmp('EmgR',data_clean.label));%find( cellfun( @(c)isempty(strcmp(c,['EmgR'])),data_clean.label));
        EMGLindx=find(strcmp('EmgL',data_clean.label));%find( cellfun( @(c)isempty(strcmp(c,['EmgL'])),data_clean.label));
        if ~isempty(EMGRindx)
            data_clean.label(EMGRindx)=strrep(data_clean.label(EMGRindx),'R','L');
        end
        if ~isempty(EMGLindx)
            data_clean.label(EMGLindx)=strrep(data_clean.label(EMGLindx),'L','R');
        end
        
        % swap EMG labels
        EMGRindx=find(strcmp('EmgR(lc)',data_clean.label));%find( cellfun( @(c)isempty(strcmp(c,['EmgR(lc)'])),data_clean.label));
        EMGLindx=find(strcmp('EmgL(lc)',data_clean.label));%find( cellfun( @(c)isempty(strcmp(c,['EmgL(lc)'])),data_clean.label));
        if ~isempty(EMGRindx)
        data_clean.label(EMGRindx)=strrep(data_clean.label(EMGRindx),'R','L');
        end
        if ~isempty(EMGLindx)
        data_clean.label(EMGLindx)=strrep(data_clean.label(EMGLindx),'L','R');
        end
        
        % swap DYN labels
        DYNRindx=find( ~cellfun( @(c)isempty(strfind(c,['DynR'])),data_clean.label));
        DYNLindx=find( ~cellfun( @(c)isempty(strfind(c,['DynL'])),data_clean.label));
        data_clean.label(DYNRindx)=strrep(data_clean.label(DYNRindx),'R','L');
        data_clean.label(DYNLindx)=strrep(data_clean.label(DYNLindx),'L','R');
        
        % swap trialinfo
        if numel(cond_aff)==1
            R_trials=data_clean.trialinfo(:,1)==cond_aff;
            L_trials=data_clean.trialinfo(:,1)==cond_naff;
            data_clean.trialinfo(R_trials)=cond_naff;
            data_clean.trialinfo(L_trials)=cond_aff;
        else % ODDBALL
            R_trials_1=find(ismember(data_clean.trialinfo(:,1),cond_aff(1)));
            R_trials_2=find(ismember(data_clean.trialinfo(:,1),cond_aff(2)));
            L_trials_1=find(ismember(data_clean.trialinfo(:,1),cond_naff(1)));
            L_trials_2=find(ismember(data_clean.trialinfo(:,1),cond_naff(2)));

            data_clean.trialinfo(R_trials_1)=cond_naff(1);
            data_clean.trialinfo(R_trials_2)=cond_naff(2);
            data_clean.trialinfo(L_trials_1)=cond_aff(1);
            data_clean.trialinfo(L_trials_2)=cond_aff(2);
        end
                
    else
        disp([subj ':Do Nothing'])
    end
        
%end

% % find the intersection of all eeg channels
% % eliminate eeg channels not present in all subjects
% eeg_chan_array=[];
% for sb=1: numel(subj_list)
%     eeg_chan=ft_channelselection('eeg',data_clean{sb}.label);
%     eeg_chan_array{sb}=eeg_chan;
% end
% common_eeg=mintersect(eeg_chan_array{:});


end
%%



