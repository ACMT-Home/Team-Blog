function [c, Pc] = CII(a, b, Pa, Pb)
%实现两估计量的融合；a，b是Num个时刻下的估计量
%Pa，Pb是估计量的协方差阵，函数返回融合后的估计
%量c以及协方差阵Pc

    aa = a;
    bb = b;
    paa=Pa;
    pbb= Pb;
    options = optimoptions('fmincon','Algorithm','interior-point','Display','off');
    w = fmincon(@myfun,0.5,[],[],[],[],0,1,[],options);
  % w=0.999;
    Pc = inv(w*inv(paa)+(1-w)*inv(pbb))   ;
    c = Pc*(w*inv(paa)*aa+(1-w)*inv(pbb)*bb);
