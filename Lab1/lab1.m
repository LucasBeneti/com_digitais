clear all;

V = 0.4;
minBits = 1000;
maxBits = 2000;
Fs = 50;
Ts = 1;

bitCount = randi([minBits maxBits], [1 1]);
y = [];

for i=1:1:bitCount
    s = randi([0 1], [1 1]);
    y = [y s];
end

result = getSenderBits(y, Fs, V);

% tem que enviar pelo menos 100 bits pra valer a medida de erro
currBER= getBER(y,result);
disp(currBER);

% 