num_signals = 9; 
matriz_entrenamiento = {}; 
matriz_targets = [];  
max_periodos_por_senal = 10;  
max_longitud_periodo = 500;  

for n = 1:num_signals
    signal_name = sprintf('signal%d', n);
    senal = eval(signal_name); 
    umbral = mean(senal) + std(senal);  
    loc_R = [];  
    for i = 2:length(senal)-1
        if senal(i) > senal(i-1) && senal(i) > senal(i+1) && senal(i) > umbral
            loc_R = [loc_R; i]; 
        end
    end
    count_periodos = 0;  
    for i = 2:length(loc_R) 
        if count_periodos >= max_periodos_por_senal
            break; 
        end
        inicio = loc_R(i-1);  
        fin = loc_R(i); 
        periodo = senal(inicio:fin);
        if length(periodo) > max_longitud_periodo
            periodo = periodo(1:max_longitud_periodo);  
        end
        matriz_entrenamiento{end+1} = periodo; 
        matriz_targets = [matriz_targets; n];  
        count_periodos = count_periodos + 1;  
    end
end

longitud_maxima = max(cellfun(@length, matriz_entrenamiento));
for i = 1:length(matriz_entrenamiento)
    periodo = matriz_entrenamiento{i};
    matriz_entrenamiento{i} = [periodo, zeros(1, longitud_maxima - length(periodo))];
end

matriz_entrenamiento_ajustada = cell2mat(matriz_entrenamiento);