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