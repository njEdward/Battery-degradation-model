function z=QlossNREL(x,y)
global ESS;
Qloss=zeros(y,1);
k0=8.56e-8;
k1=3.58;
k2=3.37;
Qloss(1,1)=k0*(1-k1*x(1,1)+k2*x(1,1)^2);
for i=2:y
    Qloss(i,1)=Qloss(i-1,1)+k0*(1-k1*x(1,i)+k2*x(1,i)^2);
end
% sumk10=0;
% sumk20=0;
% for i=1:2880/y
%     sumk10=sumk10+ESS.SOC0+(x(1,1)-ESS.SOC0)*i/(2880/y);
%     sumk20=sumk20+(ESS.SOC0+(x(1,1)-ESS.SOC0)*i/(2880/y))^2;
% end
% Qloss(1,1)=k0*((2880/y)-k1*sumk10+k2*sumk20);
% for i=2:y
%  sumk1i=0;
%  sumk2i=0;
%  for j=1:2880/y
%      sumk1i=sumk1i+x(1,i-1)+(x(1,i)-x(1,i-1))*j/(2880/y);
%      sumk2i=sumk2i+(x(1,i-1)+(x(1,i)-x(1,i-1))*j/(2880/y))^2;
%  end
%  Qloss(i,1)=Qloss(i-1,1)+k0*((2880/y)-k1*sumk1i+k2*sumk2i);
% end
z=Qloss*ESS.losscost;
%z=1-Qloss;
end