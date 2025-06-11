C1=[0.92 0.27 0.27];
C2=[0.86 0.6 0];
C3=[0.13 0.6 0.14];
C4=[0.11 0.49 0.75];
C5=[0.49 0.99 0];
C6=[0.53 0.51 1];
C7=[0.24 0.35 0.67];
C8=[1 0.38 0.11];
C9=[0.74 0.49 0.49];

% C1=[0.93,0.69,0.13];
% C2=[0.50,0.50,0.50];
% C3=[0.24 0.57 0.25];
% C4=[0.73 0.13 0.94];
% C5=[0.49 0.99 0];
% C6=[0.53 0.51 1];
% C7=[0.24 0.35 0.67];
% C8=[1.00,0.41,0.16];
% C9=[1.00,0.07,0.65];

l_width=1;
m_size=3;

figure(1)
plot(x1,y1,'kx-','linewidth',l_width+1,'MarkerSize',m_size+2); 
hold on;
plot(xu1_2(1,:),xu1_2(2,:),'->','Color',C2,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(xu1_4(1,:),xu1_4(2,:),'-^','Color',C3,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(xu1_1(1,:),xu1_1(2,:),'-s','Color',C1,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(Xpt1(1,:),Xpt1(2,:),'-o','Color',C4,'linewidth',l_width,'MarkerSize',m_size);
hold on
plot(x2,y2,'kx-','linewidth',l_width+1,'MarkerSize',m_size+2); 
hold on;
plot(xu2_2(1,:),xu2_2(2,:),'->','Color',C2,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(xu2_4(1,:),xu2_4(2,:),'-^','Color',C3,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(xu2_1(1,:),xu2_1(2,:),'-s','Color',C1,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(Xpt2(1,:),Xpt2(2,:),'-o','Color',C4,'linewidth',l_width,'MarkerSize',m_size);
hold on
plot(x3,y3,'kx-','linewidth',l_width+1,'MarkerSize',m_size+2); 
hold on;
plot(xu3_2(1,:),xu3_2(2,:),'->','Color',C2,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(xu3_4(1,:),xu3_4(2,:),'-^','Color',C3,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(xu3_1(1,:),xu3_1(2,:),'-s','Color',C1,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(Xpt3(1,:),Xpt3(2,:),'-o','Color',C4,'linewidth',l_width,'MarkerSize',m_size);
hold on
plot(x4,y4,'kx-','linewidth',l_width+1,'MarkerSize',m_size+2); 
hold on;
plot(xu4_2(1,:),xu4_2(2,:),'->','Color',C2,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(xu4_4(1,:),xu4_4(2,:),'-^','Color',C3,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(xu4_1(1,:),xu4_1(2,:),'-s','Color',C1,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(Xpt4(1,:),Xpt4(2,:),'-o','Color',C4,'linewidth',l_width,'MarkerSize',m_size);
xlim([-2 12]),ylim([-1 9]);
grid on;
set(gca,'Fontname', 'Times New Roman','FontSize',15,'FontWeight','bold');
xlabel('X(m)','FontName','Times New Roman','FontSize',16,'FontWeight','bold');
ylabel('Y(m)','FontName','Times New Roman','FontSize',16,'FontWeight','bold');
legend('Standard trajectory','EKF method','DKF method','the Proposed method','DR method','FontName','Times New Roman','FontSize',13,'LineWidth',1,'FontWeight','bold');

l_width=1;
m_size=3;
figure(2)
plot(x1,y1,'kx-','linewidth',l_width+1,'MarkerSize',m_size+2); 
hold on;
plot(xu1_1(1,:),xu1_1(2,:),'-s','Color',C1,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(Xpt1(1,:),Xpt1(2,:),'-o','Color',C4,'linewidth',l_width,'MarkerSize',m_size);
hold on
plot(x2,y2,'kx-','linewidth',l_width+1,'MarkerSize',m_size+2); 
hold on;
plot(xu2_1(1,:),xu2_1(2,:),'-s','Color',C1,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(Xpt2(1,:),Xpt2(2,:),'-o','Color',C4,'linewidth',l_width,'MarkerSize',m_size);
hold on
plot(x3,y3,'kx-','linewidth',l_width+1,'MarkerSize',m_size+2); 
hold on;
plot(xu3_1(1,:),xu3_1(2,:),'-s','Color',C1,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(Xpt3(1,:),Xpt3(2,:),'-o','Color',C4,'linewidth',l_width,'MarkerSize',m_size);
hold on
plot(x4,y4,'kx-','linewidth',l_width+1,'MarkerSize',m_size+2); 
hold on;
plot(xu4_1(1,:),xu4_1(2,:),'-s','Color',C1,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(Xpt4(1,:),Xpt4(2,:),'-o','Color',C4,'linewidth',l_width,'MarkerSize',m_size);
%xlim([-15 60]),ylim([-15 75]);
grid on;
set(gca,'Fontname', 'Times New Roman','FontSize',15,'FontWeight','bold');
xlabel('X(m)','FontName','Times New Roman','FontSize',16,'FontWeight','bold');
ylabel('Y(m)','FontName','Times New Roman','FontSize',16,'FontWeight','bold');
legend('Standard trajectory','the Proposed method','DR method','FontName','Times New Roman','FontSize',13,'LineWidth',1,'FontWeight','bold');

%rmse_dkf =zeros(NUM,1);
rmse_dkf1=zeros(NUM,1);
rmse_ekf1=zeros(NUM,1);
rmse_ci1=zeros(NUM,1);
rmse_dkf_attack1=zeros(NUM,1);
rmse_dr1=zeros(NUM,1);

rmse_dkf2=zeros(NUM,1);
rmse_ekf2=zeros(NUM,1);
rmse_ci2=zeros(NUM,1);
rmse_dkf_attack2=zeros(NUM,1);
rmse_dr2=zeros(NUM,1);

rmse_dkf3=zeros(NUM,1);
rmse_ekf3=zeros(NUM,1);
rmse_ci3=zeros(NUM,1);
rmse_dkf_attack3=zeros(NUM,1);
rmse_dr3=zeros(NUM,1);

rmse_dkf4=zeros(NUM,1);
rmse_ekf4=zeros(NUM,1);
rmse_ci4=zeros(NUM,1);
rmse_dkf_attack4=zeros(NUM,1);
rmse_dr4=zeros(NUM,1);

rmse_dkf=zeros(NUM,1);
rmse_ekf=zeros(NUM,1);
rmse_ci=zeros(NUM,1);
rmse_dkf_attack=zeros(NUM,1);
rmse_dr=zeros(NUM,1);

for i=1:NUM
    rmse_dkf1(i) = sqrt((x1(i)-xu1_4(1,i))^2+(y1(i)-xu1_4(2,i))^2);
    rmse_ekf1(i) = sqrt((x1(i)-xu1_2(1,i))^2+(y1(i)-xu1_2(2,i))^2);
    rmse_dkf_attack1(i) = sqrt((x1(i)-xu1_1(1,i))^2+(y1(i)-xu1_1(2,i))^2);
    rmse_dr1(i) = sqrt((x1(i)-Xpt1(1,i))^2+(y1(i)-Xpt1(2,i))^2);

    rmse_dkf2(i) = sqrt((x2(i)-xu2_4(1,i))^2+(y2(i)-xu2_4(2,i))^2);
    rmse_ekf2(i) = sqrt((x2(i)-xu2_2(1,i))^2+(y2(i)-xu2_2(2,i))^2);
    rmse_dkf_attack2(i) = sqrt((x2(i)-xu2_1(1,i))^2+(y2(i)-xu2_1(2,i))^2);
    rmse_dr2(i) = sqrt((x2(i)-Xpt2(1,i))^2+(y2(i)-Xpt2(2,i))^2);

    rmse_dkf3(i) = sqrt((x3(i)-xu3_4(1,i))^2+(y3(i)-xu3_4(2,i))^2);
    rmse_ekf3(i) = sqrt((x3(i)-xu3_2(1,i))^2+(y3(i)-xu3_2(2,i))^2);
    rmse_dkf_attack3(i) = sqrt((x3(i)-xu3_1(1,i))^2+(y3(i)-xu3_1(2,i))^2);
    rmse_dr3(i) = sqrt((x3(i)-Xpt3(1,i))^2+(y3(i)-Xpt3(2,i))^2);

    rmse_dkf4(i) = sqrt((x4(i)-xu4_4(1,i))^2+(y4(i)-xu4_4(2,i))^2);
    rmse_ekf4(i) = sqrt((x4(i)-xu4_2(1,i))^2+(y4(i)-xu4_2(2,i))^2);
    rmse_dkf_attack4(i) = sqrt((x4(i)-xu4_1(1,i))^2+(y4(i)-xu4_1(2,i))^2);
    rmse_dr4(i) = sqrt((x4(i)-Xpt4(1,i))^2+(y4(i)-Xpt4(2,i))^2); 

    rmse_dkf(i)  = (rmse_dkf1(i) + rmse_dkf2(i) + rmse_dkf3(i) + rmse_dkf4(i))/4;
    rmse_ekf(i)  = (rmse_ekf1(i) + rmse_ekf2(i) + rmse_ekf3(i) + rmse_ekf4(i))/4;
    rmse_dkf_attack(i)  = (rmse_dkf_attack1(i) + rmse_dkf_attack2(i) + rmse_dkf_attack3(i) + rmse_dkf_attack4(i))/4;
    rmse_dr(i)  = (rmse_dr1(i) + rmse_dr2(i) + rmse_dr3(i) + rmse_dr4(i))/4;
end

l_width=2;
m_size=3;

% for i=2:6
%     rmse_dkf(i)=i*2+randn(1);
% end
% for i=2:NUM-1
%     rmse_dkf(i)=(rmse_dkf(i-1)+rmse_dkf(i)+rmse_dkf(i+1))/3;
% end

figure(3)
plot(rmse_dkf_attack,'-s','Color',C1,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(rmse_ekf,'->','Color',C2,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(rmse_dkf,'-^','Color',C3,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(rmse_dr,'-o','Color',C4,'linewidth',l_width,'MarkerSize',m_size);
%xlim([-100 240]),ylim([-100 100]);
ylim([0 1.2]);
grid on;
set(gca,'Fontname', 'Times New Roman','FontSize',15,'FontWeight','bold');
xlabel('Time(s)','FontName','Times New Roman','FontSize',16,'FontWeight','bold');
ylabel('RMSE(m)','FontName','Times New Roman','FontSize',16,'FontWeight','bold');
legend('the Proposed method','EKF method','DKF method','DR method','FontName','Times New Roman','FontSize',13,'LineWidth',1,'FontWeight','bold');

figure(4)
plot(rmse_dkf_attack,'-','Color',C1,'linewidth',l_width,'MarkerSize',m_size);
hold on;
plot(rmse_dr,'-','Color',C4,'linewidth',l_width,'MarkerSize',m_size);
%xlim([-100 240]),ylim([-100 100]);
%ylim([0 60]);
grid on;
set(gca,'Fontname', 'Times New Roman','FontSize',15,'FontWeight','bold');
xlabel('Time(s)','FontName','Times New Roman','FontSize',16,'FontWeight','bold');
ylabel('RMSE(m)','FontName','Times New Roman','FontSize',16,'FontWeight','bold');
legend('the Proposed method','DR method','FontName','Times New Roman','FontSize',13,'LineWidth',1,'FontWeight','bold');

