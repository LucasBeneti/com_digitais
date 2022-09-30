%Neste exemplo N0 é mantido fixo e a amplitude dos símbolos varia em função de
%Eb/N0. Outra alternativa é manter a amplitude dos símbolos fixa e variar
%N0 em função de Eb/N0.

%A resposta ao impulso do filtro casado é considerada de energia unitária
%(EMF=1)
%Os símbolos 's' são gerados originalmente como +1 e -1, com energia
%unitária portanto, e sua amplitude é variada de acordo com o valor de Eb necessário para obter a razão Eb/N0 pretendida.

%A simulação é discreta, a partir dos símbolos a serem transmitidos (s)
%geramos a saída amostrada do filtro casado (y).

% nesse lab realmente só precisa variar o EbN0 pra ver se a BER piora e
% tal, aí a parte de comparar com o lab anterior eu não sei exatamente o
% que fazer...mas vou seguindo com o que eu acho que é, que é simplesmente
% usar o mesmo range de variação da amplitude pros dois labs

close all;
clear all;

rand('state',0);
randn('state',0);

bits=1e5; %Número de bits a serem simulados.
M=4; %2-PAM, dois símbolos possíveis na modulação.

% tem que arrumar a sequencia randomica de bits
% o ruido da pra manter
% tem que ver se faz sentido a normalizacao da na amplitude
% o decisor de qual bit é o correto tbm vai mudar

% generate random 4-PAM bit sequence


%b=rand(1,bits)>0.5; %Geração de bits 0 e 1 equiprováveis.

%s=2*b-1; %Eb a princípio seria 1, já que as amplitudes são +1 e -1. Es também seria 1, já que a modulação é binária (1 bit -> 1 símbolo).
N0=1; %N0 será fixa em 1.
n=randn(1,bits)*sqrt(N0/2); %EMF foi suposto como 1, portanto a variância do ruído após o filtro casado é N0/2 apenas.

snr_vary = 0:0.1:5;
ber_values = zeros(1, length(snr_vary));
pb_values = zeros(1, length(snr_vary)); % valores da funcao de acordo com a EbN0
for i = 1:length(snr_vary)
    EbN0dB=snr_vary(i); %Valor de Eb/N0 a ser considerado na simulação.
    EbN0=10^(EbN0dB/10); %Eb/N0 em escala linear.
    Eb=EbN0*N0; %Eb requerido para atingir a razão Eb/N0 de interesse.
    Es=2*Eb; %Es calculado a partir de Eb. Como a modulação é binária Es=Eb.
    v = sqrt(Es/5);% getting the current voltage amplitude

    [symbol_sequence, sending_signal]= generate4PAMSequence(bits, v);
    y = sending_signal+n; %A amplitude dos símbolos transmitidos é alterada de modo que a energia média seja Es, e consequentemente Eb seja aquela desejada.
    
    b_est = get4PAMDecision(y, v);
    erros = sum(symbol_sequence~=b_est); %Contagem de erros.
    ber_values(i) = erros/bits; %Cálculo da BER.
    pb_values(i) = (3/2)*qfunc(sqrt((4/5)*EbN0)); %BER teórica atualizada pro caso de 4-PAM
end

% nao esta dando nenhum erro na transmissao por algum motivo...amplitude
% esta alta demais?

% plot para comparar
figure
semilogy(db(snr_vary), ber_values);
hold
semilogy(db(snr_vary), pb_values);
title('Compare BER and PQ');
xlabel('Eb/N0 (dB)');
ylabel('BER values');
legend('calculated BER', 'Q function');