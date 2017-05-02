function [ ] = plotSineFunction( Fs, totalSamples )
% Plots 2Hz sine wave. Length of wave depends on total amount of samples
% and sample rate
%
% Inputs
%   (int) Fs             sample rate
%   (int) totalSamples   total samples in an audio signal

    figure; 
    title('Sine Function'); 
    xlabel('Time (s)'); 
    ylabel('Samples');
    hold on;
    Fc = 2;         % sine wave at 2Hz
    t = (0:1/Fs:(totalSamples/Fs)-(1/Fs));  % time range
    x = ((sin(2*pi*Fc*t))*500)+3000;      % x values

    plot(t,x);
