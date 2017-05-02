function [newSignal, Fs] = delay(audioFile)
% delay - function delay takes an audio file as input (e.g. 'rockA.wav') 
% and returns a new signal with delay times modulated by a sine function at
% 2Hz
%
% Inputs
%   (file)   audioFile      original audio file to add delay. File formats
%                           accepted are equivalent to those accepted by 
%                           audioread
%  
% Outputs
%   (matrix) newSignal      new signal generated with the delay implemented
%                           (size is same as original audio file)
%   (int)    Fs             sample rate of newSignal based on sample rate 
%                           of input audio file

    % reads input audio file. y is the samples, Fs is the sample rate
    [y,Fs] = audioread(audioFile); 
    
    % returns total number of samples from original audio file
    totalSamples = size(y, 1);   
    
    % returns number of channels (e.g. mono (1), stereo (2)) from original
    % audio file
    noChannels = size(y, 2);
    
    newSignal = zeros(totalSamples, noChannels);      
    for i=1:totalSamples
        i  % kept i to show progression (prints iteration number)
        x = i/Fs;       % seconds per sample
        
        % value from sine function at time x, rounded to an int because
        % int required for indexing
        s = uint32(sineFunction(x, 2));
        
        % apply delay to each channel of audio file
        for c=1:noChannels
            now = y(i,c);         % current value

            % find value of song s samples ago by indexing into the past.
            % If previous value is before beginning of song, set previous
            % to 0, else set previous to the value at index i-s
            if (i-s) <= 0
                previous = 0;
            else
                previous = y(i-s,c);
            end

            % set wet/dry mix ratio at 0.7 (70%) - meaning new signal 
            % consists of 70% of the current value and 30% of the previous
            % value (delay)
            dry = 0.7;      
            value = (now * dry) + (previous * (1-dry)); 
            newSignal(i,c) = value;     % add new value to the new signal
        end
    end
end

function x = sineFunction(t, Fc)
% Returns the value x from a sine function at given moment t
%
% Inputs
%   (double) t    time in seconds
%   (scalar) Fc   frequency of sine wave (Hz)
%
% Outputs
%   (scalar) x    value of sine function at time t
    
    % Amplitude of sine function is increased by 500
    % Sine wave is shifted up by 3000
    x = ((sin(2*pi*Fc*t))*500)+3000;
end 
