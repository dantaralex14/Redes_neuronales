% Generar datos serie senoidal
length_sec = 10
muestras = 500
x = linspace(0,50,muestras)
y = sin(x)

plot(y)

dato = [];
label = [];

for i=1:(length(y)-length_sec)
    data = [data; y(i:i+length_sec-1)];
    label = [label ; y(i+length_sec)];
end

