% Programa para ejemplificar la aplicación de la
% Transformada de Fourier
% NOMBRE    2026-09-XX
clc, clear, close all
% Parámetros para definir señales a analizar
Fs=1000;   % Cantidad de datos por segundo
dt=1/Fs;   % Delta de tiempo entre mediciones
N=2000;    % Cantidad de mediciones que necesito
t=(0:N)*dt;  % Vector de tiempo
fmax=1/dt; % Frecuencia máxima
df=Fs/N;   % Delta de frecuencia
f=(0:df:fmax); %Vector de frecuencia
% Definición de la señal a analizar
%frec=100;              % Frecuencia del armónico en Hz
%xt=sin(2*pi*frec*t);  % Definición del armónico
xt=zeros(size(t));
xt(1000)=10;
xt(1001)=10;
xt(1002)=10;
xt(1003)=10;
xt(1004)=10;
xt(1005)=10;
xt(1006)=10;
xt(1007)=10;
xt(1008)=10;
xt(1009)=10;
xt(1010)=10;
subplot(2,1,1),plot(t,xt)
% Transformada de Fourier
xf=abs(fft(xt));
subplot(2,1,2),plot(f,xf)