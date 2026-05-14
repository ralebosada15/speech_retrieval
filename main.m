%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE 187 FINAL PROJECT
% Created by: RAL
% Date Created: 25 April 2026
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Set-up
% Clear data and command window
clc;
clear;

% Adding file path to main
addfilepath();

% Add the filename of clean speech into clean_file
clean_file = input("Filename for clean vocals: ", "s");

% Add the filename of distorted speech into distort_file
distort_file = input("Filename for distorted vocals: ", "s");

%% Load clean speech and raw speech
[clean_speech, fs1] = audioread(clean_file);
[distort_speech, fs2] = audioread(distort_file);

clean_speech = clean_speech(:,1);
distort_speech = distort_speech(:,1);

if (length(clean_speech) > length(distort_speech))
    clean_speech = clean_speech(1:length(distort_speech));
else
    distort_speech = distort_speech(1:length(clean_speech));
end

% Compute for Evaluation Metrics before filter
[snr_before, before_clean_signal_power, before_process_signal_power] = snr(clean_speech, distort_speech);
mse_before = mse(clean_speech, distort_speech);

%% Speech Processing
% This is where you will do the filter
processed_speech = speech_filter(distort_speech, fs2);

%% Compute for Evaluation Metrics
% Signal to Noise Ratio 
[snr_after, after_clean_signal_power, after_process_signal_power] = snr(clean_speech, processed_speech);

% Mean Square Error
mse_after = mse(clean_speech, processed_speech);

%% Display of Evaluation Metrics
SNR = [snr_before; snr_after];
MSE = [mse_before; mse_after];
clean_signal_power = [before_clean_signal_power; after_clean_signal_power];
process_signal_power = [before_process_signal_power; after_process_signal_power];
Category = ["Before Filtering"; "After Filtering"];

results_table = table(Category, clean_signal_power, process_signal_power, MSE, SNR);
disp(results_table);

%% User-defined functions

% Adds file path to main
function addfilepath()
    addpath(genpath(pwd));
    addpath(fullfile(pwd, 'process'));
    addpath(fullfile(pwd, 'data'));
    addpath(fullfile(pwd, 'data/clean'));
    addpath(fullfile(pwd, 'data/distort'));
end