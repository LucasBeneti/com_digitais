% function to get the interpreted value from the sender
% refatorar essa funcao pra fazer o decisor seguindo esquema da conv
function [ result ] = getReceivedBits(in, fs, V)
    bitCount = length(in);
    s = [];
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
    src = reshape(sr,[],bitCount);

    result = zeros(1,bitCount);
    for i = 1:bitCount
        col = src(:,i);
        bit = round(mean(col), 0);
        if bit > 0
            bit = 1;
        else
            bit = 0;
        end
        result(i) = bit;
    end
end