close all;
clear all;

Fs = 50;
Ts = 1;

% 4-PAM signal

minBits = 20000;
maxBits = 30000;
bitCount = randi([minBits maxBits], [1 1]);
y_sent = zeros([1 bitCount]);

% getting random sending sequence
for i = 1:bitCount
    y_sent(i) = randi([0 3], [1 1]);
end

% V = 10;
% y_result = getMPAMResult(y_sent, Fs, V);

var_ampl = 0:0.1:10; % tirar duvida relacionada ao ajuste da amplitude
% valores de BER (eixo y)
berValues = zeros(1,length(y_sent));
% valores de energia (eixo x)
x_energy = zeros(1,length(y_sent));
for it = 1:length(var_ampl)
    y_received = getMPAMResult(y_sent, Fs, var_ampl(it));
    berValues(it) = getBER(y_sent, y_received);
    x_energy(it) = ((var_ampl(it)^2)*Ts*Fs);
end

figure;
semilogy(db(x_energy), berValues);
title('BER Filtro Casado')
xlabel('Energia da onda(dB)');
ylabel('Bit Error Rate');