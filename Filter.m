function [y] = Filter(z)
%This function simulates an FIR system in real time.
%z - complex value at the filter input.
%y - complex value at the filter output.
%X - vector of intermediate values.

global OrdFilter X B

for i = (OrdFilter+1):-1:2
    X(i) = X(i-1);
end

X(1) = z;

y = 0;
for i = 1:(OrdFilter+1)
    y = y + B(i)*X(i);
end;