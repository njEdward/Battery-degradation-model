function m=QlossArrhenius(x,y)
global ESS;
Qloss=zeros(y,1);
R=8.314;
T=298.15-4;
A=0.01;
B=-25000;
z=0.85;
Qloss0=A*exp(B/R/T);
%Qloss(1,1)=z*Qloss0^((z-1)/z)*A^(1/z)*exp(B/z/R/T)*abs(x(1,1))/(y/48)/ESS.paranum;
Qloss(1,1)=Qloss0;
for i=2:y
    Qloss(i,1)=Qloss(i-1,1)+z*Qloss(i-1,1)^((z-1)/z)*A^(1/z)*exp(B/z/R/T)*abs(x(1,i))/60;
    %Qloss(i,1)=Qloss(i-1,1)+z*Qloss(i-1,1)^((z-1)/z)*A^(1/z)*exp(B/z/R/T)*abs(x(1,i))/(y/48)/ESS.paranum;
end
m=1-Qloss;
%m=Qloss*ESS.losscost;
end