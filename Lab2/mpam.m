close all;
clear all;

Fs = 50;
Ts = 1;

% 4-PAM signal

minBits = 10;
maxBits = 20;
bitCount = randi([minBits maxBits], [1 1]);
y_sent = zeros([1 bitCount]);

% getting random sending sequence
for i = 1:bitCount
    y_sent(i) = randi([0 3], [1 1]);
end

V = 1;
y_result = getMPAMResult(y_sent, Fs, V);

disp(y_sent);
disp(y_result);

