function AF_clear()
%The function is designed to restore the filter coefficients to the initial state
%??and reset all results.

global OrdFilter X B
%Filter initialization
for i = 1:(OrdFilter+1)
    B(i) = 1+1*i;
end;

%Cleansing data from filter delays.
for i = 1:(OrdFilter+1)
    X(i) = 0;
end;

clear();

