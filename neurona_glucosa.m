P = [40 45 50 55 60 65 70 75 80 85 90 95 100 105 110 115 120 125 130 135 ...
     140 145 150 155 160 165 170 175 180 185 190 195 200 205 210 215 220 225 230 235]; 
X = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ...  
     1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];  

P_norm = (P - min(P)) / (max(P) - min(P));
redp = feedforwardnet(1); 
redp.trainParam.epochs = 500;
redp.trainParam.goal = 0.001;
redp = train(redp, P_norm, X);

disp('Pesos:');
disp(redp.IW{1});
disp('Bias:');
disp(redp.b{1});

y = sim(redp, P_norm);
umbral = 0.5;
y_umbral = y >= umbral;

disp('Clasificación de los valores de glucosa:');
for i = 1:length(y)
    if y_umbral(i)
        fprintf('Glucosa: %d -> Diabético\n', P(i));
    else
        fprintf('Glucosa: %d -> No Diabético\n', P(i));
    end
end

disp('Resultados de la red:');
disp(y);

disp('Resultados umbral:');
disp(y_umbral);

% Esto fue opcional,se lo agregue para la visualización de resultados
figure;
plot(P_norm, X, 'ro', 'MarkerFaceColor', 'r');  
hold on;
plot(P_norm, y, 'b*');  
xlabel('Valores de Glucosa (normalizados)');
ylabel('Salida de la red');
title('Clasificación de Diabetes');
legend('Etiquetas Reales', 'Salida de la Red');
hold off;

