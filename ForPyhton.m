%{
  Frederike Klimm & Olzhas Kurikov - authors
  This Matlab code generates 3 columns database with frequnecy, magnitude
  and phase for Python GDA algortihm to characterise a material.
  Import generated data from "FFT.m" to compute needed data for 
  Python.
%}

% -------Taken phase difference & magnitude difference -------------------
% calculate difference for phase and magnitude (amplitude)
% and convert frequency row to column to have x axis

%variable=sample - no sample

phase=phasealu37305 - phasenos2305;             
amplitude=amplitudealu37305 - amplitudenos2305;          
freq=freqnos2305;
f=freq';                                        
% ------------------------------------------------------------------------

% ------- FIGURE 1.Plotting only difference in whole range of freq.-------
figure
% --- magnitude vs frequency ----

    subplot(2,1,1)
    plot(f, amplitude)
    title('Magnitude spectrum')
    xlabel('Frequency Hz')
    ylabel('db')
    
% --- phase vs frequency --------

    subplot(2,1,2)
    plot(f, phase)
    title('Phase spectrum')
    xlabel('Frequency Hz')
    ylabel('rad')
% ------------------------------------------------------------------------

% ------- FIGURE 2.Taking the needed range -------------------------------
figure

% ------- magnitude wise range -------------------------------------------

    subplot(1,2,1)
    hold all
    plot(f(82:300), amplitude(82:300), 'LineWidth',3, 'Color',[0 0.4470 0.7410])
    plot(f(1:500), amplitude(1:500),'--go','Color',[0 0.4470 0.7410])
    plot(f(1:500), amplitudenos2305(1:500),'--go','Color',[0.30000 0.3250 0.0980])
    plot(f(1:500), amplitudealu37305(1:500), '--go','Color',[0.9290 0.6940 0.1250])
    xlabel('frequency in Hz')
    ylabel('dB')
    title('magnitude spectrum')

% ------- phase wise range -----------------------------------------------

    subplot(1,2,2)
    hold all
    plot(f(82:300), phase(82:300), 'LineWidth',3, 'Color', [0 0.4470 0.7410])
    plot(f(1:100), phase(1:100), 'Color', [0    0.4470    0.7410])
    plot(f(1:100), phasenos2305 (1:100), 'Color', [0.30000    0.3250    0.0980])
    plot(f(1:100), phasealu37305(1:100), 'Color', [0.9290    0.6940    0.1250])
    title('phase spectrum')
    xlabel('frequency in Hz')
    ylabel('rad')
% ------------------------------------------------------------------------
set(gcf,'units','centimeter')
set(gcf,'Position',[0 0 21 8])
saveas(gcf,'difference','jpg') %saves automatically as jpg
saveas(gcf,'difference','fig') %saves automatically as matlab fig
% ------------------------------------------------------------------------


% ------- FIGURE 3.Savitzky-Golay filter to smooth ----------------------- 

% filter function(data vector, order, framelen)

smtlb = sgolayfilt(amplitude,3,41);
% -----------------------------------------------------
figure

% --- applies smoothing on the needed range of data ---

    hold all
    plot(f(1:500), amplitude(1:500))
    plot(f(1:500), smtlb(1:500))
    plot(f(10:300),smtlb(10:300), '--go')
% -----------------------------------------------------   
saveas(gcf,'smooth','jpg')
saveas(gcf,'smooth','fig')
% -----------------------------------------------------

% ------- FIGURE 4. Applying Hampel filter -------------------------------

% Hampel filter is applied to remove some outliers from the 
% data to produce relatively nice theoretical fit in Python.

%X=PY_alu3_short(:,1); % frequency
%Y=PY_alu3_short(:,2); % magnitude

% ---- hampel filter funtion --------------------------------

% y - returns values with outliners replaced by local median
% i - a logical matrix that is true (1) at the locations of 
%     all points identified as outliers
% xmedian - local medians
% xsigma - standard deviation of data point from local median
% Y - magnitude wise data

[y,i,xmedian,xsigma]=hampel(amplitude,4,1);
% -----------------------------------------------------------

figure
% -----------------------------------------------------------
    plot(f(21:65),amplitude(21:65), '--bo')
    title('hample filter with 1*sigma, window +-4')
    hold on
    %plot(f,xmedian-3*xsigma,f,xmedian+3*xsigma)
    %plot(X,xmedian)
    plot(f(21:65),y(21:65), '-go')
    legend('Outliers','Lower limit','Upper limit','filtered data')
% -----------------------------------------------------------
saveas(gcf,'hampel filter','jpg')
saveas(gcf,'hampel filter','fig')

% ------------------------------------------------------------------------

% -------- GENERATES DIFFERENT OUTPUTS FOR PYTHON ------------------------

% Generates .dat file for python with three columns 
% Columns are frequency, difference magnitude and phase

% ----- PY1.Three columns in whole range ---------------------

    PY_alu3=table(f, amplitude, phase);
    writetable(PY_alu3,...
     'PY_alu3.dat', 'Delimiter',...
     ' ','writevariableNames',false); 
% ------------------------------------------------------------
% ----- PY2.Three columns in shorter range -------------------

    PY_alu3_short_mixed=table(f(82:300),...
        amplitude(82:300), phase(82:300));
    writetable(PY_alu3_short_mixed,...
     'PY_alu3_short_mixed.dat','Delimiter',...
     ' ','writevariableNames',false); 

% ------------------------------------------------------------

% ----- PY3.Three columns in shorter range with smoothing filter -

    PY_alu3_short_smooth=table(f(23:80),...
        smtlb(23:80), phase(23:80));
    writetable(PY_alu3_short_smooth,...
        'PY_alu3_short_smooth.dat', 'Delimiter',...
        ' ','writevariableNames',false); 
% ------------------------------------------------------------

% ----- PY4.Three columns in shorter range with HAMPEL filter-
  
    PY_alu3_short_hampel=table(f(21:65),...
        y(21:65), phase(21:65));
    writetable(PY_alu3_short_hampel,...
        'PY_alu3_short_hampel.dat', 'Delimiter',...
        ' ','writevariableNames',false);    
% ------------------------------------------------------------------------