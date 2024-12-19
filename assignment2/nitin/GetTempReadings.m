function temps = GetTempReadings(b_array, n_pre, n_data, n_post)
    n_frame = n_pre + n_data + n_post;
    frames = length(b_array)/n_frame;
    b_array = reshape(b_array,[n_frame frames])';
    b_array = b_array(:,(n_pre+1):(n_pre+n_data));
    b_array = b_array';
    temps = bit2int(b_array,n_data);
    temps = temps  - (2^n_data).*(temps>2^(n_data-1));

    temps = temps/10;
end