

Seni seviyorummmmmm dediiiiiim

%%
clear all
load asset1.mat
t = 1: 1000;
figure, plot(asset);
asset_return = diff(asset(6166:end));
figure, plot(asset_return);
figure, plot(abs(fft(asset_return)))
win_size = 50;
asset_return = sin(t*pi*10/2/180);
Fs = 1/24/60/60;
Fs = pi/2/180/2/pi;
T = 1/Fs;
L = length(asset_return);
t = (0:L-1)*T;

Y = fft(asset_return);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
ffty = fft(asset_return);
ffty = abs(ffty(1:ceil(length(asset_return)/2)));

f = Fs*(0:(L/2))/L;
figure,
plot(f,P1)
plot(P1)
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f(Hz)')
ylabel('|P1(f)|')
spectrogram(asset_return, 'yaxis')
clear mag_matrix
%%
for i = 1 : length(asset_return)
    if (i+win_size<length(asset_return))
        asset_vec = asset_return(i:i+win_size);
    else asset_vec = asset_return(i:end);
    end
    clear Y
    ffty = fftshift(asset_vec);
    ffty = abs(ffty(1:ceil(length(asset_vec)/2)));
    %         Y = fft(asset_vec);
    L = length(asset_vec);
%     figure, plot(abs(asset_vec))
    %         P2 = abs(Y/L);
    %         P1 = P2(1:L/2+1);
    %         P1(2:end-1) = 2*P1(2:end-1);
    %         f = Fs*(0:(L/2))/L;
    %     figure,
    %     plot(f,P1)
    %     title('Single-Sided Amplitude Spectrum of X(t)')
    %     xlabel('f (Hz)')
    %     ylabel('|P1(f)|')
    if (length(asset_vec) >= 2)
        mag_matrix(i,1) = abs(ffty(2));
    end
    
end
figure, plot(mag_matrix)
%%



ffty = fft(asset_return);
ffty = abs(ffty(1:ceil(length(asset_return)/2)));
ffty(ffty<100)=0;
[~,locs] = findpeaks(ffty);
freqs = (locs-1)/t(end)
signal_1 = sin(2*pi*t*freqs(1)) +sin(2*pi*t*freqs(2))+sin(2*pi*t*freqs(3)); % 3-10
signal_2 = sin(2*pi*t*freqs(6))+sin(2*pi*t*freqs(7)); % 50-100
subplot(211), plot(t,signal_1)
subplot(212), plot(t,signal_2)
