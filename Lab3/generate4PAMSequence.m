function [symbolSequence, sendingSignal] = generate4PAMSequence(symbolCount, v)
    possibleSymbols = 0:3;
    symbolSequence = zeros(1, symbolCount);
    sendingSignal = zeros(1, symbolCount);
    for i = 1:symbolCount
        temp_val = possibleSymbols(randi(4,1));
        symbolSequence(i) = temp_val;
        switch temp_val
            case 0
                temp_val = -3*v;
            case 1
                temp_val = -v;
            case 2
                temp_val = v;
            case 3
                temp_val = 3*v;
            otherwise
                temp_val = 0;
        end
        sendingSignal(i) = temp_val;
    end

end

