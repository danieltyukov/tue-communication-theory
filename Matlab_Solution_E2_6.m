%% Q function evaluations
% This is supporting material for explanation of 2.6

%% Quantization 
q1 = -1.75;
q2 = -1.25;
q3 = -0.75;
q4 = -0.25;

%% Probabilities 
p1 = qfunc(1.5);
p2 = qfunc(1)-qfunc(1.5);
p3 = qfunc(0.5)-qfunc(1);
p4 = qfunc(0)-qfunc(0.5);

%% Exponentials needed 
e = exp(1);
e1 = e^(-1*1.5^2/2);
e2 = e^(-1/2);
e3 = e^(-1*0.5^2/2);
e4 = e^0;

%% Constant required
cte = sqrt(2*pi);

%% E2.6 (a)
EU2  = 1;                                        
EQ2  = 2*(q1^2*p1+q2^2*p2+q3^2*p3+q4^2*p4);
EQU  = 2*(-1*q1*e1-1*q2*(e2-e1)-1*q3*(e3-e2)-1*q4*(e4-e3))/cte;
ED2  = EU2 + EQ2-2*EQU;

%% E2.6 (b)
ELa = 3*2*(p1+p2+p3+p4);      % Expected length representation 1
ELb = 2*(4*p1+4*p2+3*p3+2*p4);% Expected length representation 2