%frecuencias naturales y formas modales del sistema 1 (2 GDL)

clc, clear, close all

%definir parametros del sistema vibratorio
k1=3000; k2=5000; k3=17000;
m1=10; m2=15;

disp("matriz de masa")
M=diag([m1 m2])
disp("matriz de rigidez")
K=[k1+k2  -k2;
   -k2    k2+k3]

%valores y vectores caracteristicos
[vec,val]=eig(M\K);
[lambda,orden]=sort(diag(val));
vec=vec(:,orden);

disp("frecuencias naturales en (rad/s)")
wn=sqrt(lambda)
disp("frecuencias naturales en (Hz)")
fn=wn/(2*pi)
disp("formas modales (cada columna es un modo, x1=1)")
modos=vec./vec(1,:)
