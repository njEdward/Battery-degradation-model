clear;clc;
Q0=1;
T=273+21;
%% 实验Acc4
load Acccondition.mat;
load AccSOC.mat;
load RealSOCmat.mat RealSOC1;
load RealSOCmat.mat RealSOC5;

t=1:2000*144*60;
I=zeros(1,length(t));
SOC=zeros(1,length(t));
t=1:500*144*60;
Q5=20.01;
Q0n=Q5;
clear SOC I
for i=1:400
    for j=1:144
        for m=1:60
            I(((144*(i-1)+j)-1)*60+m)=Accondition.Acc5(j)*Q5*0.95;
            if j==1
                SOC(((144*(i-1)+j)-1)*60+m)=AccSOC.Acc5(j);
            else
                SOC(((144*(i-1)+j)-1)*60+m)=AccSOC.Acc5(j-1)+m/60*(AccSOC.Acc5(j)-AccSOC.Acc5(j-1));
            end
        end
    end
end

for i=1:400
    for j=1:144
        
        for m=1:60
            I(((144*(i-1)+j)-1)*60+m)=Accondition.Acc5(j)*Q5;
                   
        end
    end
end
    
    for i=1:57600
        for j=1:60
            if i==57600
                SOC(j+60*(i-1))=RealSOC5(i);
            else
              SOC(j+60*(i-1))=RealSOC5(i)+j/60*(RealSOC5(i+1)-RealSOC5(i));
            end
        end
    end
    
    
Q4=20.11;
Q0n=Q4;
for i=1:500
    for j=1:144
        for m=1:60
            I(((144*(i-1)+j)-1)*60+m)=Accondition.Acc4(j)*Q4;
            if j==1
                SOC(((144*(i-1)+j)-1)*60+m)=AccSOC.Acc4(j);
            else
                SOC(((144*(i-1)+j)-1)*60+m)=AccSOC.Acc4(j-1)+m/60*(AccSOC.Acc4(j)-AccSOC.Acc4(j-1));
            end
        end
    end
end

Q3=20;
Q0n=Q3;
for i=1:500
    for j=1:144
        for m=1:60
            I(((144*(i-1)+j)-1)*60+m)=Accondition.Acc3(j)*Q3;
            if j==1
                SOC(((144*(i-1)+j)-1)*60+m)=AccSOC.Acc3(j);
            else
                SOC(((144*(i-1)+j)-1)*60+m)=AccSOC.Acc3(j-1)+m/60*(AccSOC.Acc3(j)-AccSOC.Acc3(j-1));
            end
        end
    end
end

Q2=19.9;
Q0n=Q2;
for i=1:500
    for j=1:144
        for m=1:60
            I(((144*(i-1)+j)-1)*60+m)=Accondition.Acc2(j)*Q2;
            if j==1
                SOC(((144*(i-1)+j)-1)*60+m)=AccSOC.Acc2(j);
            else
                SOC(((144*(i-1)+j)-1)*60+m)=AccSOC.Acc2(j-1)+m/60*(AccSOC.Acc2(j)-AccSOC.Acc2(j-1));
            end
        end
    end
end

Q1=19.89;
Q0n=Q1;
for i=1:500
    for j=1:144
        for m=1:60
            I(((144*(i-1)+j)-1)*60+m)=Accondition.Acc1(j)*Q1;
            if j==1
                SOC(((144*(i-1)+j)-1)*60+m)=AccSOC.Acc1(j);
            else
                SOC(((144*(i-1)+j)-1)*60+m)=AccSOC.Acc1(j-1)+m/60*(AccSOC.Acc1(j)-AccSOC.Acc1(j-1));
            end
        end
    end
