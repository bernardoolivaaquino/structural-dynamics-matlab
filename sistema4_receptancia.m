% Programa para frecuencias naturales, formas modales
% y estimación de la receptancia para el SISTEMA 4 (5 GDL)
% Adaptado del código del Mtro. Sergio Rojas (30 de octubre)
% Alumno: Bernardo Oliva Aquino (Matrícula: 8837)
clc, clear, close all

% 1. Definición del sistema vibratorio
matricula = 8837;
k1 = 3000; k2 = 5000; k3 = 17000; k4 = 10000; k5 = 2000;
k6 = matricula;        
k7 = 2 * matricula;    

m1 = 10; m2 = 15; m3 = 5; m4 = 3; 
m5 = matricula / 1000; 

disp("Matriz de masa M:")
M = diag([m1, m2, m3, m4, m5])

disp("Matriz de rigidez K:")
K = [k1+k2, -k2,     0,           0,           0; 
     -k2,    k2+k3, -k3,          0,           0; 
      0,    -k3,     k3+k5+k7,   -k5,         -k7; 
      0,     0,     -k5,          k4+k5+k6,   -k6; 
      0,     0,     -k7,         -k6,          k6+k7]

% 2. Valores y vectores característicos
[vec, val] = eig(inv(M)*K);

% Ordenar frecuencias y modos
[val_diag, idx] = sort(diag(val));
vec = vec(:, idx);

% Normalización respecto al primer grado de libertad
vec_norm = zeros(5,5);
for i = 1:5
    vec_norm(:,i) = vec(:,i) / vec(1,i);
end
disp("Vectores característicos (Formas modales normalizadas al 1er GDL):")
disp(vec_norm)

disp("Frecuencias naturales (rad/s):")
fn = sqrt(val_diag)

disp("Frecuencias naturales (Hz):")
fn_hz = fn / (2*pi)

% 3. Estimación de Rigidez Dinámica y Receptancia
% Rango de frecuencia para capturar las 5 frecuencias (hasta ~95.12 rad/s)
w = 0:0.1:130; 
Re = zeros(5, 5, length(w));

for j = 1:length(w)
    Re(:,:,j) = inv(-w(j)^2 * M + K);
end

% 4. Graficación de todas las receptancias posibles (Matriz 5x5 = 25 gráficas)
figure('Name', 'Receptancias Sistema 4 (5 GDL)', 'Color', 'w', 'Position', [30, 30, 1400, 1000]);
N = 5;
for i = 1:N
    for k = 1:N
        subplot(N, N, (i-1)*N + k);
        re_ik = squeeze(Re(i, k, :));
        if i == k
            semilogy(w, abs(re_ik), 'b', 'LineWidth', 1.1);
            title(sprintf('\\alpha_{%d%d} (Dir)', i, k), 'Color', [0 0.3 0.8], 'FontSize', 7, 'FontWeight', 'bold');
        else
            semilogy(w, abs(re_ik), 'r', 'LineWidth', 0.9);
            title(sprintf('\\alpha_{%d%d}', i, k), 'Color', [0.8 0.1 0.1], 'FontSize', 7);
        end
        grid on;
        xlim([0 130]);
        if i == N
            xlabel('\omega', 'FontSize', 6);
        else
            set(gca, 'XTickLabel', []);
        end
        if k == 1
            ylabel(sprintf('|\\alpha_{%d%d}|', i, k), 'FontSize', 6);
        end
    end
end
sgtitle('Sistema 4 (5 GDL) - Matriz Completa de Receptancias (25 Gráficas)', 'FontWeight', 'bold', 'FontSize', 14);
