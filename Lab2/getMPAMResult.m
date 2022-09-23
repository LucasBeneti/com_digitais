function [result] = getMPAMResult(in, fs, v)
% build the input signal
    bitCount = length(in);
    pulse = ones(1,fs);
    s = [];
    for i = 1:length(in)
        if (in(i) == 0)
            s = [s -3*v*pulse];
        elseif (in(i) == 1)
            s = [s -1*v*pulse];
        elseif (in(i) == 2)
            s = [s 3*v*pulse];        
        elseif (in(i) == 3)
            s = [s 1*v*pulse];
        end
    end
 
     fim = length(s);
     ruido = randn(1, fim);
     sr = s + ruido;
 
     h = [ones(1,fs)];
 
     r = conv(sr,h)/fs;
 
     result = zeros(1,bitCount);
     r_amostra = zeros(1,bitCount);
     for it = 1:bitCount % debuggar essa parte do decisor 
         sample_value = r(i*fs);
         r_amostra(i) = r(i*fs);
         if (sample_value > v)
             result(i) = 2;
         elseif (sample_value > 0 && sample_value <= v)
             result(i) = 3;
         elseif (sample_value <= 0 && sample_value >= -v)
             result(i) = 1;
         elseif (sample_value < -v)
             result(i) = 0;
         end
     
     end

      t = 1:(length(in)*fs); % plot for testing
      figure;
      subplot(2,1,1);
      plot(t,s);
      subplot(2,1,2);
      plot(t,sr);
      
      
      fim2 = length(r);
      figure;
      t = 0:1/fs:fim2/fs-1/fs;
      plot(t, r);
      xticks(1:length(in));
      hold
      t_amostra = 1:length(in);
      stem(t_amostra, r_amostra);      
      xlim([0 fs*length(in)]);
      ylim([-4 4])
      disp(restul);
    
end