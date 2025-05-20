% Supongamos que tienes un conjunto de señales en una celda
signals = {arri100, arri101, arri102, arri103, arri105, arri108, ...
           arri109, arri111, arri112, arri115, arri116, arri117, ...
           arri121, arri122, arri123, arri124, arri200, arri201, ...
           arri202, arri203, arri205, arri208, arri209, arri210, ...
           arri214, arri219, arri220, arri221, arri223, arri232, ...
           arri233, arri234}; % Reemplaza con tus señales
numSignals = length(signals);

% Inicializar una matriz para almacenar las coordenadas
data = [];

% Establecer un umbral para detectar picos
threshold = 0.5; % Ajusta este valor según sea necesario

for i = 1:numSignals
    signal = signals{i};
    
    % Detección de picos manual
    locs = []; % Inicializar el array de localizaciones de picos
    for j = 2:length(signal)-1
        if signal(j) > signal(j-1) && signal(j) > signal(j+1) && signal(j) > threshold
            locs = [locs; j]; % Guardar la posición del pico
        end
    end
    
    % Asegúrate de que hay al menos 5 picos para los puntos P, Q, R, S, T
    if length(locs) >= 5
        for j = 1:5 % Para P, Q, R, S, T
            data = [data; i, j, locs(j), signal(locs(j))]; % Registro, Punto, X, Y
        end
    else
        warning('No se encontraron suficientes picos en la señal %d', i);
    end
end

% Convertir a tabla
T = array2table(data, 'VariableNames', {'Registro', 'Punto', 'CoordenadaX', 'CoordenadaY'});

% Exportar a archivo Excel
writetable(T, 'coordenadas_ecg.xlsx');

