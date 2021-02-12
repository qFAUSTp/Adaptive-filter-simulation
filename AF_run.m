function AF_run(SimTime)
%The function starts simulation of the adaptive filter with the specified parameters.
%SimTime - simulation time (amount of {0;1} in pseudo-random sequences). (10000)
%OrdFilter - FIR filter order. (300)

global OrdFilter flag Signal
OrdFilter = 300;

%Filter and memory pre-cleaning.
AF_clear();

%--------Stage 1--------
%generating GMSK signal.
%-----------------------
sim('GMSK', SimTime);
disp(OutGMSK);
[n,m] = size(OutGMSK.Data);
k = 1;
Z(n*m)=0;
for i=1:n
    for j=1:m
        Z(k) = OutGMSK.Data(i,j);
        k = k+1;
    end;
end;

Z = Z/max(Z);
Signal = Z;

%-----------------------
%Z(k) - output dataset.
%-----------------------

%--------Stage 2--------
%FIR filter simulation and adaptation of its gain coefficients.
%-----------------------
y = 0;
flag = 0;
for i = 1:length(Z)
    y_1 = y;
    y = Filter(Z(i));
    if (i>1)
        Adaptation(y,y_1);
    end;
    
    if (mod(i,1000)==0)
        flag = flag+1;
        Evaluation();
    end;
    
end;

close(figure(1));
disp(strcat('//Done!//  ', num2str(datestr(clock, 13))));