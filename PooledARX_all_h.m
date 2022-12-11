function [MAG,models,Ak,Bk]=PooledARX_all_h
%MAG is the FRF Matrix.
%models are the estimated ARX models for each experiment.
%Ak is the parameters of the AR part (dimensions (dimension of height
%matrix)*na.
%Bk is the counter part for the X part.
clear all
clc
load MetriseisStathmi1ews11CELLS %file containing x{} and y{} cells where x{1} 
%is the excitation signal of the first experiment and y{1} is the output
%signals of the first experiment and so goes on.
na=75; %order of the AR.
nb=na;  % order of the X.
fs=256; %sampling Frequency.
sensor=4; % choise of the sensor to be used for the arx models.
M=11; % number of experiments.
h=[0 4 8 12 16 20 24 28 32 36 40]; %the height of the water corresponding to 
%each experiment.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
kk=1;
    
 
    for j=1:M
    X{j}=detrend(x{j});
    X{j}=X{j}./std(X{j});
    Y{j}=detrend(y{j}(:,sensor));
    Y{j}=Y{j}./std(Y{j});
    end
    clear j
    for i=1:M
    data{i}=iddata(Y{i},X{i},1/fs);
    models{i}=arx(data{i},[na nb+1 0]);
    A{i}=models{i}.A;
    B{i}=models{i}.B;
    end
    clear i
    
    
    for k=0:0.4:40
        for n=1:na+1
        AA{n}=[A{1}(n) A{2}(n) A{3}(n) A{4}(n) A{5}(n) A{6}(n) A{7}(n) A{8}(n) A{9}(n) A{10}(n) A{11}(n)];
        BB{n}=[B{1}(n) B{2}(n) B{3}(n) B{4}(n) B{5}(n) B{6}(n) B{7}(n) B{8}(n) B{9}(n) B{10}(n) B{11}(n)]; 
        ppA{n} = spline(h,AA{n});
        ppB{n} = spline(h,BB{n});
        Ak(n)=ppval(ppA{n},k);
        Bk(n)=ppval(ppB{n},k);
        end
        clear n
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%% FRF ESTIMATION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
 
        
        [MAG(kk,:),PHASE,wp] = dbode(Bk,Ak,1/fs,2*pi*[0:0.1:fs/2]);
        
 
        clear Ak Bk 
    kk=kk+1;
    end  
        ii=14;
        sens=num2str(sensor);
        taksi=num2str(na);
        surf([0:0.1:fs/2],[0:0.4:40],20*log10(abs(MAG)))
        colorbar
        colormap(jet)
        title(['Parametric FRF for GLOBAL-ARX(',taksi,',',taksi,') for sensor ',sens],...
                'Fontname','TimesNewRoman','fontsize',ii)
       zlabel('Magnitude (dB)','Fontname','TimesNewRoman','Fontsize',ii)
       xlabel('Frequency (Hz)','Fontname','TimesNewRoman','Fontsize',ii)
       ylabel('Water Height (cm)','Fontname','TimesNewRoman','Fontsize',ii) 
       set(gcf,'color','w');
       xlim([5 100])
end
