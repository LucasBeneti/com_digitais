close all;
clear all;

minBits = 20000;
maxBits = 50000;
Fs = 50;
Ts = 1;

bitCount = randi([minBits maxBits], [1 1]);
y = zeros([1 10000]);

% generating random sender bits
for i=1:1:bitCount
    s = randi([0 1], [1 1]);
    y(i) = s;
end

x_axis = 0:0.1:10; % valores de amplitude
[m,n] = size(x_axis);
berValues = zeros([m n]);

for i = 1:length(x_axis)
    result = getReceivedBits(y, Fs, x_axis(i));
    berValues(i) = getBER(y,result);
end

figure;
semilogy(db(x_axis), berValues);
xlabel('Amplitude (dB)');
ylabel('Bit Error Rate');
