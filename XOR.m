P = [0 1 0 1; 0 0 1 1];
X = [0 1 1 0];

redp = newp([-0.1 1.1; -0.1 1.1], 1);

view(redp);

y = sim(redp, P);

redp.trainParam.epochs = 500;
redp.trainParam.goal = 0.001;
redp = train(redp, P, X);

pesos = redp.IW{1,1}; 
bias = redp.b{1};

disp('Cálculos intermedios para XOR:');
for i = 1:size(P, 2)
    entrada = P(:, i); 
    suma = pesos * entrada + bias; 
    disp(['Entrada ', num2str(i), ': ', num2str(entrada')]);
    disp(['Multiplicación por pesos: ', num2str(pesos * entrada)]);
    disp(['Suma con bias: ', num2str(suma)]);
    disp(['Salida después de la función de activación (hardlim): ', num2str(hardlim(suma))]);
    disp(' ');
end

y = sim(redp, P);

disp('Pesos finales:');
disp(pesos);
disp('Bias final:');
disp(bias);
disp('Salida final de la red:');
disp(y);
