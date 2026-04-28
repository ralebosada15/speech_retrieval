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
clean_file = "Vitas - 7th Element.mp3";

% Add the filename of distorted speech into distort_file
distort_file = "set1_A.mp3";

%% Load clean speech and raw speech
[clean_speech, fs1, distort_speech, fs2] = read_speech(clean_file, distort_file);
clean_speech = clean_speech(:,1);
distort_speech = distort_speech(:,1);

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
    addpath("./process");
    addpath("./data" );
    addpath("./data/clean");
    addpath("./data/distort");
end

% Loads the clean speech and distorted speech
function [y1, f1, y2, f2] = read_speech(clean_file, distort_file)
    clean_filepath = "./data/clean/";
    distort_filepath = "./data/distort/";
    [y1, f1] = audioread(clean_filepath + clean_file);
    [y2, f2] = audioread(distort_filepath + distort_file);
end
