

for i=1:3600
    I(i,1)=-27;
    SOC(i,1)=1/3600*i;
end
for i=3601:7200
    I(i,1)=27;
    SOC(i,1)=1-1/3600*(i-3600);
end
for c=2:720
    for t=1:7200
        I(t+7200*(c-1))=I(t,1);
        SOC(t+7200*(c-1))=SOC(t,1);
    end
end
for t=1:5184000
    iSEI(t)=fSEI(t,I(t,1),SOC(t,1),298);
end
for t=1:5184000
    iSEI45(t)=fSEI(t,I(t,1),SOC(t,1),318);
end
QSEI=cumsum(iSEI);
QSEI45=cumsum(iSEI45);
figure
plot(1-QSEI)
hold on
plot(1-QSEI45)
load('capacityfade.mat')
cycle=0:7200*30:5184000;
hold on
plot(cycle',Capacity)
load('Capacityfade45.mat')
hold on
plot(cycle',Capacity45)

% for t=1:1000
% iSEI1(t)=fSEI(t,0,0.2,298);
% iSEI2(t)=fSEI(t,0,0.5,298);
% iSEI3(t)=fSEI(t,0,0.8,298);
% end
% QSEI1=cumsum(iSEI1);
% QSEI2=cumsum(iSEI2);
% QSEI3=cumsum(iSEI3);