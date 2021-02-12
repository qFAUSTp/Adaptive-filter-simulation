function Evaluation()
%--------Stage 3--------
%Estimating the impulse response of an FIR system.
%----------------------

global OrdFilter X flag Signal

X_SAVE = X;
for i = 1:(OrdFilter+1)
    X(i) = 0;
end;

for j=1:(OrdFilter+1)
    if j == 1
        z = 1+1*i;
    else
        z = 0+0*i;
    end;
        H(j) = Filter(z);
end;
X = X_SAVE;

%-----------Scale calibration-------
S_filt = abs(fftshift(fft(real(H))));
F_filt = 0:OrdFilter;
%Normalization to 2*pi
F_filt = 2*pi*F_filt/(OrdFilter+1);
N_filt = max(S_filt);

S_sign = abs(fftshift(fft(real(real(Signal)))));
F_sign = 1:length(S_sign);
%Normalization to 2*pi
F_sign = 2*pi*F_sign/(length(S_sign));
N_sign = max(S_sign);
%m = length(Signal)/length(F);
K = 200;
%-------------------------------------

Fig = figure(1);
xlim([-pi pi]);
hold on;
xlabel('\omega'); 
ylabel('Blue - A_s, Red - H_f');  
plot(F_sign-pi,S_sign/N_sign,'color','blue'),grid on;
plot(F_filt-pi,S_filt/N_filt,'color','red');
%plot(abs(fft(imag(H))),'color','blue');

%hold on;
%plot(real(fft(real(H))),'color','blue'),grid on;
%plot(imag(fft(imag(H))),'color','green');

file_name = strcat('Results\fig_', num2str(flag));
saveas(Fig, file_name , 'bmp');
disp(strcat('Saved Fig_', num2str(flag)));
clf(Fig);

