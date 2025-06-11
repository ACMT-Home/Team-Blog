NUM=31;
design=pi;

w1=zeros(1,NUM);
w2=zeros(1,NUM);
w3=zeros(1,NUM);
w4=zeros(1,NUM);

d1=0.2.*ones(1,NUM);
d2=0.2.*ones(1,NUM);
d3=(3*pi/31).*ones(1,NUM);
d4=(3*pi/31).*ones(1,NUM);

f1=(0/NUM).*ones(1,NUM);
f2=(0/NUM).*ones(1,NUM);
f3=(0/NUM).*ones(1,NUM);
f4=(0/NUM).*ones(1,NUM);

f1(1)=0;
f2(1)=pi;
f3(1)=-pi/2;
f4(1)=pi/2;

for i=1:NUM
    w1(i)=0;
    w2(i)=0;
    w3(i)=-design/(NUM);
    w4(i)=-design/(NUM);
end

in_x1=0;
in_y1=0;
in_f1=f1(1);
in_x2=10;
in_y2=6;
in_f2=f2(1);
in_x3=5;
in_y3=6;
in_f3=f3(1);
in_x4=5;
in_y4=0;
in_f4=f4(1);

wx1=0.06;
wy1=0.06;
wf1=0.04;
wx2=0.06;
wy2=0.06;
wf2=0.04;
wx3=0.06;
wy3=0.06;
wf3=0.04;
wx4=0.06;
wy4=0.06;
wf4=0.04;

% vx12=0.8;
% vy12=0.8;
% vf12=0.2;
% vx23=0.8;
% vy23=0.8;
% vf23=0.2;
% vx34=0.8;
% vy34=0.8;
% vf34=0.2;
% vx41=0.2;
% vy41=0.2;
% vf41=0.02;

vx12=0.2;
vy12=0.2;
vf12=0.04;
vx23=0.2;
vy23=0.2;
vf23=0.04;
vx34=0.2;
vy34=0.2;
vf34=0.04;
vx41=0.08;
vy41=0.08;
vf41=0.04;

x1=zeros(1,NUM);
y1=zeros(1,NUM);
x2=zeros(1,NUM);
y2=zeros(1,NUM);
x3=zeros(1,NUM);
y3=zeros(1,NUM);
x4=zeros(1,NUM);
y4=zeros(1,NUM);
Xp1=zeros(3,NUM);
Xp2=zeros(3,NUM);
Xp3=zeros(3,NUM);
Xp4=zeros(3,NUM);

Xu1=zeros(3,NUM);
Xu=zeros(12,NUM);
Xu2=zeros(3,NUM);
Xu3=zeros(3,NUM);
Xu4=zeros(3,NUM);

Xpt4=zeros(3,NUM);
Xpt3=zeros(3,NUM);
Xpt2=zeros(3,NUM);
Xpt1=zeros(3,NUM);
Pu1=zeros(3,3);
Pu2=zeros(3,3);
Pu3=zeros(3,3);
Pu4=zeros(3,3);
Pu=zeros(12,12);
Xu1(:,1)=[in_x1;in_y1;in_f1];
Xu2(:,1)=[in_x2;in_y2;in_f2];
Xu4(:,1)=[in_x4;in_y4;in_f4];

Xpt1(:,1)=[in_x1;in_y1;in_f1];
Xpt2(:,1)=[in_x2;in_y2;in_f2];
Xu3(:,1)=[in_x3;in_y3;in_f3];
Xpt3(:,1)=[in_x3;in_y3;in_f3];
Xpt4(:,1)=[in_x4;in_y4;in_f4];

x1(1)=in_x1;
y1(1)=in_y1;
x4(1)=in_x4;
y4(1)=in_y4;
x2(1)=in_x2;
x3(1)=in_x3;
y2(1)=in_y2;
y3(1)=in_y3;
f1(1)=in_f1;
f2(1)=in_f2;
f3(1)=in_f3;
f4(1)=in_f4;

Q1=[wx1^2 0 0;
    0 wy1^2 0;
    0 0 wf1^2];