end


    for i=1:72000
        for j=1:60
            if i==72000
                SOC(j+60*(i-1))=RealSOC1(i);
            else
              SOC(j+60*(i-1))=RealSOC1(i)+j/60*(RealSOC1(i+1)-RealSOC1(i));
            end
        end
    end
    
        for i=1:72000
        for j=1:60
            if i==72000
                SOC(j+60*(i-1))=RealSOC2(i);
            else
              SOC(j+60*(i-1))=RealSOC2(i)+j/60*(RealSOC2(i+1)-RealSOC2(i));
            end
        end
        end
    
   for i=1:72000
        for j=1:60
            if i==72000
                SOC(j+60*(i-1))=RealSOC3(i);
            else
              SOC(j+60*(i-1))=RealSOC3(i)+j/60*(RealSOC3(i+1)-RealSOC3(i));
            end
        end
   end
    
      for i=1:72000
        for j=1:60
            if i==72000
                SOC(j+60*(i-1))=RealSOC4(i);
            else
              SOC(j+60*(i-1))=RealSOC4(i)+j/60*(RealSOC4(i+1)-RealSOC4(i));
            end
        end
      end
      
      for i=4320001:8640000
          SOC(i)=(SOC(i-4320000)-0.5)*(0.934-0.5)/(0.9-0.5)+0.5;
      end
          
                
      for i=4320001:8640000
          I(i)=I(i-4320000);
      end

      for i=8640001:8640000*2
          SOC(i)=(SOC(i-4320000*2)-0.5)*(0.9708-0.5)/(0.9-0.5)+0.5;
      end
          
                
      for i=4320001*2:8640000*2
          I(i)=I(i-4320000*2);
      end
      


%% SEI growth\
load db_pra1108new.mat;

clear Qlam QLi QSEI Qloss1 Qrest
Z=db_pra;
beta1=Z(1);
kSEI=Z(2);
m3=Z(3);
beta3=Z(4);
lamda=Z(5);
Q0=1;

tic
deltan=0.835*20e-6;


alpha_e=1;
e0=0.59;
%%LAM crack
% m3=0.32;
% beta3=0.01;
delta_SEI=20e-9;
sigma_yield=8e8; % 影响较大
SOCmin=SOC(1:end-1);SOCmax=SOC(2:end);
ilam=fLAM(SOCmin,SOCmax,beta3,m3,sigma_yield,delta_SEI);
ilam=[0 ilam];
Qlam=cumsum(ilam');
epsilong_s_n=e0*(1-Qlam*alpha_e)./(1-e0*Qlam*alpha_e);

% figure
% plot(t/144/60,1-Qlam,'LineWidth',2)
% hold on

% kSEI=1.05;
ESEI=27219;
% ESEI=61505;
SEI0=20e-9;
F=96487;
MSEI=0.162;rouSEI=1690;sigma_SEI=5e-6;

% lamda=2.5;
iSEI=fSEI(t,I,SOC,T,kSEI,ESEI,lamda,0.59,deltan);
QSEI=cumsum(iSEI');
d_delta_SEI=iSEI*MSEI/2/F/rouSEI;
delta_SEI=cumsum(d_delta_SEI)+SEI0;
RSEI=delta_SEI/sigma_SEI;

% plot(t/144/60,1-QSEI,'LineWidth',2)
% hold on 


%%Li plating
load delta_phi.mat delta_phi;
load j_n.mat j_n;
i0_Li=2;
Rp=9e-6;
% R_SEI0=0.0015;

phi_onset=0.0055;
A=1;

deltaU =fsp(I*27/Q0n, SOC,T, i0_Li,RSEI,epsilong_s_n,deltan);

% 
% deltaU=zeros(109,101);
% jLi=zeros(109,101);
% for i=1:109
%     for j=1:101
%         deltaU(i,j)=fsp(-1*(i-1)-27,0.01*(j-1),294, i0_Li,R_SEI0);
%         jLi(i,j)=-interp1(delta_phi,j_n,(deltaU(i,j)+0.005));
% 
% 
%     end
% end
% figure
% surf(jLi)
% xlabel('SOC','fontsize',14);ylabel('C-rate','fontsize',14);zlabel('-i_L_i / Am^-^2','fontsize',14);
%  plot(delta_phi,j_n)
% % deltaU(i,j)=fsp(-1*(i-1)-27,0.01*(j-1),318);
% 
% % beta1=0.015;

jLi=-interp1(delta_phi,j_n,(deltaU+phi_onset));

% a=find(deltaU+phi_onset)
% jLi=-(deltaU+phi_onset-delta_phi(1))./(delta_phi(end)-delta_phi(1)).*(j_n(end)-j_n(1))+j_n(1);


QLi=cumsum(beta1*jLi'*A.*epsilong_s_n*deltan);
% plot(t/144/60,1-QLi,'LineWidth',2)
% hold on 
% legend('LAM','SEI growth','Li-plating')

% Qloss output
Qloss1=QLi+QSEI+Qlam;
Qrest=Q0-Qloss1;
toc

load agingdata500 cycle ACC1 ACC2 ACC3 ACC4 ACC5
% figure
% scatter(cycle,ACC4,100,'s','LineWidth',2)
% hold on
% plot(t/144/60,Qrest,'LineWidth',2)
% legend('Exp','Sim')
