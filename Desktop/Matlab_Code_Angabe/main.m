%main function

clc;
clear;
close all;

%------------------------------------------------------------------
% Initialization
%------------------------------------------------------------------
cfg = [];
sig = [];
flt = [];


%add path of filterbank m-files (required if beamformer design is
% applied)
addpath(genpath('filterbank'));

%add path of beamformer m-files (required if FSB beamformer design is
% applied)
addpath(genpath('Generalized_RLSFI_BF'));
% 
cfg.design = 'freefield';
% cfg.design = 'hrtf';
cfg.wng_limit_db = -15;
cfg.look_azimuth = 90; %azimuth angle
cfg.look_elevation = repmat(90 - atand(0.73/1.1), length(cfg.look_azimuth)); %elevation

%------------------------------------------------------------------
% Set Acoustical scenario parameters (parameters are stored in cfg
% structure
%------------------------------------------------------------------
[cfg] = SetAcousticScenario(cfg);

%------------------------------------------------------------------
% Create microphone signals (signals are stored in sig structure, RIRs in
% flt structure
%------------------------------------------------------------------
[cfg,sig,flt] = LoadMicInputs(cfg,sig,flt);
 
%------------------------------------------------------------------
%perform beamformer design (of robust FSB)
%------------------------------------------------------------------
% flt.w = main_robust_FSB(cfg, cfg.look_azimuth, cfg.look_elevation, cfg.design, cfg.wng_limit_db);

%------------------------------------------------------------------
% Create microphone signals (signals are stored in sig structure) at
% beamformer output signal
%------------------------------------------------------------------
% sig.y = zeros(length(sig.x)+length(flt.w)-1,1);
% sig.ySrc = zeros(length(sig.x)+length(flt.w)-1,cfg.nsrc);
% for idx_channels = 1:cfg.nmic
%     sig.y  = sig.y + fftfilt(flt.w(:,idx_channels), ...
%         [sig.x(:,idx_channels); zeros(length(flt.w)-1,1)]);
%     
%     for idx_sources = 1:cfg.nsrc
%         sig.ySrc(:,idx_sources) = sig.ySrc(:,idx_sources) + fftfilt(flt.w(:,idx_channels), ...
%             [sig.xSrc(:,idx_channels,idx_sources); zeros(length(flt.w)-1,1)]);
%     end
% end
% 
% %------------------------------------------------------------------
% % Potential place for postfilter
% %------------------------------------------------------------------
% 
% %------------------------------------------------------------------
% % Evaluation regarding the fwsegsnr, PESQ score and ASR score
% %------------------------------------------------------------------
% switch cfg.design
%     case 'freefield'
%         [sig, cfg, res.freefield{idx_phi}] = Evaluation(sig, cfg);
%     case 'hrtf'
%         [sig, cfg, res.hrtf{idx_phi}] = Evaluation(sig, cfg);
% end
% 
% %------------------------------------------------------------------
% % save results (if needed)
% %------------------------------------------------------------------
% save(['saves/nameOfResultFile' '.mat'], 'res');