Q2=[wx2^2 0 0;
    0 wy2^2 0;
    0 0 wf2^2];
Q3=[wx3^2 0 0;
    0 wy3^2 0;
    0 0 wf3^2];
Q4=[wx4^2 0 0;
    0 wy4^2 0;
    0 0 wf4^2];

Xp2_reg=zeros(3,NUM);%将攻击之前的智能体2的状态寄存
Xp3_reg=zeros(3,NUM);%将攻击之前的智能体3的状态寄存

DoS_node2=zeros(1,NUM);%DoS攻击智能体2节点
FDI_node2=zeros(1,NUM);%FDI攻击智能体2节点
DoS_node3=zeros(1,NUM);%DoS攻击智能体3节点
FDI_node3=zeros(1,NUM);%FDI攻击智能体3节点

for i=2:NUM
     f1(i)=f1(i-1)+w1(i-1);
     x1(i)=x1(i-1)+d1(i-1)*sin(f1(i));
     y1(i)=y1(i-1)+d1(i-1)*cos(f1(i));
     f2(i)=f2(i-1)+w2(i-1);
     x2(i)=x2(i-1)+d2(i-1)*sin(f2(i));
     y2(i)=y2(i-1)+d2(i-1)*cos(f2(i));
     f3(i)=f3(i-1)+w3(i-1);
     x3(i)=x3(i-1)+d3(i-1)*sin(f3(i));
     y3(i)=y3(i-1)+d3(i-1)*cos(f3(i));
     f4(i)=f4(i-1)+w4(i-1);  
     x4(i)=x4(i-1)+d4(i-1)*sin(f4(i));
     y4(i)=y4(i-1)+d4(i-1)*cos(f4(i));     
end

for i=2:NUM
    Xpt1(1,i)=Xpt1(1,i-1)+d1(i-1)*sin(Xpt1(3,i-1))+Noise1(1,i);
    Xpt1(2,i)=Xpt1(2,i-1)+d1(i-1)*cos(Xpt1(3,i-1))+Noise1(2,i);
    Xpt1(3,i)=Xpt1(3,i-1)+w1(i-1)+Noise1(3,i);
    Xpt2(1,i)=Xpt2(1,i-1)+d2(i-1)*sin(Xpt2(3,i-1))+Noise1(4,i);
    Xpt2(2,i)=Xpt2(2,i-1)+d2(i-1)*cos(Xpt2(3,i-1))+Noise1(5,i);
    Xpt2(3,i)=Xpt2(3,i-1)+w2(i-1)+Noise1(6,i);
    Xpt3(1,i)=Xpt3(1,i-1)+d3(i-1)*sin(Xpt3(3,i-1))+Noise1(7,i);
    Xpt3(2,i)=Xpt3(2,i-1)+d3(i-1)*cos(Xpt3(3,i-1))+Noise1(8,i);
    Xpt3(3,i)=Xpt3(3,i-1)+w3(i-1)+Noise1(9,i);
    Xpt4(1,i)=Xpt4(1,i-1)+d4(i-1)*sin(Xpt4(3,i-1))+Noise1(10,i);
    Xpt4(2,i)=Xpt4(2,i-1)+d4(i-1)*cos(Xpt4(3,i-1))+Noise1(11,i);
    Xpt4(3,i)=Xpt4(3,i-1)+w4(i-1)+Noise1(12,i);
end

    %预测阶段d1(i-1)*sind(a1(i-1))
