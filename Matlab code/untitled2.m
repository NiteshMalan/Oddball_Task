addpath E:\Oddball Data\Matlab code
addpath C:\Users\malann\Documents\MATLAB\fieldtrip-20230613
ft_defaults;

c = parcluster("HPCv2");
job = batch(c,@trybatchnew,1,{}, ...
    'Pool',64, ...
    'CurrentFolder','.');

job.State
getReport(job.Tasks(1).Error)
fetchOutputs(job)


datadir = 'E:\Oddball Data\EDEN015\ANALYSIS';
fiff_file  = fullfile(datadir, 'ctf-epo.fif');
fieldtrip2fiff(fiff_file, data_eogclean);
save(fullfile(datadir, 'ctf-epo.mat'), 'data_eogclean');

data = load("data_eogclean_Allimplant_ODD_timelock_to_go_DYNOnOffset.mat");
data = data.data_eogclean;
datadir = 'E:\Oddball Data\EDEN007\ANALYSIS';

fiff_file  = fullfile(datadir, 'ctf-epo.fif');
fieldtrip2fiff(fiff_file, data);
save(fullfile(datadir, 'ctf-epo.mat'), 'data');



%%Multiplot code

 
cfgplot=[];
cfgplot.xlim=[-2 4];
cfgplot.ylim=[1 30];
cfgplot.interactive     = 'yes';
cfgplot.showoutline     = 'yes';
cfgplot.layout          = ['EDEN_eeg_layout_for_plots_v2.mat'];% if error check your matlab path
cfgplot.zlim            = [-.05 .05];
cfgplot.showoutline = 'yes';
cfgplot.showlabels    = 'yes';
cfgplot.colormap       = 'jet';
%cfgplot.trials = find(data_Nfreq.trialinfo(:,1)==3);

figure; %maximize;

ft_multiplotTFR(cfgplot,x);

 
