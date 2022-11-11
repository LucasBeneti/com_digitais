clear all
close all
clc

% -> Gere a forma de onda a ser transmitida usando 8PSK e 16QAM, 
% com e sem portadora (ou seja, em banda passante e em banda base).
% -> Mostre a constelação das modulações e o sinal no domínio do tempo 
% (alguns recortes são suficientes neste caso) com e sem ruído adicionado.
% -> Mostre também o sinal em banda base e banda passante no domínio da frequência. 
% Use pulsos de formatação de espectro (sinc ou raiz de cosseno levantado) e ao menos 1000 bits.
% -> Utilize uma frequência de portadora suficiente para afastar bem o 
% espectro do sinal em banda passante do eixo da frequência zero.

% 8-PSK
M = 8;
data = randi([0 M-1],1000,1);
txSig = pskmod(data,M,pi/M);
rxSig = awgn(txSig,20);
% cd = comm.ConstellationDiagram('ShowReferenceConstellation',false);
% cd(txSig)

% figure where two scatterplots will end up:
f = figure('Color',[0 0 0]);
scatter_fig = scatterplot(txSig); % create scatterplot
copyobj(get(scatter_fig,'Children'),f); % copy everything from scatterplot figure to f
delete(scatter_fig); % delete scatterplot figure
scatter_fig = scatterplot(rxSig); % create scatterplot
copyobj(get(scatter_fig,'Children'),f); % copy everything from scatterplot figure to f
delete(scatter_fig); % delete scatterplot figure
% re-position the two axes in figure f:
ax = findall(f,'Type','axes');
set(ax(2),'Position',[0.1 0.11 0.38 0.815]);
set(ax(1),'Position',[0.6 0.11 0.38 0.815]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 16-QAM
M = 16;      % Modulation order (alphabet size or number of points in signal constellation)
k = log2(M);
data = randi([0 1],1000*k,1);
txSig = qammod(data,M,'InputType','bit','UnitAveragePower',true);
rxSig = awgn(txSig,25);
% cd2 = comm.ConstellationDiagram('ShowReferenceConstellation',false);
% cd2(txSig)

% figure where two scatterplots will end up:
f1 = figure('Color',[0 0 0]);
scatter_fig = scatterplot(txSig); % create scatterplot
copyobj(get(scatter_fig,'Children'),f1); % copy everything from scatterplot figure to f
delete(scatter_fig); % delete scatterplot figure
scatter_fig = scatterplot(rxSig); % create scatterplot
copyobj(get(scatter_fig,'Children'),f1); % copy everything from scatterplot figure to f
delete(scatter_fig); % delete scatterplot figure
% re-position the two axes in figure f:
ax = findall(f1,'Type','axes');
set(ax(2),'Position',[0.1 0.11 0.38 0.815]);
set(ax(1),'Position',[0.6 0.11 0.38 0.815]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(3)
xi = sinc(1e6);
xq = -3*sinc(1e6);
A = sqrt(xi^2+xq^2);
theta = atan(xq/xi); % tangente inversa
fc = 1e7;
BB = A*cos(2*pi*fc+theta);
x = linspace(-15,15);
plot(x,BB)
BP = cos(x);

plot(x,BB,x,BP)
legend('Sinal BB','Sinal BP')
xlabel('Frequência (Hz)') 
ylabel('y(dB)') 


% 16-QAM
% M = 16;
% x = (0:M-1)';
% y = qammod(x,M);
% scatterplot(y)

