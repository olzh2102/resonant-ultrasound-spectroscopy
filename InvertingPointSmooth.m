%Inverting the point between two peaks 

% -------- Loading data from ForPython.m ---------------------------------
f=PYalu3short(:,1); 
v=PYalu3short(:,2);
f1=PYalu3short(:,1); 
v1=PYalu3short(:,2);
% ------------------------------------------------------------------------
%%
% -------- Choosing the data point as a reference line -------------------

%av=(v(14)+v(20))/2 %average of two peaks
av=v(14); %take max peak as reference line


%datapoints
v1(15)=v(15)-2*(v(15)-av);
v1(16)=v(16)-2*(v(16)-av);
v1(17)=v(17)-2*(v(17)-av);
v1(18)=v(18)-2*(v(18)-av);
v1(19)=v(19)-2*(v(19)-av);

%%
%hampel filter
[hampel,i,xmedian,xsigma]=hampel(v1,3,3);
%%
%sgolayfit
smtlb = sgolayfilt(v1,3,5);

%%
% -------- All the figures -----------------------------------------------
figure

% -- Original Graph and Inverted Point Graph --
    subplot(1,2,1)
    hold all
    plot(f1,v1, 'go-')
    plot(f,v, 'o')
    refline(0,av)
    hold off
% -- Hampel (Blue Dot) Graph and Smooth (Red Dot) Graph --
    subplot(1,2,2)
    hold all
    plot(f1,v1, 'go-')
    plot(f,smtlb, 'ro')
    plot(f,hampel, 'bo')
% ------------------------------------------------------------------------
%%
% ----- Using Smooth Filter, cause shows better graph --------------------

% -- in this case use smtlb (smoothed), cut data --
fsmtlb=f(1:40);
vsmtlb=smtlb(1:40);

% -- Short Data with Smooth Filter applied and inverted point --
    figure
    hold all
    plot(fsmtlb,vsmtlb, 'go-')
    plot(f,v, 'o')
    refline(0,av)
% ------------------------------------------------------------------------
phase=PYalu3short(:,3);
phaseshort=phase(1:40);
%%

%%
%PY_alu3_invert=table(fshort,...
%        vshort, phaseshort);
%    writetable(PY_alu3_invert,...
 %    'PY_alu3_hample_invert.dat','Delimiter',...
 %    ' ','writevariableNames',false); 
 
% ----- Saving Data for Python processing -------------------------------- 
 
PY_alu3_invert_smooth=table(fsmtlb,...
        vsmtlb, phaseshort);
    writetable(PY_alu3_invert_smooth,...
     'PY_alu3_invert_smooth.dat','Delimiter',...
     ' ','writevariableNames',false); 