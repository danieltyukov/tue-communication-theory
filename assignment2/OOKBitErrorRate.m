function ber = OOKBitErrorRate(b, b_tilde)
    % numb bit errors`
    bit_errors = sum(b ~= b_tilde);
    
    % (BER)
    ber = bit_errors / length(b);
end
