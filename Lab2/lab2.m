clear all
Fs = 50;
Ts = 0.1;

% numero aleatorios de bits enviados
% arrumar uma forma interpretar qual bit estah sendo enviado
% tentar variar pra M-PAM

minBits = 20000;
maxBits = 30000;
bitCount = randi([minBits maxBits], [1 1]);
y_sent = zeros([1 bitCount]);

% generate random sender bits sequence
for i=1:1:bitCount
    s = randi([0 1], [1 1]);
    y_sent(i) = s;
end

% variar valores de amplitude
var_ampl = 0:0.1:10;
% valores de BER (eixo y)
berValues = zeros(1,length(y_sent));
% valores de energia (eixo x)
x_energy = zeros(1,length(y_sent));
for i = 1: length(var_ampl)
    y_received = getResult(y_sent, Fs, var_ampl(i));
    berValues(i) = getBER(y_sent, y_received);
    x_energy(i) = ((var_ampl(i)^2)*Ts*Fs);
end

figure;
semilogy(db(x_energy), berValues);
title('BER Filtro Casado')
xlabel('Energia da onda(dB)');
ylabel('Bit Error Rate');

% axis([0 5 -2 2]);