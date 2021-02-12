function AF_Main()
% Create a GMSK modulator, an AWGN channel, and a GMSK demodulator. Use a phase offset of pi/4.
    hMod = comm.GMSKModulator('BitInput', true, 'InitialPhaseOffset', pi/4);
    hAWGN = comm.AWGNChannel('NoiseMethod', ...
                    'Signal to noise ratio (SNR)','SNR',0);
    hDemod = comm.GMSKDemodulator('BitOutput', true, ...
                    'InitialPhaseOffset', pi/4);
% Create an error rate calculator, account for the delay caused by the Viterbi algorithm
    hError = comm.ErrorRate('ReceiveDelay', hDemod.TracebackDepth);
   hold on;
   A=0; B=0;
    for counter = 1:100
      % Transmit 100 3-bit words
      data = randi([0 1],300,1);
      modSignal = step(hMod, data);
      A = [modSignal, B];
      B = [modSignal, A];
      noisySignal = step(hAWGN, modSignal);
      receivedData = step(hDemod, noisySignal);
      errorStats = step(hError, data, receivedData);
    end
    fprintf('Error rate = %f\nNumber of errors = %d\n', ...
      errorStats(1), errorStats(2))
  plot(modSignal1);
   