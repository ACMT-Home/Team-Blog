wx1=0.01;
wy1=0.01;
wf1=0.01;
wx2=0.01;
wy2=0.01;
wf2=0.01;
wx3=0.01;
wy3=0.01;
wf3=0.01;


vx12=0.01;
vy12=0.01;
vf12=0.01;


%Noise1=xlsread('Noise1_No_attack.xlsx');
%Noise1=xlsread('Noise1_DoS.xlsx');
%Noise1=xlsread('Noise1_DoS.xlsx');
%Noise1=xlsread('Noise1_Mixed.xlsx');

 Noise1=zeros(12,200);

 for i=1:100
    Noise1(1,i) =wx1*randn(1);
    Noise1(2,i) =wy1*randn(1);
    Noise1(3,i) =wf1*randn(1);
    Noise1(4,i) =wx2*randn(1);
    Noise1(5,i) =wy2*randn(1);
    Noise1(6,i) =wf2*randn(1);
    Noise1(7,i) =wx3*randn(1);
    Noise1(8,i) =wy3*randn(1);
    Noise1(9,i) =wf3*randn(1);
    Noise1(10,i)=wx4*randn(1);
    Noise1(11,i)=wy4*randn(1);
    Noise1(12,i)=wf4*randn(1);

  end