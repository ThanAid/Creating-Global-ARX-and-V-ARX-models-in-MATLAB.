function [models,H_all]=PooledVARX_all_h
clc
%models: the estimated VARX models for the known heights of water
%H_all: FRF matrixes, H_all{1} containing the frf matrix for sensor 1 and
%all the heights of the water (0.4 cm step).
fs=256;%sampling Frequency.
load MetriseisStathmi1ews11CELLS%file containing x{} and y{} cells where x{1} 
%is the excitation signal of the first experiment and y{1} is the output
%signals of the first experiment and so goes on.
na=18;%order of the AR.
nb=18; % order of the X.
h=[0 4 8 12 16 20 24 28 32 36 40];%the height of the water corresponding to 
%each experiment.
M=11; %experiments
s=4;    %number of outputs
ny=s;
helper=1;
for hh=0:0.4:40
    
 for j=1:M
 X{j}=detrend(x{j});
 X{j}=X{j}./std(X{j});
      for k=1:s
      Y{j}(:,k)=detrend(y{j}(:,k));
      Y{j}(:,k)=Y{j}(:,k)./std(Y{j}(:,k));
      end
    clear k
end
clear j
for i=1:M
data{i}=iddata(Y{i},X{i},1/fs);
models{i}=arx(data{i},[na*ones(4) (nb)*ones(4,1) zeros(4,1)]);
A{i}=models{i}.A;
B{i}=models{i}.B;
end
clear i
 
