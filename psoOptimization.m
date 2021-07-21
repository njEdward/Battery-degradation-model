clear;
clc;

T=273+21;
%% 实验ACC4-ACC1
load Acccondition.mat;
load AccSOC.mat;
load RealSOCmat.mat RealSOC1 RealSOC2 RealSOC3 RealSOC4 RealSOC5;

t=1:500*144*60;
t5=1:400*144*60;

I1=zeros(1,length(t));
SOC1=zeros(1,length(t));
I2=zeros(1,length(t));
SOC2=zeros(1,length(t));
I3=zeros(1,length(t));
SOC3=zeros(1,length(t));
I4=zeros(1,length(t));
SOC4=zeros(1,length(t));
I5=zeros(1,length(t5));
SOC5=zeros(1,length(t5));

Q5=20.01;
for i=1:400
    for j=1:144
        for m=1:60
            I5(((144*(i-1)+j)-1)*60+m)=-Accondition.Acc5(j)*Q5*0.95;
        end
    end
end

Q4=20.11;
for i=1:500
    for j=1:144
        for m=1:60
            I4(((144*(i-1)+j)-1)*60+m)=Accondition.Acc4(j)*Q4;
        end
    end
end

Q3=20;
for i=1:500
    for j=1:144
        for m=1:60
            I3(((144*(i-1)+j)-1)*60+m)=Accondition.Acc3(j)*Q3;
        end
    end
end

Q2=19.9;
for i=1:500
    for j=1:144
        for m=1:60
            I2(((144*(i-1)+j)-1)*60+m)=Accondition.Acc2(j)*Q2;
        end
    end
end

Q1=19.89;
for i=1:500
    for j=1:144
        for m=1:60
            I1(((144*(i-1)+j)-1)*60+m)=Accondition.Acc1(j)*Q1;

        end
    end
end

    for i=1:72000
        for j=1:60
            if i==72000
                SOC1(j+60*(i-1))=RealSOC1(i);
            else
              SOC1(j+60*(i-1))=RealSOC1(i)+j/60*(RealSOC1(i+1)-RealSOC1(i));
            end
        end
    end
    
        for i=1:72000
        for j=1:60
            if i==72000
                SOC2(j+60*(i-1))=RealSOC2(i);
            else
              SOC2(j+60*(i-1))=RealSOC2(i)+j/60*(RealSOC2(i+1)-RealSOC2(i));
            end
        end
        end
    
   for i=1:72000
        for j=1:60
            if i==72000
                SOC3(j+60*(i-1))=RealSOC3(i);
            else
              SOC3(j+60*(i-1))=RealSOC3(i)+j/60*(RealSOC3(i+1)-RealSOC3(i));
            end
        end
   end
    
      for i=1:72000
        for j=1:60
            if i==72000
                SOC4(j+60*(i-1))=RealSOC4(i);
            else
              SOC4(j+60*(i-1))=RealSOC4(i)+j/60*(RealSOC4(i+1)-RealSOC4(i));
            end
        end
      end
    
          
      for i=1:57600
        for j=1:60
            if i==57600
                SOC5(j+60*(i-1))=RealSOC5(i);
            else
              SOC5(j+60*(i-1))=RealSOC5(i)+j/60*(RealSOC5(i+1)-RealSOC5(i));
            end
        end
      end
%       
%       SOC1=1-SOC1;
%       SOC2=1-SOC2;
%       SOC3=1-SOC3;
%       SOC4=1-SOC4;
%       SOC5=1-SOC5;
%% main

% addpath 'D:\博一\寿命实验\电池寿命估计(1)\sdnchen-psomatlab'
% options = psooptimset('Generations',4,'PopulationSize',100,'PlotFcns',{@psoplotbestf}); 
% 
% 
% 
% % bound settings
% % beta1, kSEI, m3, beta3, lamda
% LB = [1 ,10, 0.1, 0.01, 0.5e5, 5e8 0.0025]; 
% UB = [5, 50, 0.5, 10,  2.5e5, 10e8 0.0035];
% 
% [Zbest6, fval] = pso(@(Z) rmsefunc(SOC1,I1,SOC2,I2,SOC3,I3,SOC4,I4,SOC5,I5,Q1,Q2,Q3,Q4,Q5,t,t5,T,Z), 7, [], [], [], [], LB, UB, [], options);

%% plot    
load agingdata500 
%load Zbest5
%Z=Zbest5;
Z=[6.4 14.55 0.22 1.74 66995 5.9741e8 0.0035];
 [Qrest1,Qrestall1]=Qlossfind(SOC1,I1,t,T,Z,Q1);
  [Qrest2,Qrestall2]=Qlossfind(SOC2,I2,t,T,Z,Q2);
   [Qrest3,Qrestall3]=Qlossfind(SOC3,I3,t,T,Z,Q3);
    [Qrest4,Qrestall4]=Qlossfind(SOC4,I4,t,T,Z,Q4);
      [Qrest5,Qrestall5]=Qlossfind(SOC5,I5,t5,T,Z,Q5);

fig = figure;
ax = axes(fig);
h1=plot(t/144/60,Qrestall1,'LineWidth',1.5,'Color',[69, 117, 180]/255);
hold on
h2=plot(t/144/60,Qrestall2,'LineWidth',1.5,'Color',[145, 191, 219]/255);
hold on
h3=plot(t/144/60,Qrestall3,'LineWidth',1.5,'Color',[0.77,0.91,1.00]);
hold on
h4=plot(t/144/60,Qrestall4,'LineWidth',1.5,'Color',[254, 224, 144]/255);
hold on
h5=plot(t(1:60*144*400)/144/60,Qrestall5(1:60*144*400),'LineWidth',1.5,'Color',[237, 180, 180]/255);
hold on


