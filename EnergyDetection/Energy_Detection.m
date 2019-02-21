%% Energy Detection in Time Domain
% This example shows you how to detect the energy of a discrete-time signal 
% over a finite interval using the RMS (Root Mean Square) value of the signal. 
% By defintion, the RMS value over a finite interval $-N\le n\le N$ is given by 
% :
% 
% $$\mathit{RMS}=\sqrt{\frac{1}{2N+1}\sum_{-N}^N {|x\left(n\right)|}^2 }$$ 
% 
% The enrgy of a discrete-time signal over a finite interval $-N\le n\le 
% N$ is given by :
% 
% $$E_{N\;} =\sum_{-N}^N {|x\left(n\right)|}^2$$
% 
% To determine the signal energy from RMS value, square the RMS value and 
% multiply the result by the number of samples that are used to compute the RMS 
% value.
% 
% $$E_N ={\mathit{RMS}}^2 \times \left(2N+1\right)$$
% 
% To compute the RMS value in MATLAB and Simulink , use the moving system 
% object and block, respectively.
% 
% For the moment we will not use this method, instead we recommand to use 
% Mathematic formula of Energy and try to implement it in MATLAB.
%% I-  Detect Signal Energy
% This example shows how to compute the energy of a signal by applying the Energy  
% formula. So, we will start coding it in MATLAB as shown below :
% 
% $E_{N\;} =\sum_{-N}^N {\left|x\left(n\right)\right|}^2$  Energy Formula 
% : $\left(2N+1\right)$ : Number of samples
% 
%                                                       : $\left|x\left(n\right)\right|$ 
% : Module of samples
% 
% For an algorithm very efficient we start to calculate the square of all 
% the samples and add them each element with the previous elements.

clear
load ToneParameters.mat
%%
squareSinusPulse = abs(sinusPulse).^2;  % |x(i)|

Energy(length(sinusPulse)) = 0;         % Initialize the Energy buffer 

Energy(1) = squareSinusPulse(1);

for i = 1:length(sinusPulse)-1
    Energy(i+1) = Energy(i) + squareSinusPulse(i+1);    % Sweep each element of the array
end
%% 
% Choose a random threshold to compare it with Energy values then plot the 
% boolean signal.

threshold(length(sinusPulse)) = 0;  % Initialize the array of threshold
for i = 1:length(sinusPulse)
    threshold(i) = 120;         % random threshold
end
%%
plot(Energy)
hold on
plot(threshold,'r')
xlim([0 length(sinusPulse)])
title('sinusPulse Energy Accumulation + Threshold')
legend('Energy','threshold')
hold off
%%
event = Energy >= threshold;        % event = 1 if Energy value >= threashold
                                    % event = 0 if Energy value < threashold 
plot(event)
title('Detection of the Energy > Threshold')
xlim([0 length(sinusPulse)])
ylim([-.2 1.2])
%% References :
% * <https://www.idc-online.com/technical_references/pdfs/data_communications/ENERGY%20DETECTION.pdf 
% https://www.idc-online.com/technical_references/pdfs/data_communications/ENERGY%20DETECTION.pdf>
% 
% * <https://www.mathworks.com/help/dsp/ug/energy-detection-in-time-domain.html 
% https://www.mathworks.com/help/dsp/ug/energy-detection-in-time-domain.html>