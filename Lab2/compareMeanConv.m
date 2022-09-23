close all;
clear all;

Fs = 50;
Ts = 1;

minBits = 20000;
maxBits = 30000;
bitCount = randi([minBits maxBits], [1 1]);
y_sent = zeros([1 bitCount]);

% generate random sender bits sequence
for i=1:bitCount
    s = randi([0 1], [1 1]);
    y_sent(i) = s;
end

% variar valores de amplitude
var_ampl = 0:0.1:10;
% valores de BER (eixo y)
meanBerValues = zeros(1,length(y_sent));
convBerValues = zeros(1,length(y_sent));
% valores de energia (eixo x)
x_energy = zeros(1,length(y_sent));

for it = 1:length(var_ampl)
    y_received_mean = getMeanReceivedBits(y_sent, Fs, var_ampl(it));
    y_received_conv = getResult(y_sent, Fs, var_ampl(it));
    
    meanBerValues(it) = getBER(y_sent, y_received_mean); % BER mean method
    convBerValues(it) = getBER(y_sent, y_received_conv); % BER conv method
    
    x_energy(it) = ((var_ampl(it)^2)*Ts*Fs); % both use the same
end

figure;
semilogy(db(x_energy), meanBerValues);
hold
semilogy(db(x_energy), convBerValues);
title('BER Filtro Casado')
xlabel('Energia da onda(dB)');
ylabel('Bit Error Rate');
legend('Mean BER','Conv BER')

