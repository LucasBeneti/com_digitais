clear all;

V = 0.4;
minBits = 20000;
maxBits = 50000;
Fs = 50;
Ts = 1;

bitCount = randi([minBits maxBits], [1 1]);
y = zeros([1 10000]);

% generate random sender bits
for i=1:1:bitCount
    s = randi([0 1], [1 1]);
    y(i) = s;
end

% results gets the received bits(after noise addition)
%result = getSenderBits(y, Fs, V);

%disp(currBER);

% no eixo X tenho que ter v·rios valores de BER para um range de amplitude
x_axis = 0:0.1:10; % valores de amplitude
[m,n] = size(x_axis);
berValues = zeros([m n]);

for i= 1:length(x_axis)
    result = getSenderBits(y, Fs, x_axis(i));
    berValues(i) = getBER(y,result);
end
%disp(berValues);
figure;
semilogy(db(x_axis), berValues);
xlabel('Amplitude (dB)');
ylabel('Bit Error Rate');