for n=1:na+1
AA1_1{n}=[A{1}{1,1}(n) A{2}{1,1}(n) A{3}{1,1}(n) A{4}{1,1}(n) A{5}{1,1}(n) A{6}{1,1}(n) A{7}{1,1}(n) A{8}{1,1}(n) A{9}{1,1}(n) A{10}{1,1}(n) A{11}{1,1}(n)];
AA1_2{n}=[A{1}{1,2}(n) A{2}{1,2}(n) A{3}{1,2}(n) A{4}{1,2}(n) A{5}{1,2}(n) A{6}{1,2}(n) A{7}{1,2}(n) A{8}{1,2}(n) A{9}{1,2}(n) A{10}{1,2}(n) A{11}{1,2}(n)];
AA1_3{n}=[A{1}{1,3}(n) A{2}{1,3}(n) A{3}{1,3}(n) A{4}{1,3}(n) A{5}{1,3}(n) A{6}{1,3}(n) A{7}{1,3}(n) A{8}{1,3}(n) A{9}{1,3}(n) A{10}{1,3}(n) A{11}{1,3}(n)];
AA1_4{n}=[A{1}{1,4}(n) A{2}{1,4}(n) A{3}{1,4}(n) A{4}{1,4}(n) A{5}{1,4}(n) A{6}{1,4}(n) A{7}{1,4}(n) A{8}{1,4}(n) A{9}{1,4}(n) A{10}{1,4}(n) A{11}{1,4}(n)];
% % % % % % % % % % % % % % % % 
AA2_1{n}=[A{1}{2,1}(n) A{2}{2,1}(n) A{3}{2,1}(n) A{4}{2,1}(n) A{5}{2,1}(n) A{6}{2,1}(n) A{7}{2,1}(n) A{8}{2,1}(n) A{9}{2,1}(n) A{10}{2,1}(n) A{11}{2,1}(n)];
AA2_2{n}=[A{1}{2,2}(n) A{2}{2,2}(n) A{3}{2,2}(n) A{4}{2,2}(n) A{5}{2,2}(n) A{6}{2,2}(n) A{7}{2,2}(n) A{8}{2,2}(n) A{9}{2,2}(n) A{10}{2,2}(n) A{11}{2,2}(n)];
AA2_3{n}=[A{1}{2,3}(n) A{2}{2,3}(n) A{3}{2,3}(n) A{4}{2,3}(n) A{5}{2,3}(n) A{6}{2,3}(n) A{7}{2,3}(n) A{8}{2,3}(n) A{9}{2,3}(n) A{10}{2,3}(n) A{11}{2,3}(n)];
AA2_4{n}=[A{1}{2,4}(n) A{2}{2,4}(n) A{3}{2,4}(n) A{4}{2,4}(n) A{5}{2,4}(n) A{6}{2,4}(n) A{7}{2,4}(n) A{8}{2,4}(n) A{9}{2,4}(n) A{10}{2,4}(n) A{11}{2,4}(n)];
% % % % % % % % % % % % % % % % 
AA3_1{n}=[A{1}{3,1}(n) A{2}{3,1}(n) A{3}{3,1}(n) A{4}{3,1}(n) A{5}{3,1}(n) A{6}{3,1}(n) A{7}{3,1}(n) A{8}{3,1}(n) A{9}{3,1}(n) A{10}{3,1}(n) A{11}{3,1}(n)];
AA3_2{n}=[A{1}{3,2}(n) A{2}{3,2}(n) A{3}{3,2}(n) A{4}{3,2}(n) A{5}{3,2}(n) A{6}{3,2}(n) A{7}{3,2}(n) A{8}{3,2}(n) A{9}{3,2}(n) A{10}{3,2}(n) A{11}{3,2}(n)];
AA3_3{n}=[A{1}{3,3}(n) A{2}{3,3}(n) A{3}{3,3}(n) A{4}{3,3}(n) A{5}{3,3}(n) A{6}{3,3}(n) A{7}{3,3}(n) A{8}{3,3}(n) A{9}{3,3}(n) A{10}{3,3}(n) A{11}{3,3}(n)];
AA3_4{n}=[A{1}{3,4}(n) A{2}{3,4}(n) A{3}{3,4}(n) A{4}{3,4}(n) A{5}{3,4}(n) A{6}{3,4}(n) A{7}{3,4}(n) A{8}{3,4}(n) A{9}{3,4}(n) A{10}{3,4}(n) A{11}{3,4}(n)];
% % % % % % % % % % % % % % 
AA4_1{n}=[A{1}{4,1}(n) A{2}{4,1}(n) A{3}{4,1}(n) A{4}{4,1}(n) A{5}{4,1}(n) A{6}{4,1}(n) A{7}{4,1}(n) A{8}{4,1}(n) A{9}{4,1}(n) A{10}{4,1}(n) A{11}{4,1}(n)];
AA4_2{n}=[A{1}{4,2}(n) A{2}{4,2}(n) A{3}{4,2}(n) A{4}{4,2}(n) A{5}{4,2}(n) A{6}{4,2}(n) A{7}{4,2}(n) A{8}{4,2}(n) A{9}{4,2}(n) A{10}{4,2}(n) A{11}{4,2}(n)];
AA4_3{n}=[A{1}{4,3}(n) A{2}{4,3}(n) A{3}{4,3}(n) A{4}{4,3}(n) A{5}{4,3}(n) A{6}{4,3}(n) A{7}{4,3}(n) A{8}{4,3}(n) A{9}{4,3}(n) A{10}{4,3}(n) A{11}{4,3}(n)];
AA4_4{n}=[A{1}{4,4}(n) A{2}{4,4}(n) A{3}{4,4}(n) A{4}{4,4}(n) A{5}{4,4}(n) A{6}{4,4}(n) A{7}{4,4}(n) A{8}{4,4}(n) A{9}{4,4}(n) A{10}{4,4}(n) A{11}{4,4}(n)];
%%%%%%%%%%%%%%%%%%%%% spline %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ppA1_1{n}= spline(h,AA1_1{n});
ppA1_2{n}= spline(h,AA1_2{n});
ppA1_3{n}= spline(h,AA1_3{n});
ppA1_4{n}= spline(h,AA1_4{n});
% % % % % % % % % % % % % % % 
ppA2_1{n}= spline(h,AA2_1{n});
ppA2_2{n}= spline(h,AA2_2{n});
ppA2_3{n}= spline(h,AA2_3{n});
ppA2_4{n}= spline(h,AA2_4{n});
% % % % % % % % % % % % % % % 
ppA3_1{n}= spline(h,AA3_1{n});
ppA3_2{n}= spline(h,AA3_2{n});
ppA3_3{n}= spline(h,AA3_3{n});
ppA3_4{n}= spline(h,AA3_4{n});
% % % % % % % % % % % % % % % % % 
ppA4_1{n}= spline(h,AA4_1{n});
ppA4_2{n}= spline(h,AA4_2{n});
ppA4_3{n}= spline(h,AA4_3{n});
ppA4_4{n}= spline(h,AA4_4{n});
% % % % % % % % % % % % % % % % % % 
%%%%%%%%%%%%%%%%%%ppval%%%%%%%%%%%%%%%%%%%%%%%
Ak1_1(n)=ppval(ppA1_1{n},hh);
Ak1_2(n)=ppval(ppA1_2{n},hh);
Ak1_3(n)=ppval(ppA1_3{n},hh);
Ak1_4(n)=ppval(ppA1_4{n},hh);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ak2_1(n)=ppval(ppA2_1{n},hh);
Ak2_2(n)=ppval(ppA2_2{n},hh);
Ak2_3(n)=ppval(ppA2_3{n},hh);
Ak2_4(n)=ppval(ppA2_4{n},hh);
%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ak3_1(n)=ppval(ppA3_1{n},hh);
Ak3_2(n)=ppval(ppA3_2{n},hh);
Ak3_3(n)=ppval(ppA3_3{n},hh);
Ak3_4(n)=ppval(ppA3_4{n},hh);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ak4_1(n)=ppval(ppA4_1{n},hh);
Ak4_2(n)=ppval(ppA4_2{n},hh);
Ak4_3(n)=ppval(ppA4_3{n},hh);
Ak4_4(n)=ppval(ppA4_4{n},hh);
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
end
clear n
 
