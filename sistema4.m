%frecuencias naturales y formas modales del sistema 4 (5 GDL)

clc, clear, close all

%definir parametros del sistema vibratorio
matricula=8837;
k1=3000; k2=5000; k3=17000; k4=10000; k5=2000;
k6=matricula; k7=2*matricula;
m1=10; m2=15; m3=5; m4=3; m5=matricula/1000;

disp("matriz de masa")
M=diag([m1 m2 m3 m4 m5])
disp("matriz de rigidez")
K=[k1+k2  -k2     0         0         0;
   -k2    k2+k3  -k3        0         0;
   0     -k3      k3+k5+k7 -k5       -k7;
   0      0      -k5        k4+k5+k6 -k6;
   0      0      -k7       -k6        k6+k7]

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
