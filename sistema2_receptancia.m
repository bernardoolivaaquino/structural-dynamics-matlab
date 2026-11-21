% Programa para frecuencias naturales, formas modales
% y estimación de la receptancia para el SISTEMA 2 (4 GDL)
% Adaptado del código del Mtro. Sergio Rojas (30 de octubre)
% Alumno: Bernardo Oliva Aquino
clc, clear, close all

% 1. Definición del sistema vibratorio
k1 = 3000; k2 = 5000; k3 = 17000; k4 = 10000; k5 = 2000;
m1 = 10; m2 = 15; m3 = 5; m4 = 3;

disp("Matriz de masa M:")
M = diag([m1, m2, m3, m4])

disp("Matriz de rigidez K:")
K = [k1+k2, -k2,     0,     0; 
     -k2,    k2+k3,  0,    -k3; 
      0,     0,      k4+k5,-k5; 
      0,    -k3,    -k5,    k3+k5]

% 2. Valores y vectores característicos
[vec, val] = eig(inv(M)*K);

% Ordenar frecuencias y modos
[val_diag, idx] = sort(diag(val));
vec = vec(:, idx);

% Normalización respecto al primer grado de libertad
vec_norm = zeros(4,4);
for i = 1:4
    vec_norm(:,i) = vec(:,i) / vec(1,i);
end
disp("Vectores característicos (Formas modales normalizadas al 1er GDL):")
disp(vec_norm)

disp("Frecuencias naturales (rad/s):")
fn = sqrt(val_diag)

disp("Frecuencias naturales (Hz):")
fn_hz = fn / (2*pi)

% 3. Estimación de Rigidez Dinámica y Receptancia
% Rango de frecuencia para capturar las 4 frecuencias (12.28, 31.78, 48.76 y 86.38 rad/s)
w = 0:0.1:110; 
Re = zeros(4, 4, length(w));

for j = 1:length(w)
    Re(:,:,j) = inv(-w(j)^2 * M + K);
end

% 4. Graficación de todas las receptancias posibles (Matriz 4x4 = 16 gráficas)
figure('Name', 'Receptancias Sistema 2 (4 GDL)', 'Color', 'w', 'Position', [50, 50, 1200, 900]);
N = 4;
for i = 1:N
    for k = 1:N
        subplot(N, N, (i-1)*N + k);
        re_ik = squeeze(Re(i, k, :));
        if i == k
            semilogy(w, abs(re_ik), 'b', 'LineWidth', 1.2);
            title(sprintf('\\alpha_{%d%d} (Directa)', i, k), 'Color', [0 0.3 0.8], 'FontSize', 8, 'FontWeight', 'bold');
        else
            semilogy(w, abs(re_ik), 'r', 'LineWidth', 1.0);
            title(sprintf('\\alpha_{%d%d} (Cruzada)', i, k), 'Color', [0.8 0.1 0.1], 'FontSize', 8);
        end
        grid on;
        xlim([0 110]);
        if i == N
            xlabel('\omega (rad/s)', 'FontSize', 7);
        else
            set(gca, 'XTickLabel', []);
        end
        if k == 1
            ylabel(sprintf('|\\alpha_{%d%d}|', i, k), 'FontSize', 7);
        end
    end
end
sgtitle('Sistema 2 (4 GDL) - Matriz Completa de Receptancias (16 Gráficas)', 'FontWeight', 'bold', 'FontSize', 13);
