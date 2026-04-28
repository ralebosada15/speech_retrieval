%% Signal-to-Noise Ratio function
% Outputs signal-to-noise ratio given the reference signal and noisy
% signal.

function [snr_db, signal_power, noisy_power] = snr(clean_speech, process_speech)
    % Computation of Power of Clean Signal and Noisy Signal
    signal_power = mean(clean_speech.^2);
    noisy_power = mean(process_speech.^2);

    snr_db = 10*log10(signal_power/noisy_power);
end