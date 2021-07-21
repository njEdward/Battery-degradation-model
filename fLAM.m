
function [Qlam]=fLAM(SOCmin,SOCmax,beta3,m,sigma_yield,delta_SEI)



% Qlam  = amplfunc (SOCmin,SOCmax,m,beta3,sigma_yield);
%  
% 
% 
% function [ LAM_step ] = amplfunc (SOCmin,SOCmax,m,beta3,sigma_yield)

[sigma_rp1, sigma_tp1, sigma_rs1, sigma_ts1]=sigma(SOCmin,delta_SEI);

[sigma_rp2, sigma_tp2, sigma_rs2, sigma_ts2]=sigma(SOCmax,delta_SEI);

sigma_hp1=(sigma_rp1+2*sigma_tp1)/3;
sigma_hp2=(sigma_rp2+2*sigma_tp2)/3;

% sigma_hp1=(sigma_rp1)/3;
% sigma_hp2=(sigma_rp2)/3;

Qlam=beta3.*(abs(sigma_hp1-sigma_hp2)./sigma_yield).^(1/m);
% end



function [sigma_rp, sigma_tp, sigma_rs, sigma_ts]=sigma(SOC,delta_SEI)
cp=31.92e3;
Ep=15e9;Rp=9e-6;vp=0.3;Omega_p=3.1e-6;
Es=0.5e9;Rs0=Rp+delta_SEI(1);vs=0.2;


xmax=0.82;xmin=0.038;
x_LIC=SOC*(xmax-xmin)+xmin;

load GraphiteExpansion.mat x1 y1;
% Cal_Omega_p = arrayfun(@(x) interp1(x1,y1,x),x_LIC);
Cal_Omega_p=interp1(x1,y1,x_LIC);

% Cal_Omega_p=(x_LIC-x1(1))./(x1(end)-x1(1)).*(y1(end)-y1(1))+y1(1);


A=[1 -1 -1/Rp^3;    
    1/(1-2*vs) 0 -2/Rs0^3/(1+vs);    
    -Ep/(1-2*vp) Es/(1-2*vs) -2*Es/Rp^3/(1+vs)];
b=[-(1+vp)/(1-vp)/3/Rp^3*Cal_Omega_p*Rp^3/3;
    zeros(1,length(Cal_Omega_p));
    2*Ep/3/(1-vp)/Rp^3*Cal_Omega_p*Rp^3/3];

x=A\b;

% A2=pinv(A);
% x1=A2*b;

ap=x(1,:);as=x(2,:);bs=x(3,:);
bp=((-2/3*Ep/(1-vp)*(1/3)*Cal_Omega_p+Ep/(1-2*vp)*ap)-(Es/(1-2*vs)*as-2./Rp.^3.*Es./(1+vs).*bs))/(2./Rp.^3*Ep/(1+vp));
% 
% r=linspace(0,Rp,100);

r=Rp;

sigma_rp=-2/3*Ep/(1-vp)*(1/3)*Cal_Omega_p+Ep/(1-2*vp)*ap-2./r.^3*Ep/(1+vp)*bp;
sigma_tp=Ep/3/(1-vp)*(1/3)*Cal_Omega_p+Ep/(1-2*vp)*ap+1./r.^3*Ep/(1+vp)*bp-Omega_p/3*Ep*cp/(1-vp);
% 
% figure
% plot(r(20:100),sigma_rp(20:100));
% hold on
% plot(r(20:100),sigma_tp(20:100))


% r=linspace(Rp,Rs,100);
sigma_rs=Es/(1-2*vs)*as-2./r.^3.*Es./(1+vs).*bs;
sigma_ts=Es/(1-2*vs)*as+1./r.^3.*Es./(1+vs).*bs;

% 
% figure
% plot(r,sigma_rs);
% hold on
% plot(r,sigma_ts)

end

% function [Cal_Omega_p] = Calculus_Ome_p(x_LIC)
% 
% 
% 
% 
% end

end
