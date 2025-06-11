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

vx12=0.025;
vy12=0.025;
vf12=0.02;
vx23=0.025;
vy23=0.025;
vf23=0.02;
vx34=0.025;
vy34=0.025;
vf34=0.02;
vx41=0.025;
vy41=0.025;
vf41=0.02;

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
Xu2=zeros(3,NUM);
Xu3=zeros(3,NUM);
Xu4=zeros(3,NUM);

Xpt4=zeros(3,NUM);
Xpt3=zeros(3,NUM);
Xpt2=zeros(3,NUM);
Xpt1=zeros(3,NUM);
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

Pu1=[0 0 0;0 0 0;0 0 0];
Pu2=[0 0 0;0 0 0;0 0 0];
Pu3=[0 0 0;0 0 0;0 0 0];
Pu4=[0 0 0;0 0 0;0 0 0];
Pu12=[0 0 0;0 0 0;0 0 0];
Pu21=[0 0 0;0 0 0;0 0 0];
Pu23=[0 0 0;0 0 0;0 0 0];
Pu32=[0 0 0;0 0 0;0 0 0];
Pu34=[0 0 0;0 0 0;0 0 0];
Pu43=[0 0 0;0 0 0;0 0 0];
Pu41=[0 0 0;0 0 0;0 0 0];
Pu14=[0 0 0;0 0 0;0 0 0];

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
Xp1_reg=zeros(3,NUM);%将攻击之前的智能体2的状态寄存
Xp4_reg=zeros(3,NUM);%将攻击之前的智能体3的状态寄存

DoS_node2=zeros(1,NUM);%DoS攻击智能体2节点
FDI_node2=zeros(1,NUM);%FDI攻击智能体2节点
DoS_node3=zeros(1,NUM);%DoS攻击智能体3节点
FDI_node3=zeros(1,NUM);%FDI攻击智能体3节点

%在每一个智能体上都有一个攻击检测器
%由于我们的通信拓扑以及被攻击目标为智能体2，3，那么攻击检测器应该放于智能体1，2上。
detec_node1=-1.*ones(1,NUM);%智能体1攻击检测节点，因为2被攻击，影响的是1；1->2
detec_node2=-1.*ones(1,NUM);%智能体2攻击检测节点，因为3被攻击，影响的是2；2->3
detec_node3=-1.*ones(1,NUM);%智能体1攻击检测节点，因为2被攻击，影响的是1；1->2
detec_node4=-1.*ones(1,NUM);%智能体2攻击检测节点，因为3被攻击，影响的是2；2->3

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

ar2=1-at_prob2;%遭受攻击的概率
br2=0.5;%在遭受攻击的情况下DoS与FDI各有一般的攻击概率

ar3=1-at_prob3;%遭受攻击的概率
br3=0.5;%在遭受攻击的情况下DoS与FDI各有一般的攻击概率

Xa_2=[0 0 0;0 0 0;0 0 0];%FDI攻击智能体2的信号的上界
Xa_3=[0 0 0;0 0 0;0 0 0];%FDI攻击智能体3的信号的上界

%智能体2被攻击，本身的E和与之产生连接的智能体1的E
E1_1=1;
E1_2=E1_1;
E1_3=E1_1;
E1_4=E1_1;
E1_5=E1_1;
E1_6=E1_1;
E1_7=E1_1;

E12_1=1;
E12_2=E12_1;
E12_3=E12_1;
E12_4=E12_1;
E12_5=E12_1;
E12_6=E12_1;
E12_7=E12_1;


%智能体2被攻击，本身的E和与之产生连接的智能体3的E
E2_1=1;
E2_2=E2_1;
E2_3=E2_1;
E2_4=E2_1;
E2_5=E2_1;
E2_6=E2_1;
E2_7=E2_1;

E23_1=1;
E23_2=E23_1;
E23_3=E23_1;
E23_4=E23_1;
E23_5=E23_1;
E23_6=E23_1;
E23_7=E23_1;

%智能体3被攻击，本身的E和与之产生连接的智能体4的E
E3_1=1;
E3_2=E3_1;
E3_3=E3_1;
E3_4=E3_1;
E3_5=E3_1;
E3_6=E3_1;
E3_7=E3_1;

E34_1=1;
E34_2=E34_1;
E34_3=0.1*E34_1;
E34_4=0.1*E34_1;
E34_5=0.1*E34_1;
E34_6=0.1*E34_1;
E34_7=E34_1;

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

