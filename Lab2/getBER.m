function [error] = getBER(sent, received)
    receivedInvert = -1*received;
    wrongBits = (sum(sent + receivedInvert));
    error = wrongBits/length(sent);
    if(error < 0)
        error = -1 * error;
    end
end

