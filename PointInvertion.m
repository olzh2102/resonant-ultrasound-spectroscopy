f=PYTHONalu3short(:,1); 
v=PYTHONalu3short(:,2);
f1=PYTHONalu3short(:,1); 
v1=PYTHONalu3short(:,2);
%%
[v,i,xmedian,xsigma]=hampel(v,6,1); %problem: filters the minimum point
%between peaks
[v1,i,xmedian,xsigma]=hampel(v1,6,1);

%%
%avarage of local maxima

av=(v(33)+v(38))/2 %  -1.8841

%datapoints
v1(34)=v(34)-2*(v(34)-av)
v1(35)=v(35)-2*(v(35)-av)
v1(36)=v(36)-2*(v(36)-av)
v1(37)=v(37)-2*(v(37)-av)
%%
figure
hold all
plot(f1,v1, 'go-')
plot(f,v, 'o')
refline(0,av)
%%
fshort=f1(20:56);
vshort=v1(20:56);

figure
hold all
plot(fshort,vshort, 'go-')
%plot(s,v, 'o')
refline(0,av)

phase=PYTHONalu3short(:,3);
phaseshort=phase(20:56);

%%
%PY_alu3_invert=table(fshort,...
%        vshort, phaseshort);
%    writetable(PY_alu3_invert,...
 %    'PY_alu3_hample_invert.dat','Delimiter',...
 %    ' ','writevariableNames',false); 
 
 
 %%smoothing
 
 smtlb = sgolayfilt(vshort,3,5);
 
 figure
 hold all
 plot(fshort,vshort, 'go-')
 plot(fshort,smtlb, 'bo-')
 
 PY_alu3_invert_smooth=table(fshort,...
        smtlb, phaseshort);
    writetable(PY_alu3_invert_smooth,...
     'PY_alu3_hample_invert_smooth.dat','Delimiter',...
     ' ','writevariableNames',false); 