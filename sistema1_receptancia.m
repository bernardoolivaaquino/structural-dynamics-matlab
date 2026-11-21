% Programa para frecuencias naturales, formas modales
% y estimación de la receptancia para el SISTEMA 1 (2 GDL)
% Adaptado del código del Mtro. Sergio Rojas (30 de octubre)
% Alumno: Bernardo Oliva Aquino
clc, clear, close all

% 1. Definición del sistema vibratorio
m1 = 10;
m2 = 15;
k1 = 3000;
k2 = 5000;
k3 = 17000;

disp("Matriz de masa M:")
M = [m1 0; 0 m2]

disp("Matriz de rigidez K:")
K = [k1+k2 -k2; -k2 k2+k3]

% 2. Valores y vectores característicos
[vec, val] = eig(inv(M)*K);

% Ordenar frecuencias y modos
[val_diag, idx] = sort(diag(val));
vec = vec(:, idx);

disp("Vectores característicos (Formas modales normalizadas al 1er GDL):")
vec = [vec(:,1)/vec(1,1), vec(:,2)/vec(1,2)]

disp("Frecuencias naturales (rad/s):")
fn = sqrt(val_diag)

disp("Frecuencias naturales (Hz):")
fn_hz = fn / (2*pi)

% 3. Estimación de Rigidez Dinámica y Receptancia
% Rango de frecuencia para capturar las frecuencias naturales (24.62 y 40.75 rad/s)
w = 0:0.1:60; 
Re = zeros(2, 2, length(w));

for j = 1:length(w)
    Re(:,:,j) = inv(-w(j)^2 * M + K);
end

% Extracción de receptancias individuales
for j = 1:length(w)
    Re11(j) = Re(1,1,j);
    Re12(j) = Re(1,2,j);
    Re21(j) = Re(2,1,j);
    Re22(j) = Re(2,2,j);
end

% 4. Graficación de todas las receptancias posibles (2x2)
figure('Name', 'Receptancias Sistema 1 (2 GDL)', 'Color', 'w', 'Position', [100, 100, 850, 650]);

subplot(2,2,1)
semilogy(w, abs(Re11), 'b', 'LineWidth', 1.5)
grid on
title('Receptancia Directa \alpha_{11}(\omega)', 'FontSize', 11)
xlabel('\omega (rad/s)', 'FontSize', 10)
ylabel('|\alpha_{11}| (m/N)', 'FontSize', 10)

subplot(2,2,2)
semilogy(w, abs(Re12), 'r', 'LineWidth', 1.5)
grid on
title('Receptancia Cruzada \alpha_{12}(\omega)', 'FontSize', 11)
xlabel('\omega (rad/s)', 'FontSize', 10)
ylabel('|\alpha_{12}| (m/N)', 'FontSize', 10)

subplot(2,2,3)
semilogy(w, abs(Re21), 'r', 'LineWidth', 1.5)
grid on
title('Receptancia Cruzada \alpha_{21}(\omega)', 'FontSize', 11)
xlabel('\omega (rad/s)', 'FontSize', 10)
ylabel('|\alpha_{21}| (m/N)', 'FontSize', 10)

subplot(2,2,4)
semilogy(w, abs(Re22), 'b', 'LineWidth', 1.5)
grid on
title('Receptancia Directa \alpha_{22}(\omega)', 'FontSize', 11)
xlabel('\omega (rad/s)', 'FontSize', 10)
ylabel('|\alpha_{22}| (m/N)', 'FontSize', 10)

sgtitle('Sistema 1 (2 GDL) - Matriz Completa de Receptancias [\alpha_{ij}(\omega)]', 'FontWeight', 'bold', 'FontSize', 13);