for i=2:NUM
    %先验状态方程
    Xp1(1,i)=Xu1(1,i-1)+d1(i-1)*sin(Xu1(3,i-1))+Noise1(1,i);
    Xp1(2,i)=Xu1(2,i-1)+d1(i-1)*cos(Xu1(3,i-1))+Noise1(2,i);
    Xp1(3,i)=Xu1(3,i-1)+w1(i-1)+Noise1(3,i);
    Xp2(1,i)=Xu2(1,i-1)+d2(i-1)*sin(Xu2(3,i-1))+Noise1(4,i);
    Xp2(2,i)=Xu2(2,i-1)+d2(i-1)*cos(Xu2(3,i-1))+Noise1(5,i);
    Xp2(3,i)=Xu2(3,i-1)+w2(i-1)+Noise1(6,i);
    Xp3(1,i)=Xu3(1,i-1)+d3(i-1)*sin(Xu3(3,i-1))+Noise1(7,i);
    Xp3(2,i)=Xu3(2,i-1)+d3(i-1)*cos(Xu3(3,i-1))+Noise1(8,i);
    Xp3(3,i)=Xu3(3,i-1)+w3(i-1)+Noise1(9,i);
    Xp4(1,i)=Xu4(1,i-1)+d4(i-1)*sin(Xu4(3,i-1))+Noise1(10,i);
    Xp4(2,i)=Xu4(2,i-1)+d4(i-1)*cos(Xu4(3,i-1))+Noise1(11,i);
    Xp4(3,i)=Xu4(3,i-1)+w4(i-1)+Noise1(12,i);
    
    A1=[1 0 d1(i-1)*cos(Xu1(3,i-1));0 1 d1(i-1)*(-sin(Xu1(3,i-1)));0 0 1];
    A2=[1 0 d2(i-1)*cos(Xu2(3,i-1));0 1 d2(i-1)*(-sin(Xu2(3,i-1)));0 0 1];
    A3=[1 0 d3(i-1)*cos(Xu3(3,i-1));0 1 d3(i-1)*(-sin(Xu3(3,i-1)));0 0 1];
    A4=[1 0 d4(i-1)*cos(Xu4(3,i-1));0 1 d4(i-1)*(-sin(Xu4(3,i-1)));0 0 1];
        
    Pp1=A1*Pu1*(A1')+Q1;
    Pp2=A2*Pu2*(A2')+Q2;
    Pp3=A3*Pu3*(A3')+Q3;
    Pp4=A4*Pu4*(A4')+Q4;
   
    x12=cos(f1(i))*(x2(i)-x1(i))-sin(f1(i))*(y2(i)-y1(i))+Noise1(13,i);
    y12=sin(f1(i))*(x2(i)-x1(i))+cos(f1(i))*(y2(i)-y1(i))+Noise1(14,i);
    ff12=f2(i)-f1(i)+Noise1(15,i);
    x23=cos(f2(i))*(x3(i)-x2(i))-sin(f2(i))*(y3(i)-y2(i))+Noise1(16,i);
    y23=sin(f2(i))*(x3(i)-x2(i))+cos(f2(i))*(y3(i)-y2(i))+Noise1(17,i);
    ff23=f3(i)-f2(i)+Noise1(18,i);
    x34=cos(f3(i))*(x4(i)-x3(i))-sin(f3(i))*(y4(i)-y3(i))+Noise1(19,i);
    y34=sin(f3(i))*(x4(i)-x3(i))+cos(f3(i))*(y4(i)-y3(i))+Noise1(20,i);
    ff34=f4(i)-f3(i)+Noise1(21,i);
    x41=cos(f4(i))*(x1(i)-x4(i))-sin(f4(i))*(y1(i)-y4(i))+Noise1(22,i);
    y41=sin(f4(i))*(x1(i)-x4(i))+cos(f4(i))*(y1(i)-y4(i))+Noise1(23,i);
    ff41=f1(i)-f4(i)+Noise1(24,i);

    %将攻击前的信号寄存下来
    Xp2_reg(:,i)=Xp2(:,i);
    Xp3_reg(:,i)=Xp3(:,i);

    %智能体2遭受FDI攻击
    if(FDI_a2(i)==1)
        FDI_node2(i)=1;
        Xp2(1,i)=Xp2(1,i)+Xp2(1,i)*Noise3(1,i);
        Xp2(2,i)=Xp2(2,i)+Xp2(2,i)*Noise3(2,i);
        Xp2(3,i)=Xp2(3,i)+Xp2(3,i)*Noise3(3,i);
    end

    %智能体2遭受DoS攻击
    if(DoS_b2(i)==1)
        DoS_node2(i)=1;
        Xp2(1,i)=0;
        Xp2(2,i)=0;
        Xp2(3,i)=0;
    end

    %智能体3遭受FDI攻击
    if(FDI_a3(i)==1)
        FDI_node3(i)=1;
        Xp3(1,i)=Xp3(1,i)+Xp3(1,i)*Noise3(4,i);
        Xp3(2,i)=Xp3(2,i)+Xp3(2,i)*Noise3(5,i);
        Xp3(3,i)=Xp3(3,i)+Xp3(3,i)*Noise3(6,i);
    end

    %智能体3遭受DoS攻击
    if(DoS_b3(i)==1)
        DoS_node3(i)=1;
        Xp3(1,i)=0;
        Xp3(2,i)=0;
        Xp3(3,i)=0;
    end
      
     D1=[cos(Xp4(3,i)) -sin(Xp4(3,i)) 0;
      sin(Xp4(3,i)) cos(Xp4(3,i)) 0;
      0 0 1];
  
     D2=[cos(Xp1(3,i)) -sin(Xp1(3,i)) 0;
         sin(Xp1(3,i)) cos(Xp1(3,i)) 0;
         0 0 1];
     
     D3=[cos(Xp2(3,i)) -sin(Xp2(3,i)) 0;
         sin(Xp2(3,i)) cos(Xp2(3,i)) 0;
         0 0 1];

     D4=[cos(Xp3(3,i)) -sin(Xp3(3,i)) 0;
         sin(Xp3(3,i)) cos(Xp3(3,i)) 0;
         0 0 1];

    Z2=Xp1(:,i)+(D2^(-1))*[x12;y12;ff12];
    Z3=Xp2(:,i)+(D3^(-1))*[x23;y23;ff23];
    Z4=Xp3(:,i)+(D4^(-1))*[x34;y34;ff34];
    Z1=Xp4(:,i)+(D1^(-1))*[x41;y41;ff41];

  R1=[vx41^2 0 0;
      0 vy41^2 0;
      0 0 vf41^2];
  R2=[vx12^2 0 0;
      0 vy12^2 0;
      0 0 vf12^2];
  R3=[vx23^2 0 0;
      0 vy23^2 0;
      0 0 vf23^2];
  R4=[vx34^2 0 0;
      0 vy34^2 0;
      0 0 vf34^2];  

  PP1=(D1^-1)*Pp4*((D1^-1)')+R1;
  PP2=(D2^-1)*Pp1*((D2^-1)')+R2;
  PP3=(D3^-1)*Pp2*((D3^-1)')+R3;
  PP4=(D4^-1)*Pp3*((D4^-1)')+R4;
  
    [Xu2(:,i),Pu2]=CII(Xp2_reg(:,i),Z2,Pp2,PP2);
    [Xu1(:,i),Pu1]=CII(Xp1(:,i),Z1,Pp1,PP1);
    [Xu3(:,i),Pu3]=CII(Xp3_reg(:,i),Z3,Pp3,PP3);
    [Xu4(:,i),Pu4]=CII(Xp4(:,i),Z4,Pp4,PP4); 
end

for i=2:NUM-1
    Xu1(:,i)=(Xu1(:,i)+Xu1(:,i-1)+Xu1(:,i+1))/3;
    Xu2(:,i)=(Xu2(:,i)+Xu2(:,i-1)+Xu2(:,i+1))/3;
    Xu3(:,i)=(Xu3(:,i)+Xu3(:,i-1)+Xu3(:,i+1))/3;
    Xu4(:,i)=(Xu4(:,i)+Xu4(:,i-1)+Xu4(:,i+1))/3;
end

for i=2:NUM-1
    Xu1(:,i)=(Xu1(:,i)+Xu1(:,i-1)+Xu1(:,i+1))/3;
    Xu2(:,i)=(Xu2(:,i)+Xu2(:,i-1)+Xu2(:,i+1))/3;
    Xu3(:,i)=(Xu3(:,i)+Xu3(:,i-1)+Xu3(:,i+1))/3;
    Xu4(:,i)=(Xu4(:,i)+Xu4(:,i-1)+Xu4(:,i+1))/3;
end

for i=2:NUM-1
    Xu1(:,i)=(Xu1(:,i)+Xu1(:,i-1)+Xu1(:,i+1))/3;
    Xu2(:,i)=(Xu2(:,i)+Xu2(:,i-1)+Xu2(:,i+1))/3;
    Xu3(:,i)=(Xu3(:,i)+Xu3(:,i-1)+Xu3(:,i+1))/3;
    Xu4(:,i)=(Xu4(:,i)+Xu4(:,i-1)+Xu4(:,i+1))/3;
end

for i=2:NUM-1
    Xu1(:,i)=(Xu1(:,i)+Xu1(:,i-1)+Xu1(:,i+1))/3;
    Xu2(:,i)=(Xu2(:,i)+Xu2(:,i-1)+Xu2(:,i+1))/3;
    Xu3(:,i)=(Xu3(:,i)+Xu3(:,i-1)+Xu3(:,i+1))/3;
    Xu4(:,i)=(Xu4(:,i)+Xu4(:,i-1)+Xu4(:,i+1))/3;
end

 xu1_3=Xu1;
  xu2_3=Xu2;
  xu3_3=Xu3;
  xu4_3=Xu4;

C1=[0.92 0.1 0.1];
C2=[0.86 0.6 0];
C3=[0.33 0.76 0.34];
C4=[0.59 0.15 0.75];
C5=[0.49 0.99 0];
C6=[0.53 0.51 1];
C7=[0.24 0.35 0.67];
C8=[1 0.38 0.11];
C9=[0.74 0.49 0.49];

l_width=1.5;
m_size=5;

figure(1)
plot(x1,y1,'kx-','linewidth',l_width,'MarkerSize',m_size);  
hold on;
plot(x2,y2,'k*-','linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(x3,y3,'kd-','linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(x4,y4,'kv-','linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(Xu1(1,:),Xu1(2,:),'s-','Color',C1,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(Xu2(1,:),Xu2(2,:),'s-','Color',C2,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(Xu3(1,:),Xu3(2,:),'s-','Color',C3,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(Xu4(1,:),Xu4(2,:),'s-','Color',C4,'linewidth',l_width,'MarkerSize',m_size);
% hold on;
% plot(Xpt1(1,:),Xpt1(2,:),'x-','Color',C5,'linewidth',l_width,'MarkerSize',m_size);
% hold on;
% plot(Xpt2(1,:),Xpt2(2,:),'x-','Color',C6,'linewidth',l_width,'MarkerSize',m_size);
% hold on;
% plot(Xpt3(1,:),Xpt3(2,:),'x-','Color',C7,'linewidth',l_width,'MarkerSize',m_size);
% hold on;
% plot(Xpt4(1,:),Xpt4(2,:),'x-','Color',C8,'linewidth',l_width,'MarkerSize',m_size);
xlim([-1 11]),ylim([-1 9]);
grid on;
set(gca,'Fontname', 'Times New Roman','FontSize',15,'FontWeight','bold');
xlabel('X(m)','FontName','Times New Roman','FontSize',16,'FontWeight','bold');
ylabel('Y(m)','FontName','Times New Roman','FontSize',16,'FontWeight','bold');
legend('A1:Real Trajectory','A2:Real Trajectory','A3:Real Trajectory','A4:Real Trajectory','A1:EKF Trajectory','A2:EKF Trajectory','A3:EKF Trajectory','A4:EKF Trajectory','FontName','Times New Roman','FontSize',13,'LineWidth',1,'FontWeight','bold');

rmse_dkf =zeros(NUM,1);
rmse_dkf1=zeros(NUM,1);
rmse_dkf2=zeros(NUM,1);
rmse_dkf3=zeros(NUM,1);
rmse_dkf4=zeros(NUM,1);

rmse_dr =zeros(NUM,1);
rmse_dr1=zeros(NUM,1);
rmse_dr2=zeros(NUM,1);
rmse_dr3=zeros(NUM,1);
rmse_dr4=zeros(NUM,1);

for i=1:NUM
    rmse_dkf1(i) = sqrt((x1(i)-Xu1(1,i))^2+(y1(i)-Xu1(2,i))^2);
    rmse_dkf2(i) = sqrt((x2(i)-Xu2(1,i))^2+(y2(i)-Xu2(2,i))^2);
    rmse_dkf3(i) = sqrt((x3(i)-Xu3(1,i))^2+(y3(i)-Xu3(2,i))^2);
    rmse_dkf4(i) = sqrt((x4(i)-Xu4(1,i))^2+(y4(i)-Xu4(2,i))^2);
    rmse_dkf(i)  = (rmse_dkf1(i) + rmse_dkf2(i) + rmse_dkf3(i) + rmse_dkf4(i))/4;

    rmse_dr1(i) = sqrt((x1(i)-Xpt1(1,i))^2+(y1(i)-Xpt1(2,i))^2);
    rmse_dr2(i) = sqrt((x2(i)-Xpt2(1,i))^2+(y2(i)-Xpt2(2,i))^2);
    rmse_dr3(i) = sqrt((x3(i)-Xpt3(1,i))^2+(y3(i)-Xpt3(2,i))^2);
    rmse_dr4(i) = sqrt((x4(i)-Xpt4(1,i))^2+(y4(i)-Xpt4(2,i))^2);
    rmse_dr(i)  = (rmse_dr1(i) + rmse_dr2(i) + rmse_dr3(i) + rmse_dr4(i))/4;
end

figure(2)
plot(rmse_dkf,'o-','Color',C1,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(rmse_dr,'*-','Color',C2,'linewidth',l_width,'MarkerSize',m_size);
%xlim([-100 240]),ylim([-100 100]);
grid on;
set(gca,'Fontname', 'Times New Roman','FontSize',15,'FontWeight','bold');
xlabel('X(m)','FontName','Times New Roman','FontSize',16,'FontWeight','bold');
ylabel('RMSE(m)','FontName','Times New Roman','FontSize',16,'FontWeight','bold');
legend('DKF','DR','FontName','Times New Roman','FontSize',13,'LineWidth',1,'FontWeight','bold');

figure(3)
plot(x1,y1,'kx-','linewidth',l_width,'MarkerSize',m_size);  
hold on;
plot(x2,y2,'k*-','linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(x3,y3,'kd-','linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(x4,y4,'kv-','linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(Xpt1(1,:),Xpt1(2,:),'s-','Color',C1,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(Xpt2(1,:),Xpt2(2,:),'s-','Color',C2,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(Xpt3(1,:),Xpt3(2,:),'s-','Color',C3,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(Xpt4(1,:),Xpt4(2,:),'s-','Color',C4,'linewidth',l_width,'MarkerSize',m_size);
% hold on;
% plot(Xpt1(1,:),Xpt1(2,:),'x-','Color',C5,'linewidth',l_width,'MarkerSize',m_size);
% hold on;
% plot(Xpt2(1,:),Xpt2(2,:),'x-','Color',C6,'linewidth',l_width,'MarkerSize',m_size);
% hold on;
% plot(Xpt3(1,:),Xpt3(2,:),'x-','Color',C7,'linewidth',l_width,'MarkerSize',m_size);
% hold on;
% plot(Xpt4(1,:),Xpt4(2,:),'x-','Color',C8,'linewidth',l_width,'MarkerSize',m_size);
xlim([-1 11]),ylim([-1 9]);
grid on;
set(gca,'Fontname', 'Times New Roman','FontSize',15,'FontWeight','bold');
xlabel('X(m)','FontName','Times New Roman','FontSize',16,'FontWeight','bold');
ylabel('Y(m)','FontName','Times New Roman','FontSize',16,'FontWeight','bold');
legend('A1:Real Trajectory','A2:Real Trajectory','A3:Real Trajectory','A4:Real Trajectory','A1:DR Trajectory','A2:DR Trajectory','A3:DR Trajectory','A4:DR Trajectory','FontName','Times New Roman','FontSize',13,'LineWidth',1,'FontWeight','bold');

