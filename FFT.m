%{ 
  Frederike Klimm & Olzhas Kurikov - authors
  The matlab scripts takes .csv data (volts vs time) and convert it into
  FFT spectrum. 
  The procedure has to be done twice; without Sample and with.
%}

% ------ Specifying data points for each axis ----------------------------

% .csv data name from scope
s=alu37305(:,1); 
v=alu37305(:,2);
% Choose the range of data points which is going to be processed --
    
    volts=v(3:1999); 
    seconds=s(3:1999);
% ------------------------------------------------------------------------


% ------- FIGURE 1. Original signal --------------------------------------
figure

    plot(seconds, volts)
    title('Measured Signal')
    xlabel('time in seconds')
    ylabel('Volts')
    
saveas(gcf,'Original Sample','jpg') %saves automatically as jpg
saveas(gcf,'Original Sample','fig') %saves automatically as matlab fig
% ------------------------------------------------------------------------


% ------- FFT function ---------------------------------------------------
%N=length(X);
N=16000;
X=fft(volts, N);

% ---- sampling frequency ------------------------

time=s(1999)-s(3); 
fs=1996/time; 

% -- frequency bin, frequency resolution of FFT --

fd=fs/N;
Index=0:(N-1);

% ---- frequency scale ---------------------------

f=Index*fd; 
% ------------------------------------------------------------------------

% -------Plotting FFT spectrum ----------------------------------------
%figure                          --------FFT Spectrum in whole range---
%plot(f,abs(X))
%title('FFT')
%xlabel('frequency Hz')
%ylabel('Volts')

% -------Phase Spectrum --------------------------------------------------
p = unwrap(angle(X));
%figure
%plot(f,p)
%title('phase')
%xlabel('frequency Hz')
%ylabel('rad')
% ------------------------------------------------------------------------

%take only frequency range that is requierd
phase=p(1:1999); 
freq=f(1:1999);
amplitudeV=abs(X(1:1999));
magnitude=20*log10(abs(X(1:1999))); %CONVERTION TO dB



%freq16000=freq;
%amplitude16000=amplitudeV;


% -------- FFT Spectrum in needed range ----------------------------------
figure

    plot(freq(1:200),amplitudeV(1:200), '--gs','MarkerSize',10)
    title('amplitude')
    xlabel('frequency Hz')
    ylabel('volts')
    
saveas(gcf,'FFT Sample','jpg') 
saveas(gcf,'FFT Sample','fig') 
% ------------------------------------------------------------------------

% ----------Plotting PHASE & MAGNITUDE spectrum --------------------------
figure

    subplot(1,2,1)
    plot(freq(1:200),magnitude(1:200))
    title('magnitude')
    xlabel('frequency Hz')
    ylabel('decibels')

    subplot(1,2,2)
    plot(freq(1:200),phase(1:200))
    title('phase')
    xlabel('frequency Hz')
    ylabel('phase')
    
saveas(gcf,'phase&magn_Sample','jpg') %saves automatically as jpg
saveas(gcf,'phase&magn_Sample','fig') %saves automatically as matlab fig
% ------------------------------------------------------------------------

% -------Saving files for further analysis--------------------------------
save phase_alu37305.dat phase -ascii
save amplitude_alu37305.dat magnitude -ascii
save amplV_NAME.dat amplitudeV -ascii
save freq_alu37305.dat freq -ascii
% ------------------------------------------------------------------------

