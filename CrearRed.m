clear all; close all;

P = -1:.1:1;
T = [-.9602 -.5770 -.0729  .3771  .6405  .6600  .4609 ...
      .1336 -.2013 -.4344 -.5000 -.3930 -.1647  .0988 ...
      .3072  .3960  .3449  .1816 -.0312 -.2189 -.3201];
  
load entradas_ideales;
dato_entrada = entradas;
load salidas_ideales;
dato_salida = salidas;

ecm_eg = 0.001; % error cuadratico medio deseado
varianza_sc = 0.5; % varianza de las funciones RBF
neuronas = 10; % máximo número de neuronas
df = 30; % número de épocas máximo

% Creación y entrenamiento de la red
net1 = newrb(dato_entrada, dato_salida, ecm_eg, varianza_sc, neuronas, df);

% Simulación
Y = sim(net1, P);

% Visualización de resultados
plot(P, T, '+'); hold on;
plot(P, Y, '-r'); hold off;
title('Vectores de entrenamiento');
xlabel('Vector de entrada P');
ylabel('Vector Target T');