scatter(cycle,ACC1,85,'o','LineWidth',1,'MarkerEdgeColor','none','MarkerFaceColor',get(h1,'color'));
hold on
scatter(cycle,ACC2,85,'s','LineWidth',1,'MarkerEdgeColor','none','MarkerFaceColor',get(h2,'color'));
hold on
scatter(cycle,ACC3,85,'^','LineWidth',1,'MarkerEdgeColor','none','MarkerFaceColor',get(h3,'color'));
hold on
scatter(cycle,ACC4,85,'diamond','LineWidth',1,'MarkerEdgeColor','none','MarkerFaceColor',get(h4,'color'));
hold on
scatter(cycle(1:9),ACC5,85,'v','LineWidth',1,'MarkerEdgeColor','none','MarkerFaceColor',get(h5,'color'));

legend('SimACC1','SimACC2','SimACC3','SimACC4','SimACC5','ExpACC1','ExpACC2','ExpACC3','ExpACC4','ExpACC5','fontsize',12,'location','southwest','NumColumns',2)
h = legend;
set(h, 'Box', 'off');

fig.Units = 'centimeters';
fig.Position(3:4) = [20, 8.4]; % 7cmx5.25cm
fig.Color = [1.0, 1.0, 1.0]; % background color
ax.Units = 'centimeters';
ax.LineWidth = 1;
ax.FontName = 'Times New Roman';
ax.FontSize = 14;
ax.TickLabelInterpreter = 'latex';
ax.XLabel.String = 'Cycle';
ax.YLabel.String = 'Capacity retention / %';
ax.XLabel.FontSize = 16;
ax.YLabel.FontSize = 16;
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
ax.TickLength(1) = 0.015;
ax.YLim = [0.82,1];
ax.YTick=[0.82 0.85 0.88 0.91 0.94 0.97 1];
ax.YTickLabel=[82 85 88 91 94 97 100];

fig = figure;
ax = axes(fig);
plot(cycle,([1;Qrest1]-ACC1)./ACC1,'o','LineWidth',1,'MarkerSize',8.5,'MarkerEdgeColor','none','MarkerFaceColor',get(h1,'color'));
hold on
plot(cycle,([1;Qrest2]-ACC2)./ACC2,'s','LineWidth',1,'MarkerSize',8.5,'MarkerEdgeColor','none','MarkerFaceColor',get(h2,'color'));
hold on
plot(cycle,([1;Qrest3]-ACC3)./ACC3,'^','LineWidth',1,'MarkerSize',8.5,'MarkerEdgeColor','none','MarkerFaceColor',get(h3,'color'));
hold on
plot(cycle,([1;Qrest4]-ACC4)./ACC4,'diamond','LineWidth',1,'MarkerSize',8.5,'MarkerEdgeColor','none','MarkerFaceColor',get(h4,'color'));
hold on
plot(cycle(1:9),([1;Qrest5]-ACC5)./ACC5,'v','LineWidth',1,'MarkerSize',8.5,'MarkerEdgeColor','none','MarkerFaceColor',get(h5,'color'));
fig.Units = 'centimeters';
fig.Position(3:4) = [20, 8.4]; % 7cmx5.25cm
fig.Color = [1.0, 1.0, 1.0]; % background color
ax.Units = 'centimeters';
ax.LineWidth = 1;
ax.FontName = 'Times New Roman';
ax.FontSize = 14;
ax.TickLabelInterpreter = 'latex';
ax.XLabel.String = 'Cycle';
ax.YLabel.String = 'Relative error / %';
ax.XLabel.FontSize = 16;
ax.YLabel.FontSize = 16;
ax.XMinorTick = 'on';
ax.YMinorTick = 'on';
ax.TickLength(1) = 0.015;
ax.YLim = [-0.02,0.02];
ax.YTick=[-0.02 -0.01 0 0.01 0.02];
ax.YTickLabel=[-2 -1 0 1 2];

%% error fun

function [error] = rmsefunc(SOC1,I1,SOC2,I2,SOC3,I3,SOC4,I4,SOC5,I5,Q1,Q2,Q3,Q4,Q5,t,t5,T,Z)

% beta1=Z(1);
% kSEI=Z(2);
% m3=Z(3);
% beta3=Z(4);

 [Qrest1,~]=Qlossfind(SOC1,I1,t,T,Z,Q1);
 [Qrest2,~]=Qlossfind(SOC2,I2,t,T,Z,Q2);
 [Qrest3,~]=Qlossfind(SOC3,I3,t,T,Z,Q3);
%  [Qrest4,~]=Qlossfind(SOC4,I4,t,T,Z,Q4);
%  [Qrest5,~]=Qlossfind(SOC5,I5,t5,T,Z,Q5);
 load agingdata500 ACC1 ACC2 ACC3 ACC4 ACC5
 
   error1 = sqrt(immse(Qrest1,ACC1(2:end)));
   error2 = sqrt(immse(Qrest2,ACC2(2:end)));
   error3 = sqrt(immse(Qrest3,ACC3(2:end)));
%    error4 = sqrt(immse(Qrest4(3:end),ACC4(4:end)));
%    error5 = sqrt(immse(Qrest5(3:5),ACC5(4:6)));
   error=(error1+error2+error3)/3;
end