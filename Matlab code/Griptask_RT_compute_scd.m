function data_scd = Griptask_RT_compute_scd(data_clean)

% compute elec definitions from 1010 standard
eeg1010_dfn  = 'standard_1020.elc'; %['C:\Users\gopalar\Documents\fieldtrip-20180919\template\electrode\standard_1020.elc']; 
elec1010 = ft_read_sens(eeg1010_dfn);
eindx=[];
elec1020=struct('type',[],'unit',[],'chanpos',[],'chantype',[],'chanunit',[],'elecpos',[],'label',[]);
elec1020.type='eeg1020';
elec1020.unit='mm';

for i = 1 : length(data_clean.label)
    eindx= find( ~cellfun( @(c)~strcmpi(c,data_clean.label{i}),elec1010.label));
    if ~isempty(eindx)
    elec1020.chanpos(i,:)=elec1010.chanpos(eindx,:);
    elec1020.chantype{i,1}=elec1010.chantype{eindx};
    elec1020.chanunit{i,1}=elec1010.chanunit{eindx};
    elec1020.elecpos(i,:)=elec1010.elecpos(eindx,:);
    elec1020.label{i,1}=elec1010.label{eindx};
    else
        
        disp([data_clean.label{i} ' has no matches']);
    end

end
elec1020.label{1}='FP1';
elec1020.label{2}='FP2';


DBSindx=find( ~cellfun( @(c)isempty(strfind(c,'DBS')),data_clean.label));
EMGindx=find( ~cellfun( @(c)isempty(strfind(lower(c),lower('Emg'))),data_clean.label));
DYNindx=find( ~cellfun( @(c)isempty(strfind(lower(c),lower('Dyn'))),data_clean.label));
noneeg=[DBSindx; EMGindx; DYNindx];
eegonly=~ismember(1:length(data_clean.label),noneeg);


% find neighbouhood matrix based
cfgnei=[];
cfgnei.elec=elec1020;
cfgnei.method='triangulation';
cfgnei.channel=find(eegonly);
neighbours = ft_prepare_neighbours(cfgnei, data_clean);

% compute SCD
cfgscd.method       = 'hjorth';
cfgscd.elec         = elec1020;
cfgscd.neighbours = neighbours;
cfgscd.trials = 'all'; %find(data_clean.trialinfo==choice);
data_scd = ft_scalpcurrentdensity(cfgscd, data_clean);
data_scd=rmfield(data_scd,'elec');
%data_scd.label=['FP1'; 'FP2'; data_scd.label];

% combine DBS and SCD data
if ~isempty(DBSindx)
cfgcom=[]; cfgcom.channel=DBSindx;
cfgcom.trials = 'all'; %find(data_clean.trialinfo==choice);
data_dbs_emg=ft_preprocessing(cfgcom,data_clean);
cfga.appenddim='chan';
data_scd=ft_appenddata(cfga,data_clean,data_dbs_emg);

end

if ~isempty(EMGindx)
    cfgcom=[]; cfgcom.channel=EMGindx;
    data_emg=ft_selectdata(cfgcom,data_clean);
    cfga.appenddim='chan';
    data_scd=ft_appenddata(cfga,data_scd,data_emg);

end

if ~isempty(DYNindx)
    cfgcom=[]; cfgcom.channel=DYNindx;
    data_dyn=ft_preprocessing(cfgcom,data_clean);
    cfga.appenddim='chan';
    data_scd=ft_appenddata(cfga,data_scd,data_dyn);

end

clear data_dbs_emg data_clean