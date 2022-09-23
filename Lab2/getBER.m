function [error] = getBER(sent, received)
    signalSize = length(sent);
    wrongBits = 0;
    for i = 1:signalSize 
        if(sent(i) ~= received(i))
            wrongBits = wrongBits + 1;
        end
    end

%     receivedInvert = -1*received;
%     wrongBits = (sum(sent + receivedInvert));
    error = wrongBits/length(sent);
%     if(error < 0)
%         error = -1 * error;
%     end
end

