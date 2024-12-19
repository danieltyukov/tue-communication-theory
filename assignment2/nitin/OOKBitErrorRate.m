function ber = OOKBitErrorRate(b, b_tilde)
    ber = 1 - mean(b'==b_tilde);
end