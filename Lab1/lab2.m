Fs = 50;
Ts = 1;
V = 1;

% numero aleatorios de bits enviados
% arrumar uma forma interpretar qual bit estah sendo enviado
% tentar variar pra M-PAM

bit1 = V*ones(1,Fs);
bit0 = -V*ones(1,Fs);
y = [bit1 bit0 bit1 bit0 bit1];

h = [ones(1,Fs)];

r=conv(y,h)/Fs;
fim = length(r);
t = 0:1/Fs:fim/Fs-1/Fs;

t_amostra = [Fs Fs*2 Fs*3 Fs*4 Fs*5];
% r_amostra = r(t_amostra);

% criando ruido e adicionando no sinal conhecido
ruido = randn(1, length(y));
y_r = y + ruido;
r_ruido = conv(y_r,h)/Fs;
r_r_amostra = r_ruido(t_amostra);

t_amostra = t_amostra/Fs-1/Fs;
figure
plot(t, r_ruido);
hold
stem(t_amostra, r_r_amostra, 'g');
title('Sinal filtrado com ruido');
xlabel('tempo(s)');
legend('Saída do Filtro', 'Saída Amostrada');
axis([0 5 -2 2]);

% adicionar ruído gaussiano a sequencia transmitida e passe o sinal pelo
% filtro casado