for n=1:nb
BB1_1{n}=[B{1}{1,1}(n) B{2}{1,1}(n) B{3}{1,1}(n) B{4}{1,1}(n) B{5}{1,1}(n) B{6}{1,1}(n) B{7}{1,1}(n) B{8}{1,1}(n) B{9}{1,1}(n) B{10}{1,1}(n) B{11}{1,1}(n)]; 
BB2_1{n}=[B{1}{2,1}(n) B{2}{2,1}(n) B{3}{2,1}(n) B{4}{2,1}(n) B{5}{2,1}(n) B{6}{2,1}(n) B{7}{2,1}(n) B{8}{2,1}(n) B{9}{2,1}(n) B{10}{2,1}(n) B{11}{2,1}(n)];
BB3_1{n}=[B{1}{3,1}(n) B{2}{3,1}(n) B{3}{3,1}(n) B{4}{3,1}(n) B{5}{3,1}(n) B{6}{3,1}(n) B{7}{3,1}(n) B{8}{3,1}(n) B{9}{3,1}(n) B{10}{3,1}(n) B{11}{3,1}(n)];
BB4_1{n}=[B{1}{4,1}(n) B{2}{4,1}(n) B{3}{4,1}(n) B{4}{4,1}(n) B{5}{4,1}(n) B{6}{4,1}(n) B{7}{4,1}(n) B{8}{4,1}(n) B{9}{4,1}(n) B{10}{4,1}(n) B{11}{4,1}(n)];
% % % % % % % % % % % % %spline %%%%%%%%%%%%%%%%%%%%%%%
ppB1_1{n}= spline(h,BB1_1{n});
ppB2_1{n}= spline(h,BB2_1{n});
ppB3_1{n}= spline(h,BB3_1{n});
ppB4_1{n}= spline(h,BB4_1{n});
%%%%%%%%%%%%%%%%%%%%%% ppval %%%%%%%%%%%%%%%%%%%%%%%%%%
Bk1_1(n)=ppval(ppB1_1{n},hh);
Bk2_1(n)=ppval(ppB2_1{n},hh);
Bk3_1(n)=ppval(ppB3_1{n},hh);
Bk4_1(n)=ppval(ppB4_1{n},hh);
end
clear n
 
%%%%%%%%%%%%%%%%%%%%Ak and Bk in final form %%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ak{1,1}=Ak1_1;
Ak{1,2}=Ak1_2;
Ak{1,3}=Ak1_3;
Ak{1,4}=Ak1_4;
%%%%%%%%%%%%%
Ak{2,1}=Ak2_1;
Ak{2,2}=Ak2_2;
Ak{2,3}=Ak2_3;
Ak{2,4}=Ak2_4;
%%%%%%%%%%%%%
Ak{3,1}=Ak3_1;
Ak{3,2}=Ak3_2;
Ak{3,3}=Ak3_3;
Ak{3,4}=Ak3_4;
%%%%%%%%%%%%%
Ak{4,1}=Ak4_1;
Ak{4,2}=Ak4_2;
Ak{4,3}=Ak4_3;
Ak{4,4}=Ak4_4;
%%%%%%%%%%%%%
%%%%%%%%%%%%%
Bk{1,1}=Bk1_1;
Bk{2,1}=Bk2_1;
Bk{3,1}=Bk3_1;
Bk{4,1}=Bk4_1;
%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% FRF ESTIMATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear k
for k=1:na
    for p=1:ny
        for q=1:ny
            a=cell2mat(Ak(p,q));
            A{k,p,q}= a(k+1);
        end
        b=cell2mat(Bk(p,1));
        B{k,p,1}= b(k);
    end
end
clear k p q 
 
k=1;
for f=[0:0.1:fs/2]
    F=eye(ny);% Identity matrix
    Q=zeros(ny,1);
    for p=1:na
        Ai(1:ny,1:ny)=cell2mat(A(p,1:ny,1:ny));
        F=F+((exp((-1i)*f*p*((2*pi)/fs))).*(Ai));
        Bi(1:ny,1)=cell2mat(B(p,1:ny,1));
        Q=Q+((exp((-1i)*f*p*((2*pi)/fs))).*(Bi));
    end
    F=inv(F);% Inverse of F matrix
    H(k,:,:)=(F*Q);% FRF matrix (ny x nx)
    k=k+1;
end
H_all1(helper,:)=H(:,1);
H_all2(helper,:)=H(:,2);
H_all3(helper,:)=H(:,3);
H_all4(helper,:)=H(:,4);
 
clear H
helper = helper+1;
end
H_all={H_all1 H_all2 H_all3 H_all4};
ii=14;
for sensor=1:s
    figure
        sens=num2str(sensor);
        taksi=num2str(na);
        surf([0:0.1:fs/2],[0:0.4:40],20*log10(abs(H_all{sensor})))
        colorbar
        colormap(jet)
        title(['Parametric FRF for GLOBAL-VARX(',taksi,',',taksi,') for sensor ',sens],...
                'Fontname','TimesNewRoman','fontsize',ii)
       zlabel('Magnitude (dB)','Fontname','TimesNewRoman','Fontsize',ii)
       xlabel('Frequency (Hz)','Fontname','TimesNewRoman','Fontsize',ii)
       ylabel('Water Height (cm)','Fontname','TimesNewRoman','Fontsize',ii) 
       set(gcf,'color','w');
       xlim([5 100])
end
 
end
