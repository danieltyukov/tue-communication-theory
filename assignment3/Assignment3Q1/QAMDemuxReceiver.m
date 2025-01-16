function r_k = QAMDemuxReceiver(r_t, psi, phi, T0, T)
    % down-convert to baseband
    % received signal multiploed by carrier waveform to get back th it back
    % to baseband
    baseband_signal = r_t .* psi;

    % matched filtering
    % baseband signal convolved with the reverse of phi (building block
    % signal) to improve SNR
    matched_filter_output = conv(baseband_signal, flip(phi), 'same');

    % sampling
    num_symbols = length(r_t) / T;
    r_k = zeros(1, num_symbols);

    % convolution performed through the loop
    for k = 0:(num_symbols - 1)
        sample_idx = T0 + k * T;
        if sample_idx <= length(matched_filter_output)
            r_k(k + 1) = matched_filter_output(sample_idx);
        else
            % out of bound indexing issue problemo
            break;
        end
    end
end
