import numpy as np
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import SimpleRNN, Dense

# Generar datos: una serie senoidal
def generate_sine_wave(seq_length, num_samples):
    x = np.linspace(0, 50, num_samples)
    y = np.sin(x)
    data = []
    labels = []
    for i in range(len(y) - seq_length):
        data.append(y[i:i+seq_length])
        labels.append(y[i+seq_length])
    return np.array(data), np.array(labels)

# Parámetros
seq_length = 10  # Longitud de la secuencia de entrada
num_samples = 500  # Total de muestras
x_train, y_train = generate_sine_wave(seq_length, num_samples)

# Reshape para que se adapte al modelo RNN
x_train = x_train.reshape((x_train.shape[0], x_train.shape[1], 1))  # (samples, timesteps, features)

# Construir el modelo RNN
model = Sequential([
    SimpleRNN(50, activation='tanh', input_shape=(seq_length, 1)),
    Dense(1)  # Capa de salida
])

model.compile(optimizer='adam', loss='mse')

# Entrenar el modelo
model.fit(x_train, y_train, epochs=20, batch_size=16)

# Predicción
x_test = np.sin(np.linspace(50, 60, seq_length)).reshape((1, seq_length, 1))  # Nueva secuencia
prediction = model.predict(x_test)
print("Predicción para la próxima muestra:", prediction[0][0])