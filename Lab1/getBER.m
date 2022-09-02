function [error] = getBER(sent, received)
%GETBER Summary of this function goes here
%   Detailed explanation goes here
    receivedInvert = -1*received;
    wrongBits = (sum(sent + receivedInvert));
    error = wrongBits/length(sent);
end

