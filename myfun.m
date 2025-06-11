function f = myfun(w)
% f = -x(1) * x(2) * x(3);
 global paa;
 global pbb;
f = trace(inv(w*inv(paa)+(1-w)*inv(pbb)));