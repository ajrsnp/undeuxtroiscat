
%%
cfg         = [];
cfg.output  = 'pow';
cfg.channel = 'all';
cfg.method  = 'wavelet';
cfg.keeptrials = 'yes';
cfg.toi = -1 : .01 : 1;
cfg.width = 2;
cfg.taper   = 'hanning';
cfg.foi     = .5: .001 : 12;
cfg.pad     = 'nextpow2';

cfg.trials = find(blocktype==1);
visual_alltrials  = ft_freqanalysis(cfg, data_final);

cfg.trials = find(blocktype==2);
auditory_alltrials  = ft_freqanalysis(cfg, data_final);

visualTrials = trialType(blocktype==1);
auditoryTrials = trialType(blocktype==2);

% auditory_odd; auditory_common; visual_odd; visual_common
%blockType: 1-visual, 2-auditory
%trialType: 1-common, 2-odd

%%
cfg=[];
% allsubs_visual=ft_appenddata(cfg,sub01_visual_alltrials,sub02_visual_alltrials,sub03_visual_alltrials,sub04_visual_alltrials,sub05_visual_alltrials);
allsubs_data=ft_appenddata(cfg,sub01,sub02,sub03,sub04,sub05);

%%
cfg         = [];
cfg.output  = 'pow';
cfg.channel = 'all';
cfg.method  = 'wavelet';
cfg.keeptrials = 'yes';
cfg.toi = -1 : .01 : 1;
cfg.width = 2;
cfg.taper   = 'hanning';
cfg.foi     = .5: .001 : 12;
cfg.pad     = 'nextpow2';

cfg.trials = find(allsubs_blocktype==1);
visual_alltrials  = ft_freqanalysis(cfg, allsubs_data);


%%
% visual_alltrials.powspctrm(isnan(visual_alltrials.powspctrm)) = 0;

%%
% cfg = [];
% cfg.layout = 'easycap.mat';
% cfg.interactive = 'yes';
% cfg.showoutline = 'yes';
% cfg.channel = 'all'; %{'P7','P8','Cz','Pz','Fz'};
% ft_multiplotTFR(cfg, sub02_oddball)

%%

% cfg              = [];
% cfg.baseline     = [-0.5 -0.1];
% cfg.baselinetype = 'absolute';
% cfg.xlim         = [0.4 0.8];  % specified in seconds
% cfg.ylim         = [.5 40];    
% cfg.zlim         = 'maxabs';
% cfg.marker       = 'on';
% cfg.colorbar     = 'yes';
% cfg.layout       = 'easycap.mat';
% 
% figure;
% ft_topoplotTFR(cfg, common);
% title('Common');
% 
% figure;
% ft_topoplotTFR(cfg, oddball);
% title('Oddball');


%%
% cfg          = [];
% cfg.colorbar = 'yes';
% cfg.xlim= [0 .5];
% cfg.zlim     = 'maxabs';%[-10000 10000];%'maxabs'; %[-1.3e4 1.3e4];
% cfg.ylim     = [2 12];  % plot alpha band upwards
% cfg.layout   = 'easycap.mat';
% cfg.channel = {'P3','P4','Cz','Pz','Fz'}; %'all';
% 
% figure;
% ft_singleplotTFR(cfg, auditory_odd);
% 
% figure;
% ft_singleplotTFR(cfg, auditory_common);
% 
% cfg          = [];
% cfg.xlim= [0 .5];
% cfg.colorbar = 'yes';
% cfg.zlim     = 'maxabs';%[-10000 10000];%'maxabs'; %[-1.3e4 1.3e4];
% cfg.ylim     = [2 8];  % plot alpha band upwards
% cfg.layout   = 'easycap.mat';
% cfg.channel = {'P3','P4','Cz','Pz','Fz'}; %'all';
% 
% figure;
% ft_singleplotTFR(cfg, visual_odd);
% 
% figure;
% ft_singleplotTFR(cfg, visual_common);

