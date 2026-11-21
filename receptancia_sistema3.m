% Programa para frecuencias naturales
% y formas modales de sistemas de multiples
% grados de libertad de parametros concentrados
% y estimacion de la receptancia
% Sergio Rojas 2026_10_29
% Adaptado al sistema 3 de la tarea 8 (3 GDL)
clc, clear, close all
% Definir el sistema vibratorio
k1=3000; k2=5000; k3=17000; k4=10000; k5=2000;
m1=10; m2=15; m3=5;
disp("Matriz de masa")
M=diag([m1 m2 m3])
disp("Matriz de rigidez")
K=[k1+k2+k3  -k3     0;
   -k3       k3+k4  -k4;
   0        -k4      k4+k5]
%Valores y vectores caracteristicos
[vec,val]=eig(M\K);
[lambda,orden]=sort(diag(val));
vec=vec(:,orden);
disp("Vectores caracteristicos (cada columna es un modo, x1=1)")
vec=vec./vec(1,:)
disp("frecuencias naturales (rad/s)")
fn=sqrt(lambda)
% Estimacion de la receptancia
w=0:0.1:200;
n=size(M,1);
for j=1:length(w)
    Re(:,:,j)=inv(-w(j).^2*M+K);
end
% Graficas de receptancia: fila a = respuesta, columna b = fuerza
figure('Position',[50 50 850 700])
for a=1:n
    for b=1:n
        subplot(n,n,(a-1)*n+b)
        semilogy(w,abs(squeeze(Re(a,b,:))))
        grid on, xlim([0 200]), ylim([1e-12 10])
        yticks([1e-10 1e-5 1])
        title(sprintf('R_{%d%d}',a,b))
        if a==n, xlabel('\omega (rad/s)'), end
        if b==1, ylabel('|R| (m/N)'), end
    end
end
