function Adaptation(y,y_1)
%The function is designed to rebuild the coefficients of the FIR system. 
%d - adaptation coefficient.
%h - modulation index.
global OrdFilter X B 

h = 0.5; d = 1e-6;

phi = atan(imag(y)/real(y));
phi_1 = atan(imag(y_1)/real(y_1));
G = 2*pi*h*(phi - phi_1);
for i = 1:(OrdFilter+1)
    B(i) = B(i) - d*(abs(y-y_1) - G)*y*conj(X(i));
end;