% %% calc difference
% cfg = [];
% cfg.parameter    = 'powspctrm';
% cfg.operation    = '(x1-x2)/(x1+x2)';
% 
% auditory_difference = ft_math(cfg, auditory_odd, auditory_common);
% visual_difference = ft_math(cfg, visual_odd, visual_common);
% %%
% cfg          = [];
% cfg.colorbar = 'yes';
% cfg.zlim     = 'maxabs';%[-10000 10000];%'maxabs'; %[-1.3e4 1.3e4];
% cfg.ylim     = [2 15];  % plot alpha band upwards
% cfg.layout   = 'easycap.mat';
% cfg.channel = {'P3','P4','Cz','Pz','Fz'}; %'all';
% figure;
% ft_singleplotTFR(cfg, auditory_difference);
% 
% figure;
% ft_singleplotTFR(cfg, visual_difference);

% %% group average
% 
% cfg=[];
% cfg.method='across';
% grand_auditorycommon = ft_freqgrandaverage(cfg, sub01_auditory_common,sub02_auditory_common, sub03_auditory_common, sub04_auditory_common, sub05_auditory_common);
% 
% cfg=[];
% cfg.method='across';
% grand_auditoryodd = ft_freqgrandaverage(cfg, sub01_auditory_odd, sub02_auditory_odd, sub03_auditory_odd, sub04_auditory_odd, sub05_auditory_odd);
% 
% cfg=[];
% cfg.method='across';
% grand_visualcommon = ft_freqgrandaverage(cfg, sub01_visual_common, sub02_visual_common, sub03_visual_common, sub04_visual_common, sub05_visual_common);
% 
% cfg=[];
% cfg.method='across';
% grand_visualodd = ft_freqgrandaverage(cfg, sub01_visual_odd, sub02_visual_odd, sub03_visual_odd, sub04_visual_odd, sub05_visual_odd);
% 


%%
% 
% cfg          = [];
% cfg.colorbar = 'yes';
% cfg.zlim     = 'maxabs';%[-10000 10000];%'maxabs'; %[-1.3e4 1.3e4];
% cfg.ylim     = [2 12];  % plot alpha band upwards
% cfg.layout   = 'easycap.mat';
% cfg.channel = {'P3','P4','Cz','Pz','Fz'}; 
% figure;
% ft_singleplotTFR(cfg, grandauditory_difference);
% 
% cfg          = [];
% 
% cfg.colorbar = 'yes';
% cfg.zlim     = 'maxabs';%[-10000 10000];%'maxabs'; %[-1.3e4 1.3e4];
% cfg.ylim     = [2 10];  % plot alpha band upwards
% cfg.layout   = 'easycap.mat';
% cfg.channel = {'P3','P4','Cz','Pz','Fz'}; 
% figure;
% ft_singleplotTFR(cfg, grandvisual_difference);
% 

% %% calc difference
% cfg = [];
% cfg.parameter    = 'powspctrm';
% cfg.operation    = '(x1-x2)/(x1+x2)';
% 
% grandauditory_difference = ft_math(cfg, grand_auditoryodd, grand_auditorycommon);
% grandvisual_difference = ft_math(cfg, grand_visualodd, grand_visualcommon);
% 
% 
% %% 
% cfg = [];
% cfg.layout = 'easycap.mat';
% cfg.interactive = 'yes';
% cfg.showoutline = 'yes';
% cfg.channel = {'P3','P4','Cz','Pz','Fz'};
% ft_multiplotER(cfg, sub01_common, sub01_oddball)
% 
% %%
% 
% cfg          = [];
% cfg.colorbar = 'yes';
% cfg.xlim= [0 .5];
% %cfg.baseline='yes';
% %cfg.baselinetype='db';
% cfg.zlim     = [-.2e4 .2e4];
% cfg.layout   = 'easycap.mat';
% cfg.ylim     = [2 10];
% cfg.channel  = {'P3','P4','Cz','Pz','Fz'}; 
% 
% figure;
% ft_singleplotTFR(cfg, visual_alltrials);


%% statistics

