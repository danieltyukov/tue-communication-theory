function temps = GetTempReadings(b_array, n_pre, n_data, n_post)
    n_frame = n_pre + n_data + n_post;
    num_frames = length(b_array) / n_frame;
    frames = reshape(b_array, n_frame, num_frames)';
    
    temp_bits = frames(:, (n_pre+1):(n_pre+n_data));
    
    % two's complement
    temps = bi2de(temp_bits, 'left-msb');
    temps = temps - (2^n_data) .* (temps >= 2^(n_data-1));
    
    temps = temps / 10;
end
