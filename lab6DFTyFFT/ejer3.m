clear all, close all
[x fs]=audioread('vozam1.wav');
N=64;
X=fft(x, N);
X= abs(X);
k= N/2;
X=X(1:k);
