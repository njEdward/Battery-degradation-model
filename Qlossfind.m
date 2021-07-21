function [Qrest,Qrestall]=Qlossfind(SOC,I,t,T,Z,Q0n)

kLi=Z(1);
kSEI=Z(2);
m=Z(3);
kLAM=Z(4);
lamda=Z(5);
sigma_yield=Z(6);
phi_onset=Z(7);
Q0=1;


%% SEI growth

deltan=0.835*20e-6;
alpha_e=0.95;
e0=0.59;




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


%%  LAM crack
% m3=0.32;
% beta3=0.01;
%delta_SEI=20e-9;
%sigma_yield=8e8; % Ó°Ïì½Ï´ó
SOCmin=SOC(1:end-1);SOCmax=SOC(2:end);
ilam=fLAM(SOCmin,SOCmax,kLAM,m,sigma_yield,delta_SEI);
ilam=[0 ilam];
Qlam=cumsum(ilam');
epsilong_s_n=e0*(1-Qlam*alpha_e)./(1-e0*Qlam*alpha_e);


%% Li plating

%%Li plating
load delta_phi.mat delta_phi;
load j_n.mat j_n;
i0_Li=2;
%Rp=9e-6;
% R_SEI0=0.0015;


A=1;

deltaU =fsp(I*27/Q0n, SOC,T, i0_Li,RSEI,epsilong_s_n,deltan);
jLi=-interp1(delta_phi,j_n,(deltaU+phi_onset));
QLi=cumsum(kLi*jLi'*A.*epsilong_s_n*deltan);

%% Qloss output

Qloss1=QLi+QSEI+Qlam;
Qrest1=Q0-Qloss1;
Qrestall=Qrest1;


zp=1:length(Qrest1)/144/60/50;
Qrest=zeros(length(zp),1);
Qrest(zp,1)=Qrest1(144*60*50*zp,1);


end