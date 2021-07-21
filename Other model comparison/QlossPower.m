function z=QlossPower(x,y)
global ESS;
Qloss=zeros(y,1);
a0=2.17e-10;
%Qloss(1,1)=a0*(abs(x(1,1))/ESS.series/ESS.paranum)*1;
Qloss(1,1)=a0*(abs(x(1,1)))*1;
for i=2:y
%Qloss(i,1)=Qloss(i-1,1)+a0*(abs(x(1,i))/ESS.series/ESS.paranum)*1;
Qloss(i,1)=Qloss(i-1,1)+a0*(abs(x(1,i)))*1;
end

% a0=1.81e-11;
% Qloss(1,1)=a0*(5+2*abs(x(1,1))/ESS.series/ESS.paranum+(abs(x(1,1))/ESS.series/ESS.paranum)^2)*(2880/y);
% for i=2:y
% Qloss(i,1)=Qloss(i-1,1)+a0*(5+2*abs(x(1,i))/ESS.series/ESS.paranum+(abs(x(1,i))/ESS.series/ESS.paranum)^2)*(2880/y);
% end
z=1-Qloss;
%z=Qloss*ESS.losscost;
end