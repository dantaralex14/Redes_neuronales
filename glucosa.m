P = [40 50 60 70 80 90 100 110 120 130];
P_norm = (P - min(P)) / (max(P) - min(P)); 
X = [0 0 0 0 0 1 1 1 1 1]; 

redp = newff(minmax(P_norm), 1, {'logsig'}, 'trainlm');

redp.trainParam.epochs = 500;
redp.trainParam.goal = 0.001;

redp = train(redp, P_norm, X);

y = sim(redp, P_norm);

% y = y * (max(P) - min(P)) + min(P);

disp('Pesos:');
disp(redp.IW{1});
disp('Bias:');
disp(redp.b{1});
disp('Salida de la red:');
disp(y);

disp('Clasificación:');
for i = 1:length(y)
    if y(i) >= 0.5
        fprintf('Glucosa: %d -> Diabético\n', P(i));
    else
        fprintf('Glucosa: %d -> No Diabético\n', P(i));
    end
end
