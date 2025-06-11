NUM=31;
at_prob1=0;%智能体2攻击概率
FDI_prob1=0;%智能体2被FDI攻击概率
DoS_prob1=0;%智能体2被DoS攻击概率

at_prob2=0;%智能体2攻击概率
FDI_prob2=0;%智能体2被FDI攻击概率
DoS_prob2=0;%智能体2被DoS攻击概率

at_prob3=0;%智能体3攻击概率
FDI_prob3=0;%智能体3被FDI攻击概率
DoS_prob3=0;%智能体3被DoS攻击概率

at_prob4=0;%智能体2攻击概率
FDI_prob4=0;%智能体2被FDI攻击概率
DoS_prob4=0;%智能体2被DoS攻击概率

FDI_a1=rand(1,NUM);
DoS_b1=rand(1,NUM);
FDI_a2=rand(1,NUM);
DoS_b2=rand(1,NUM);
FDI_a3=rand(1,NUM);
DoS_b3=rand(1,NUM);
FDI_a4=rand(1,NUM);
DoS_b4=rand(1,NUM);
%生成攻击节点
for ii=1:NUM

    %产生智能体2-FDI攻击节点
    if FDI_a1(ii)<FDI_prob1
        FDI_a1(ii)=1;
    else
        FDI_a1(ii)=-1;
    end

    %产生智能体2-DoS攻击节点
    if DoS_b1(ii)<DoS_prob1
        DoS_b1(ii)=1;
    else
        DoS_b1(ii)=-1;
    end

    %产生智能体2-FDI攻击节点
    if FDI_a2(ii)<FDI_prob2
        FDI_a2(ii)=1;
    else
        FDI_a2(ii)=-1;
    end

    %产生智能体2-DoS攻击节点
    if DoS_b2(ii)<DoS_prob2
        DoS_b2(ii)=1;
    else
        DoS_b2(ii)=-1;
    end

    %产生智能体3-FDI攻击节点
    if FDI_a3(ii)<FDI_prob3
        FDI_a3(ii)=1;
    else
        FDI_a3(ii)=-1;
    end

    %产生智能体3-DoS攻击节点
    if DoS_b3(ii)<DoS_prob3
        DoS_b3(ii)=1;
    else
        DoS_b3(ii)=-1;
    end

    %产生智能体3-FDI攻击节点
    if FDI_a4(ii)<FDI_prob4
        FDI_a4(ii)=1;
    else
        FDI_a4(ii)=-1;
    end

    %产生智能体3-DoS攻击节点
    if DoS_b4(ii)<DoS_prob4
        DoS_b4(ii)=1;
    else
        DoS_b4(ii)=-1;
    end
end

% % attack_point=xlsread('Noise2_FDI_point.xlsx');
% attack_point=xlsread('Noise2_DoS_point.xlsx');
% % attack_point=xlsread('Noise2_Mixed_point.xlsx');
% % FDI_a2=attack_point(1,:);
% DoS_b2=attack_point(2,:);
% % FDI_a3=attack_point(3,:);
% DoS_b3=attack_point(4,:);