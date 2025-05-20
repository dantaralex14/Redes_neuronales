% 1. Cargar los datos de las señales (simulación con datos aleatorios)
signal1 = rand(1, 10000); % Placeholder para tus datos reales
signal2 = rand(1, 10000);
signal3 = rand(1, 10000);
signal4 = rand(1, 10000);
signal5 = rand(1, 10000);
signal6 = rand(1, 10000);
signal7 = rand(1, 10000);
signal8 = rand(1, 10000);
signal9 = rand(1, 10000);

% 2. Preparar las señales para entrenar la red
X = [signal1; signal2; signal3; signal4; signal5; signal6; signal7; signal8; signal9]';

% Verificar dimensiones de X
disp('Dimensiones de las entradas X:');
disp(size(X));  % Mostrar las dimensiones de X

% 3. Generar los targets (codificación one-hot)
numSamples = size(X, 1);  % Número de muestras
T = zeros(numSamples, 9);  % Inicializar la matriz de targets

for i = 1:numSamples
    classIndex = ceil(i / (numSamples / 9));  % Determina la clase para la muestra
    T(i, classIndex) = 1;  % Asigna 1 en la clase correspondiente
end

% Verificar dimensiones de T
disp('Dimensiones de los targets T:');
disp(size(T));  % Mostrar las dimensiones de T

% 4. Crear la red neuronal multicapa
hiddenLayerSize = 10;  % Número de neuronas en la capa oculta
net = feedforwardnet(hiddenLayerSize);

% Configurar la función de activación de la capa de salida
net.layers{end}.transferFcn = 'softmax';

% 5. Configurar los parámetros de división de datos
net.divideParam.trainRatio = 0.7;  % 70% para entrenamiento
net.divideParam.valRatio = 0.15;   % 15% para validación
net.divideParam.testRatio = 0.15;  % 15% para prueba

% 6. Entrenar la red
[net, tr] = train(net, X', T');  % Nota: Transponer X y T para que las dimensiones coincidan

% 7. Probar la red
Y = net(X');  % Salidas predichas
[~, Y_class] = max(Y);  % Obtener la clase predicha (índice de la máxima salida)
performance = perform(net, T', Y);  % Calcular el rendimiento de la red

% 8. Graficar los resultados
figure;
plotperform(tr);  % Gráfica del rendimiento durante el entrenamiento

figure;
plotconfusion(T', Y);  % Matriz de confusión para ver la clasificación

figure;
plotroc(T', Y);  % Curva ROC para ver el rendimiento

% 9. Guardar el modelo entrenado y los resultados
save('modelo_red_neuronal.mat', 'net');

% 10. Mostrar el diagrama de la red neuronal
figure;
view(net);  % Diagrama de la red neuronal
title('Diagrama de la Red Neuronal');
