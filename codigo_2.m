% Programa para analizar vibraciones desde excel
% NOMBRE    2026-09-17

%lectura de datos, c1 tiempo, c2 aceleracion

datos=xlsread('Dato exportado 19.xlsx');

%definicion de parámetros 
Fs=40;   % Cantidad de datos por segundo
dt=1/Fs;   % Delta de tiempo entre mediciones
[N,~]=size(datos); %Cantidad de mediciones
t=datos(:,1);% Vector de tiempo
fmax=1/dt; % Frecuencia máxima
df=Fs/N;   % Delta de frecuencia
f=(0:df:fmax-df); %Vector de frecuencia
% Definición de la señal a analizar

xt=datos(:,2);
subplot(2,1,1),plot(t,xt)
title('Señal en el dominio del timepo')
xlabel('Tiempo (s)')
ylabel('Aceleración (m/s^2')
% Transformada de Fourier
xf=2/length(xt)*abs(fft(xt));
subplot(2,1,2),plot(f,xf)
title('Transformada de Fourier')
xlabel('Frecuencia (Hz)')
ylabel('Aceleración m/s^2')