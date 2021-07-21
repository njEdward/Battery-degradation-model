function deltaphi= fsp(I,SOC,T,i0_Li,R_SEI0,epsilong_s_n,deltan)
i0=i0_Li;
F=96487;
R=8.314;
epsilong_s_n=epsilong_s_n';
% deltan=1.325*12.5e-6;
R_s_n=9*10^-6;

EaRSEI=-35000;
a_s=3*epsilong_s_n/R_s_n;
A=1;
z=SOC*0.785+(1-SOC)*0.042;
Un=fU(z);
k=R_s_n*I./(6*epsilong_s_n*i0*A*deltan);
R_SEI=R_SEI0*exp(EaRSEI/R*(1/298-1/T));
deltaphi=2*R*T./F.*log(k+sqrt(k.^2+1))+Un+R_SEI./a_s.*I./A./deltan;
end
