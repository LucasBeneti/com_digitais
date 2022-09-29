function [d] = get4PAMDecision(signalReceived,v)
    d = zeros(1, length(signalReceived));
    for i = 1:length(signalReceived)
        if(signalReceived(i) < -2*v)
            d(i) = 0;
        elseif (signalReceived(i) >= -2*v && signalReceived(i) <= 0) 
            d(i) = 1;
        elseif (signalReceived(i) > 0 && signalReceived(i) <= 2*v)
            d(i) = 2;
        elseif (signalReceived(i) > 2*v)
            d(i) = 3;
        end
    end
end

