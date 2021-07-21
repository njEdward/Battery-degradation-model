function z=QlossPLET(x,y)
global ESS;
Qloss=zeros(y,1);
kp=1.15;
C=4800;
%Qloss(1,1)=(2880/y)*(abs((x(1,1)-ESS.SOC0))/(2880/y))^kp/C;
Qloss(1,1)=(abs((x(1,1)-0.5)))^kp/C;
for i=2:y
%Qloss(i,1)=Qloss(i-1,1)+(2880/y)*(abs((x(1,i)-x(1,i-1)))/(2880/y))^kp/C;
Qloss(i,1)=Qloss(i-1,1)+(abs((x(1,i)-x(1,i-1))))^kp/C;
end
z=Qloss*ESS.losscost;
%z=1-Qloss;
end