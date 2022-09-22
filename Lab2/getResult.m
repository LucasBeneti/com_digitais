%{
Params:
    - in: sender bits sequence (array 1 x N)
    - fs: quantity of points per symbol
    - V: amplitude of the sender

Returns:
    - result: array 1 x N with the interpreted result

TODO:
    - add AWGN noise to the sender message
    - do the convolution with the h (pulse function frequency response)
    - according to the received array size and symbol period, 
    fetch the right sample moment
    - the decision will be made based on the value. If the value at the moment
    is greater than zero, bit 1 was sent, otherwise, bit 0 was sent.
%}
function [ result ] = getResult(in, fs, V)
    bitCount = length(in);
    s = [];
    % building the message sent signal
    for i=1:1:length(in)
        if in(i) == 0
            s = [s -1*V*ones(1,fs)];
        else
            s = [s V*ones(1,fs)];
        end
    end
    
    fim = length(s);
    ruido = randn(1,fim);
    sr = s+ruido;

    h = [ones(1,fs)];

    r = conv(sr,h)/fs;
%     fim = length(r);

%     t = 0:1/fs:fim/fs-1/fs;
%     plot(t, r);
%     xticks(1:length(in));
    
    result = zeros(1,bitCount);
    r_amostra = zeros(1, bitCount);
    for i = 1:bitCount
        sample_value = r(i*fs);
        r_amostra(i) = r(i*fs);
        if sample_value > 0
            result(i) = 1;
        else
            result(i) = 0;
        end
    end
%     t_amostra = 1:length(in);
%     hold
%     stem(t_amostra, r_amostra);
%     disp(result)
end