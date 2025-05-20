clear all; close all;

load entradasd_5m.mat;
dato_entrada = entradas;
load salidas_ideales.mat;
dato_salida = salidas;

ecm_eg = 0.000001; % error cuadrático medio deseado
varianza_sc = 0.5; % varianza de las funciones RBF
neuronas = 10; % máximo número de neuronas
df = 30; % número máximo de épocas

% Creación y entrenamiento de la red
net1 = newrb(dato_entrada, dato_salida, ecm_eg, varianza_sc, neuronas, df);

% Definición de los datos de entrada para simulación
P = -1:0.1:1; % Define el rango de entrada

% Simulación
Y = sim(net1, P);

% Visualización de resultados
plot(P, T, '+'); hold on;
plot(P, Y, '-r'); hold off;
title('Vectores de entrenamiento');
xlabel('Vector de entrada P');
ylabel('Vector Target T');
