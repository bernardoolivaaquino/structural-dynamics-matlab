%programa para calcular la FRF de un sistema 1 GDL
%Bernardo Oliva Aquino
clc,clear, close all
%definiciín del sistema vibratorio
m=10;
k=2500;
c=20;

%cálculo de la FRF
w=[0:.1:50]
Xf=(-m*w.^2+i*c*w+k).^-1;
fX=(-m*w.^2+1*c*w+k);

%gráfica
subplot(2,1,1),plot(w,abs(Xf))
xlabel('frecuencia (rad/s)')
ylabel('Receptancia (m/N)')
grid on
subplot(2,1,2),plot(w,abs(fX))
xlabel('frecuencia (rad/s)')
ylabel('Rigidez dinámica (N/m)')
grid on