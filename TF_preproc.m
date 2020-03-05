%% Add Required Paths
addpath(genpath('/Users/Anita/Documents/MATLAB/EEG_class/FinalProject_FT/Oddball2019'))
addpath('/Users/Anita/Documents/MATLAB/EEG_class/FinalProject_FT/fieldtrip-20191028')
% addpath('/Users/Anita/Documents/MATLAB/EEG_class/')

%% define trials
cfg              = [];
cfg.headerfile   = '/users/Anita/Documents/MATLAB/EEG_class/FinalProject_FT/Oddball2019/Subj05/Subj05.vhdr';
cfg.datafile     = '/users/Anita/Documents/MATLAB/EEG_class/FinalProject_FT/Oddball2019/Subj05/Subj05.eeg';
cfg.trialdef.eventtype = 'Stimulus';
%cfg.trialdef.eventtype  = '?'
cfg.trialdef.eventvalue = {'  2'};
cfg.trialdef.prestim    = 3;
cfg.trialdef.poststim   = .5;
cfg = ft_definetrial(cfg);


%% preproc
% Baseline-correction options
cfg.demean = 'yes';
%cfg.baselinewindow = [-3 0];
cfg.bsfilter = 'yes';
cfg.bsfreq = [58 62];
cfg.reref = 'yes';
cfg.refchannel = {'TP9','TP10'};
cfg.refmethod = 'avg';
data = ft_preprocessing(cfg);

cfg = [];
cfg.bpfilter = 'yes';
cfg.bpfreq = [.5 40];
data = ft_preprocessing(cfg, data);

%%
cfg=[];
cfg.continous='no';
cfg.allowoverlap = 'no';
cfg.viewmode = 'vertical';
%cfg= ft_databrowser(cfg, data);


%% downsample data
cfg = [];
cfg.resamplefs = 250;
cfg.detrend    = 'no';
data_dwn = ft_resampledata(cfg, data);

%% ICA

%perform ICA
cfg        = [];
cfg.method = 'runica';
cfg.runica.pca = 31;  
data_ica = ft_componentanalysis(cfg, data);

%% topoplot of components
%figure
cfg = [];
cfg.component = 1:31;       % specify the component(s) that should be plotted
cfg.layout    = 'easycap.mat'; % specify the layout file that should be used for plotting
cfg.comment   = 'no';
cfg.colormap = 'jet';
%ft_topoplotIC(cfg, data_ica)

%% another detailed way to play
cfg = [];
cfg.layout    = 'easycap.mat'; % specify the layout file that should be used for plotting
cfg.viewmode = 'component';
%ft_databrowser(cfg, data_ica)

%% reject components
% remove the bad components and backproject the data
cfg = [];
%cfg.component = [3,5];%sub01
%cfg.component = [2]; %sub02
%cfg.component = [5,12]; %sub03
%cfg.component = [1,14,17]; %sub04
cfg.component = [1,6]; %sub05
clean_data = ft_rejectcomponent(cfg, data_ica, data_dwn);

%% take a look at trial data
cfg=[];
cfg.channel='all';
cfg.continous='no';
cfg.allowoverlap = 'no';
cfg.viewmode = 'vertical';
%cfg= ft_databrowser(cfg, clean_data);

%% reject trials

cfg        = [];
cfg.method = 'trial';
cfg.layout    = 'easycap.mat';% use by default summary method
cfg.channel='all';
%data_final = ft_rejectvisual(cfg,clean_data);

%% reject trials
keep = true(1,320);
%bad = [281]; %sub01
%bad = [10,15,19,26:29,33,51,61,201:203,212:214,239,271,280,285,292]; %sub02
%bad = [7:10,15:20,22,23,25,29,55,68,69,74,104,149,158,174,184,195,288,313]; %sub03
%bad = [39,125,140,155,219,265,295,298]; %sub04
bad = [153,191,201,202,241,245,246]; %sub05
keep(bad) = false;

cfg=[];
cfg.trials = keep;
data_final = ft_selectdata(cfg,clean_data);
