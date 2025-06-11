agntx1=0.9;
agnty1=0.9;
agntf1=0.9;
agntx2=0.9;
agnty2=0.9;
agntf2=0.9;
agntx3=0.9;
agnty3=0.9;
agntf3=0.9;
agntx4=0.9;
agnty4=0.9;
agntf4=0.9;

Noise3=zeros(12,100);

for i=1:200
    Noise3(1,i)=agntx1*randn(1,1);
    Noise3(2,i)=agnty1*randn(1,1);
    Noise3(3,i)=agntf1*randn(1,1); 
    Noise3(4,i)=agntx2*randn(1,1);
    Noise3(5,i)=agnty2*randn(1,1);
    Noise3(6,i)=agntf2*randn(1,1);
    Noise3(7,i)=agntx3*randn(1,1);
    Noise3(8,i)=agnty3*randn(1,1);
    Noise3(9,i)=agntf3*randn(1,1); 
    Noise3(10,i)=agntx4*randn(1,1);
    Noise3(11,i)=agnty4*randn(1,1);
    Noise3(12,i)=agntf4*randn(1,1);
end

% Noise3=xlsread('Noise3_FDI.xlsx');
% Noise3=xlsread('Noise3_DoS.xlsx');
% Noise3=xlsread('Noise3_Mixed.xlsx');