%两两组队后的估计
R12=[vx12^2 0 0;
    0 vy12^2 0;
    0 0 vf12^2];
R23=[vx23^2 0 0;
    0 vy23^2 0;
    0 0 vf23^2];
R34=[vx34^2 0 0;
    0 vy34^2 0;
    0 0 vf34^2];
R41=[vx41^2 0 0;
    0 vy41^2 0;
    0 0 vf41^2];

for i=2:NUM
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

    Pp12=A1*Pu12*(A2');
    Pp21=A2*Pu21*(A1');
    Pp23=A2*Pu23*(A3');
    Pp32=A3*Pu32*(A2');
    Pp34=A3*Pu34*(A4');
    Pp43=A4*Pu43*(A3');
    Pp41=A4*Pu41*(A1');
    Pp14=A1*Pu14*(A4');

    x12=d12_shice(i)*cos(f12_shice(i)/180*pi);
    y12=-d12_shice(i)*sin(f12_shice(i)/180*pi);
    ff12=(f12_shice(i)/180)*pi-(f21_shice(i)/180*pi)+pi;
    x23=d23_shice(i)*cos(f23_shice(i)/180*pi);
    y23=-d23_shice(i)*sin(f23_shice(i)/180*pi);
    ff23=(f23_shice(i)/180*pi)-3*pi/2-(pi/31)*(i-1);
    x34=-d34_shice(i)*cos(f34_shice(i)/180*pi)+0.3;
    y34=-d34_shice(i)*sin(f34_shice(i)/180*pi)-0.3;
    ff34=f34_shice(i)/180*pi+pi;
    x41=cos(f4(i))*(x1(i)-x4(i))-sin(f4(i))*(y1(i)-y4(i))+Noise1(22,i);
    y41=sin(f4(i))*(x1(i)-x4(i))+cos(f4(i))*(y1(i)-y4(i))+Noise1(23,i);
    ff41=f1(i)-f4(i)+Noise1(24,i);

    %成对使用量测
    Z12=[x12;y12;ff12];
    Z23=[x23;y23;ff23];
    Z34=[x34;y34;ff34];
    Z41=[x41;y41;ff41];

    %将攻击前的信号寄存下来
    Xp1_reg(:,i)=Xp1(:,i);
    Xp4_reg(:,i)=Xp4(:,i);
    Xp2_reg(:,i)=Xp2(:,i);
    Xp3_reg(:,i)=Xp3(:,i);

    %智能体1遭受FDI攻击
    if(FDI_a1(i)==1)
        Xp1(1,i)=Xp1(1,i)+Xp1(1,i)*Noise3(1,i);
        Xp1(2,i)=Xp1(2,i)+Xp1(2,i)*Noise3(2,i);
        Xp1(3,i)=Xp1(3,i)+Xp1(3,i)*Noise3(3,i);
    end

    %智能体1遭受DoS攻击
    if(DoS_b1(i)==1)
        Xp1(1,i)=0;
        Xp1(2,i)=0;
        Xp1(3,i)=0;
    end

    %智能体2遭受FDI攻击
    if(FDI_a2(i)==1)
        Xp2(1,i)=Xp2(1,i)+Xp2(1,i)*Noise3(4,i);
        Xp2(2,i)=Xp2(2,i)+Xp2(2,i)*Noise3(5,i);
        Xp2(3,i)=Xp2(3,i)+Xp2(3,i)*Noise3(6,i);
    end

    %智能体2遭受DoS攻击
    if(DoS_b2(i)==1)
        Xp2(1,i)=0;
        Xp2(2,i)=0;
        Xp2(3,i)=0;
    end

    %智能体3遭受FDI攻击
    if(FDI_a3(i)==1)
        Xp3(1,i)=Xp3(1,i)+Xp3(1,i)*Noise3(7,i);
        Xp3(2,i)=Xp3(2,i)+Xp3(2,i)*Noise3(8,i);
        Xp3(3,i)=Xp3(3,i)+Xp3(3,i)*Noise3(9,i);
    end

    %智能体3遭受DoS攻击
    if(DoS_b3(i)==1)
        Xp3(1,i)=0;
        Xp3(2,i)=0;
        Xp3(3,i)=0;
    end

    %智能体4遭受FDI攻击
    if(FDI_a4(i)==1)
        Xp4(1,i)=Xp4(1,i)+Xp4(1,i)*Noise3(10,i);
        Xp4(2,i)=Xp4(2,i)+Xp4(2,i)*Noise3(11,i);
        Xp4(3,i)=Xp4(3,i)+Xp4(3,i)*Noise3(12,i);
    end

    %智能体4遭受DoS攻击
    if(DoS_b4(i)==1)
        Xp4(1,i)=0;
        Xp4(2,i)=0;
        Xp4(3,i)=0;
    end

    x12_hat=cos(Xp1_reg(3,i))*(Xp2(1,i)-Xp1_reg(1,i))-sin(Xp1_reg(3,i))*(Xp2(2,i)-Xp1_reg(2,i));
    y12_hat=sin(Xp1_reg(3,i))*(Xp2(1,i)-Xp1_reg(1,i))+cos(Xp1_reg(3,i))*(Xp2(2,i)-Xp1_reg(2,i));
    f_hat_12=Xp2(3,i)-Xp1_reg(3,i);
    x23_hat=cos(Xp2_reg(3,i))*(Xp3(1,i)-Xp2_reg(1,i))-sin(Xp2_reg(3,i))*(Xp3(2,i)-Xp2_reg(2,i));
    y23_hat=sin(Xp2_reg(3,i))*(Xp3(1,i)-Xp2_reg(1,i))+cos(Xp2_reg(3,i))*(Xp3(2,i)-Xp2_reg(2,i));
    f_hat_23=Xp3(3,i)-Xp2_reg(3,i);
    x34_hat=cos(Xp3_reg(3,i))*(Xp4(1,i)-Xp3_reg(1,i))-sin(Xp3_reg(3,i))*(Xp4(2,i)-Xp3_reg(2,i));
    y34_hat=sin(Xp3_reg(3,i))*(Xp4(1,i)-Xp3_reg(1,i))+cos(Xp3_reg(3,i))*(Xp4(2,i)-Xp3_reg(2,i));
    f_hat_34=Xp4(3,i)-Xp3_reg(3,i);
    x41_hat=cos(Xp4_reg(3,i))*(Xp1(1,i)-Xp4_reg(1,i))-sin(Xp4_reg(3,i))*(Xp1(2,i)-Xp4_reg(2,i));
    y41_hat=sin(Xp4_reg(3,i))*(Xp1(1,i)-Xp4_reg(1,i))+cos(Xp4_reg(3,i))*(Xp1(2,i)-Xp4_reg(2,i));
    f_hat_41=Xp1(3,i)-Xp4_reg(3,i);

    Z_hat12=[x12_hat;y12_hat;f_hat_12];
    Z_hat23=[x23_hat;y23_hat;f_hat_23];
    Z_hat34=[x34_hat;y34_hat;f_hat_34];
    Z_hat41=[x41_hat;y41_hat;f_hat_41];

    hc1=-sin(Xp1_reg(3,i))*(Xp2(1,i)-Xp1_reg(1,i))-cos(Xp1_reg(3,i))*(Xp2(2,i)-Xp1_reg(2,i));
    hc2=cos(Xp1_reg(3,i))*(Xp2(1,i)-Xp1_reg(1,i))-sin(Xp1_reg(3,i))*(Xp2(2,i)-Xp1_reg(2,i));
    hc3=-sin(Xp2_reg(3,i))*(Xp3(1,i)-Xp2_reg(1,i))-cos(Xp2_reg(3,i))*(Xp3(2,i)-Xp2_reg(2,i));
    hc4=cos(Xp2_reg(3,i))*(Xp3(1,i)-Xp2_reg(1,i))-sin(Xp2_reg(3,i))*(Xp3(2,i)-Xp2_reg(2,i));
    hc5=-sin(Xp3_reg(3,i))*(Xp4(1,i)-Xp3_reg(1,i))-cos(Xp3_reg(3,i))*(Xp4(2,i)-Xp3_reg(2,i));
    hc6=cos(Xp3_reg(3,i))*(Xp4(1,i)-Xp3_reg(1,i))-sin(Xp3_reg(3,i))*(Xp4(2,i)-Xp3_reg(2,i));
    hc7=-sin(Xp4_reg(3,i))*(Xp1(1,i)-Xp4_reg(1,i))-cos(Xp4_reg(3,i))*(Xp1(2,i)-Xp4_reg(2,i));
    hc8=cos(Xp4_reg(3,i))*(Xp1(1,i)-Xp4_reg(1,i))-sin(Xp4_reg(3,i))*(Xp1(2,i)-Xp4_reg(2,i));

    %z12用于更新智能体1和2，对其求x1和x2偏导得到
    D1=[-cos(Xp1_reg(3,i)) sin(Xp1_reg(3,i)) hc1;
        -sin(Xp1_reg(3,i)) -cos(Xp1_reg(3,i)) hc2;
        0 0 -1];

    D12=[cos(Xp1_reg(3,i)) -sin(Xp1_reg(3,i)) 0;
        sin(Xp1_reg(3,i)) cos(Xp1_reg(3,i)) 0;
        0 0 1];

    %z23用于更新智能体2和3，对其求x2和x3偏导得到
    D2=[-cos(Xp2_reg(3,i)) sin(Xp2_reg(3,i)) hc3;
        -sin(Xp2_reg(3,i)) -cos(Xp2_reg(3,i)) hc4;
        0 0 -1];

    D23=[cos(Xp2_reg(3,i)) -sin(Xp2_reg(3,i)) 0;
        sin(Xp2_reg(3,i)) cos(Xp2_reg(3,i)) 0;
        0 0 1];

    %z34用于更新智能体3和4，对其求x3和x4偏导得到
    D3=[-cos(Xp3_reg(3,i)) sin(Xp3_reg(3,i)) hc5;
        -sin(Xp3_reg(3,i)) -cos(Xp3_reg(3,i)) hc6;
        0 0 -1];

    D34=[cos(Xp3_reg(3,i)) -sin(Xp3_reg(3,i)) 0;
        sin(Xp3_reg(3,i)) cos(Xp3_reg(3,i)) 0;
        0 0 1];

    %z41用于更新智能体4和1，对其求x4和x1偏导得到
    D4=[-cos(Xp4_reg(3,i)) sin(Xp4_reg(3,i)) hc7;
        -sin(Xp4_reg(3,i)) -cos(Xp4_reg(3,i)) hc8;
        0 0 -1];

    D41=[cos(Xp4_reg(3,i)) -sin(Xp4_reg(3,i)) 0;
        sin(Xp4_reg(3,i)) cos(Xp4_reg(3,i)) 0;
        0 0 1];

    jud_Z12= Z12-Z_hat12;
    sigema_z12=50*norm([vx12 vy12 vf12]);

    jud_Z23= Z23-Z_hat23;
    sigema_z23=50*norm([vx23 vy23 vf23]);

    jud_Z34= Z34-Z_hat34;
    sigema_z34=50*norm([vx34 vy34 vf34]);

    jud_Z41= Z41-Z_hat41;
    sigema_z41=50*norm([vx41 vy41 vf41]);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%更新智能体1%%%%%%%%%%%%%%%%%%%%%%%%
    if(norm(jud_Z12)>sigema_z12)
        Xu1(:,i)=Xp1_reg(:,i);
        Pu1=Pp1;
        Pu12=Pp12;
        %Pu2=Pp2;
        Pu21=Pp21;
        detec_node1(i)=1;
    else
        X_2=Xp2(:,i)*((Xp2(:,i))');
        S1_1=(E1_1^-1)*(1-ar2)^2*D12*X_2*(D12');
        S1_2=(E1_2^-1)*(1-ar2)^2*br2^2*D12*Xa_2*(D12');
        S1_3=D1*Pp1*(D1')+D1*Pp12*(D12');
        S1_4=E1_3*D1*Pp1*(D1')+(E1_3^-1)*(1-ar2)^2*D12*X_2*(D12');
        S1_5=E1_4*D1*Pp1*(D1')+(E1_4^-1)*(1-ar2)^2*br2^2*D12*Xa_2*(D12');
        S1_6=D12*Pp21*(D1')+D12*Pp2*(D12');
        S1_7=E1_5*D12*Pp2*(D12')+(E1_5^-1)*(1-ar2)^2*D12*X_2*(D12');
        S1_8=E1_6*D12*Pp2*(D12')+(E1_6^-1)*(1-ar2)^2*br2^2*D12*Xa_2*(D12');
        S1_9=E1_7*(1-ar2)^2*D12*X_2*(D12')+(E1_7^-1)*(1-ar2)^2*br2^2*D12*Xa_2*(D12');
        S1_10=(1-ar2)^2*D12*X_2*(D12')+(1-ar2)^2*br2^2*D12*Xa_2*(D12')+R12;
        S1=S1_1+S1_3+S1_4+S1_5+S1_6+S1_7+S1_8+S1_9+S1_10+S1_2;

        K1=(Pp1*(D1')+Pp12*(D12'))*(S1^(-1));%卡尔曼增益
        Xu1(:,i)=Xp1_reg(:,i)+K1*(Z12-Z_hat12);%后验估计
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%后验协方差
        Pu1=Pp1-(K1*D1*Pp1+K1*D12*Pp21);
        Pu12=Pp12-(K1*D1*Pp12+K1*D12*Pp2);
        %Pu2=Pp2-(K2*D1*Pp12+K2*D12*Pp2);
        Pu21=Pu12';
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%更新智能体1%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%更新智能体2%%%%%%%%%%%%%%%%%%%%%%%%
    if(norm(jud_Z23)>sigema_z23)
        Xu2(:,i)=Xp2_reg(:,i);
        Pu2=Pp2;
        Pu23=Pp23;
        Pu32=Pp32;
        detec_node2(i)=1;
    else
        X_4=Xp3(:,i)*((Xp3(:,i))');
        S2_1=(E2_1^-1)*(1-ar3)^2*D23*X_4*(D23');
        S2_2=(E2_2^-1)*(1-ar3)^2*br3^2*D23*Xa_2*(D23');
        S2_3=D2*Pp2*(D2')+D2*Pp23*(D23');
        S2_4=E2_3*D2*Pp2*(D2')+(E2_3^-1)*(1-ar3)^2*D23*X_4*(D23');
        S2_5=E2_4*D2*Pp2*(D2')+(E2_4^-1)*(1-ar3)^2*br3^2*D23*Xa_2*(D23');
        S2_6=D23*Pp32*(D2')+D23*Pp3*(D23');
        S2_7=E2_5*D23*Pp3*(D23')+(E2_5^-1)*(1-ar3)^2*D23*X_4*(D23');
        S2_8=E2_6*D23*Pp3*(D23')+(E2_6^-1)*(1-ar3)^2*br3^2*D23*Xa_2*(D23');
        S2_9=E2_7*(1-ar3)^2*D23*X_4*(D23')+(E2_7^-1)*(1-ar3)^2*br3^2*D23*Xa_2*(D23');
        S2_10=(1-ar3)^2*D23*X_4*(D23')+(1-ar3)^2*br3^2*D23*Xa_2*(D23')+R23;
        S2=S2_1+S2_3+S2_4+S2_5+S2_6+S2_7+S2_8+S2_9+S2_10+S2_2;

        K2=(Pp2*(D2')+Pp23*(D23'))*(S2^(-1));%卡尔曼增益
        Xu2(:,i)=Xp2_reg(:,i)+K2*(Z23-Z_hat23);%后验估计
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%后验协方差
        Pu2=Pp2-(K2*D2*Pp2+K2*D23*Pp32);
        Pu23=Pp23-(K2*D2*Pp23+K2*D23*Pp3);
        %Pu3=Pp3-(K2*D2*Pp23+K2*D23*Pp3);
        Pu32=Pu23';
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%更新智能体2%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%更新智能体3%%%%%%%%%%%%%%%%%%%%%%%%
    if(norm(jud_Z34)>sigema_z34)
        Xu3(:,i)=Xp3_reg(:,i);
        Pu3=Pp3;
        Pu34=Pp34;
        Pu43=Pp43;
        detec_node3(i)=1;
    else
        X_4=Xp4(:,i)*((Xp4(:,i))');
        S2_1=(E2_1^-1)*(1-ar3)^2*D34*X_4*(D34');
        S2_2=(E2_2^-1)*(1-ar3)^2*br3^2*D34*Xa_2*(D34');
        S2_3=D3*Pp3*(D3')+D3*Pp34*(D34');
        S2_4=E2_3*D3*Pp3*(D3')+(E2_3^-1)*(1-ar3)^2*D34*X_4*(D34');
        S2_5=E2_4*D3*Pp3*(D3')+(E2_4^-1)*(1-ar3)^2*br3^2*D34*Xa_2*(D34');
        S2_6=D34*Pp43*(D3')+D34*Pp4*(D34');
        S2_7=E2_5*D34*Pp4*(D34')+(E2_5^-1)*(1-ar3)^2*D34*X_4*(D34');
        S2_8=E2_6*D34*Pp4*(D34')+(E2_6^-1)*(1-ar3)^2*br3^2*D34*Xa_2*(D34');
        S2_9=E2_7*(1-ar3)^2*D34*X_4*(D34')+(E2_7^-1)*(1-ar3)^2*br3^2*D34*Xa_2*(D34');
        S2_10=(1-ar3)^2*D34*X_4*(D34')+(1-ar3)^2*br3^2*D34*Xa_2*(D34')+R23;
        S3=S2_1+S2_3+S2_4+S2_5+S2_6+S2_7+S2_8+S2_9+S2_10+S2_2;

        %S3=D3*Pp3*(D3')+D3*Pp34*(D34')+D34*Pp43*(D3')+D34*Pp4*(D34')+R34;
        K3=(Pp3*(D3')+Pp34*(D34'))*(S3^(-1));
        Xu3(:,i)=Xp3_reg(:,i)+K3*(Z34-Z_hat34);
        Pu3=Pp3-(K3*D3*Pp3+K3*D34*Pp43);
        Pu34=Pp34-(K3*D3*Pp34+K3*D34*Pp4);
        Pu43=Pu34';
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%更新智能体3%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%更新智能体4%%%%%%%%%%%%%%%%%%%%%%%%
    if(norm(jud_Z41)>sigema_z41)
        Xu4(:,i)=Xp4_reg(:,i);
        Pu4=Pp4;
        Pu41=Pp41;
        Pu14=Pp14;
        detec_node4(i)=1;
    else
        X_4=Xp1(:,i)*((Xp1(:,i))');
        S2_1=(E2_1^-1)*(1-ar3)^2*D41*X_4*(D41');
        S2_2=(E2_2^-1)*(1-ar3)^2*br3^2*D41*Xa_2*(D41');
        S2_3=D4*Pp4*(D4')+D4*Pp41*(D41');
        S2_4=E2_3*D4*Pp4*(D4')+(E2_3^-1)*(1-ar3)^2*D41*X_4*(D41');
        S2_5=E2_4*D4*Pp4*(D4')+(E2_4^-1)*(1-ar3)^2*br3^2*D41*Xa_2*(D41');
        S2_6=D41*Pp14*(D4')+D41*Pp1*(D41');
        S2_7=E2_5*D41*Pp1*(D41')+(E2_5^-1)*(1-ar3)^2*D41*X_4*(D41');
        S2_8=E2_6*D41*Pp1*(D41')+(E2_6^-1)*(1-ar3)^2*br3^2*D41*Xa_2*(D41');
        S2_9=E2_7*(1-ar3)^2*D41*X_4*(D41')+(E2_7^-1)*(1-ar3)^2*br3^2*D41*Xa_2*(D41');
        S2_10=(1-ar3)^2*D41*X_4*(D41')+(1-ar3)^2*br3^2*D41*Xa_2*(D41')+R23;
        S4=S2_1+S2_3+S2_4+S2_5+S2_6+S2_7+S2_8+S2_9+S2_10+S2_2;
        %S4=D4*Pp4*(D4')+D4*Pp41*(D41')+D41*Pp14*(D4')+D41*Pp4*(D41')+R41;
        K4=(Pp4*(D4')+Pp41*(D41'))*(S4^(-1));
        Xu4(:,i)=Xp4_reg(:,i)+K4*(Z41-Z_hat41);
        Pu4=Pp4-(K4*D4*Pp4+K4*D41*Pp14);
        Pu41=Pp41-(K4*D4*Pp41+K4*D41*Pp4);
        Pu14=Pu41';
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%更新智能体4%%%%%%%%%%%%%%%%%%%%%%%%
end

xu1_1=Xu1;
xu2_1=Xu2;
xu3_1=Xu3;
xu4_1=Xu4;

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
plot(FDI_node2,'*','Color',C1,'linewidth',l_width-0.5,'MarkerSize',m_size+2);
hold on;
plot(DoS_node2,'.','Color',C2,'linewidth',l_width,'MarkerSize',m_size+8);
hold on;
plot(detec_node1,'o','Color',C3,'linewidth',l_width,'MarkerSize',m_size+2);
ylim([0.5 1.5]);
legend('FDI node2','DoS node2','detec node1','FontName','Times New Roman','FontSize',13,'LineWidth',1,'FontWeight','bold');


figure(4)
plot(FDI_node3,'*','Color',C1,'linewidth',l_width-0.5,'MarkerSize',m_size+2);
hold on;
plot(DoS_node3,'.','Color',C2,'linewidth',l_width,'MarkerSize',m_size+8);
hold on;
plot(detec_node2,'o','Color',C3,'linewidth',l_width,'MarkerSize',m_size+2);
ylim([0.5 1.5]);
legend('FDI node2','DoS node2','detec node1','FontName','Times New Roman','FontSize',13,'LineWidth',1,'FontWeight','bold');
