%% Mean Squared Error function
% Outputs MSE of Clean and Processed Signal

function mse_value = mse(clean_speech, process_speech)
    % Ensure both signals have same length
    min_len = min(length(clean_speech), length(process_speech));

    clean_signal = clean_speech(1:min_len);
    processed_signal = process_speech(1:min_len);

    % Compute error
    error_signal = clean_signal - processed_signal;

    % Compute MSE
    mse_value = mean(error_signal.^2);
end