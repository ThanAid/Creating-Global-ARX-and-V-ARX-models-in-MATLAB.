function [rss,kestim]=kestimationPooledARX
%rss is a matrix containing the rss for all the measurements given,rss{1,1}
%represents the first measurement for the first level of water, rss{2,4}
%represents the 4th measurement for the second level of water etc.
%kestim is a matrix containing the estimations of the level of the water,
%each column represents the number of the measurement and each row the real
%level of the water
clear all
clc
load('alldata') %file containing X_dall and Y_dall. X_dall is a cell containing
% all the measurements. X_dall{1,1} is the first measurement of the first
% level referring to the input, X_dall{3,4} is the 4th measurement of the 3rd 
% level etc. Y_dall refers to the outputs.
 
load MetriseisStathmi1ews11CELLS %file containing x{} and y{} cells where x{1} 
%is the excitation signal of the first experiment and y{1} is the output
%signals of the first experiment and so goes on.
na=75; %order of the AR.
nb=na;  % order of the X.
fs=256; %sampling Frequency.
sensor=3; % choise of the sensor to be used for the arx models.
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
    
    for j=1:11
        for i=1:5
            kk=1;
            x_=detrend(X_dall{j,i});
            x_=x_./std(x_);
            y_=detrend(Y_dall{j,i}(:,sensor));
            y_=y_./std(y_);
            currentdata=iddata(y_,x_,1/fs);   
    for k=0:0.2:40
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
        %%%%%%%%%%%%%%%% RSS ESTIMATION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
 
        sys0=idpoly(Ak,Bk);
        yp=predict(sys0,currentdata);
        res=currentdata.outputdata-yp.outputdata;
        rss{j,i}(kk)=sum(res.^2);
        [miny,minx]=min(rss{j,i});
        kestim(j,i)=(minx-1)*0.2;
 
 
 
        clear Ak Bk yp res miny minx 
    kk=kk+1;
    end  
    clear kk k
        end
        clear i
    end
    clear j
end   