cfg = [];
cfg.method            = 'montecarlo'; 
cfg.spmversion='spm12';% use the Monte Carlo Method to calculate the significance probability
cfg.statistic = 'indepsamplesT';  % use the independent samples T-statistic as a measure to evaluate the effect at the sample level
cfg.correctm          = 'cluster';
cfg.clusteralpha      = 0.01;                   
% alpha level of the sample-specific test statistic that will be used for thresholding
cfg.clustertail       = 0;
cfg.clusterstatistic  = 'maxsum';               % test statistic that will be evaluated under the permutation distribution.
cfg.tail              = 0;                     
% -1, 1 or 0 (default = 0); one-sided or two-sided test
cfg.correcttail       = 'prob';                 
% the two-sided test implies that we do non-parametric two tests
cfg.alpha             = 0.01;                   
% alpha level of the permutation test
cfg.numrandomization  = 1000;                   
% number of draws from the permutation distribution
cfg.design            = allsubsTrials'; %visualTrials';
% design matrix, note the transpose
cfg.ivar              = 1;                     
% the index of the independent variable in the design matrix
cfg.channel           = {'P3','P4','Cz','Pz','Fz'}; 
cfg.avgoverchan = 'yes';
cfg.neighbours        = [];                     
% there are no spatial neighbours, only in time and frequency
% cfg.frequency=[2 12];
stat = ft_freqstatistics(cfg, visual_alltrials);

%%
% cfg=[];
% cfg.channel={'P3','P4','Cz','Pz','Fz'}; 
% % cfg.baseline=[-inf 0];
% cfg.renderer='painters';
% cfg.colorbar='yes';
% cfg.parameter='stat';
% figure
% ft_singleplotTFR(cfg,stat);

%% Plot the Time Frequency with Mask from stat test
% % find the channel index
% chansel  = find(strcmp(visual_alltrials.label, 'P3'));
% % select the Non-oddball trials
% leftsel  = visualTrials==1;             
% % select the Oddball trials
% rightsel = visualTrials==2;             
% 
% powspctrm_common  = mean(visual_alltrials.powspctrm(leftsel,chansel,:,:), 1);
% powspctrm_odd = mean(visual_alltrials.powspctrm(rightsel,chansel,:,:), 1);
% effect = powspctrm_odd - powspctrm_common;
% siz    = size(effect);
% effect = reshape(effect, siz(2:end)); % we need to "squeeze" out one of the dimensions, i.e. make it 3-D rather than 4-D

chanselect = [2, 13, 14, 19, 24];
effect = grandvisual_difference.powspctrm(chanselect,:,:);
effect = (mean(effect,1));
stat.effect = effect;

cfg = [];
% cfg.channel       = {'P3'};
% painters does not support opacity, openGL does
cfg.colorbar      = 'yes';
cfg.parameter     = 'effect';     
% display the power
cfg.maskparameter = 'mask';       
% use significance to mask the power
cfg.maskalpha     = 0.2;         
% make non-significant regions 30% visible
cfg.zlim          = 'maxabs';
cfg.clim          = [-1 1];
cfg.ylim          = [2 10];
cfg.xlim=[0 0.5];
figure
ft_singleplotTFR(cfg, stat);








%%
cfg = [];
cfg.method            = 'analytic';             
% calculate the analytic significance probability
cfg.statistic         = 'indepsamplesT';       
% use the independent samples T-statistic as a measure to evaluate the effect at the sample level
cfg.tail              = 0;
cfg.alpha             = 0.05;                   
% alpha level of the (single) parametric test
cfg.design            = trialType'; 
% design matrix, note the transpose
cfg.ivar              = 1;                     
% the index of the independent variable in the design matrix
cfg.channel           = {'P3','P4','Cz','Pz','Fz'}; 

% using no correction for multiple comparisons
cfg.correctm          = 'no';
statpar_no = ft_freqstatistics(cfg, visual_alltrials);

% using Bonferroni correction for multiple comparisons
cfg.correctm          = 'bonferroni';
statpar_bf = ft_freqstatistics(cfg, visual_alltrials);

% using False Discovery Rate correction for multiple comparisons
cfg.correctm          = 'fdr';
statpar_fdr = ft_freqstatistics(cfg, visual_alltrials);