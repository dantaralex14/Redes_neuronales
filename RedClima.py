import numpy as np
import pandas as pd
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import SimpleRNN, Dense
from tensorflow.keras.callbacks import EarlyStopping

early_stopping = EarlyStopping(monitor='loss', patience=3, restore_best_weights=True)

file_path = "max_planck_weather_ts.csv"
data = pd.read_csv(file_path)

data['Date Time'] = pd.to_datetime(data['Date Time'], format='%d.%m.%Y %H:%M:%S') 
data = data.sort_values(by='Date Time') 
values = data['T (degC)'].values 

values = (values - np.min(values)) / (np.max(values) - np.min(values))  

def generate_sequences(data, seq_length):
    sequences = []
    labels = []
    for i in range(len(data) - seq_length):
        sequences.append(data[i:i+seq_length])
        labels.append(data[i+seq_length])
    return np.array(sequences), np.array(labels)
seq_length = 10

x_train, y_train = generate_sequences(values, seq_length)
x_train = x_train.reshape((x_train.shape[0], x_train.shape[1], 1)) 

model = Sequential([
    SimpleRNN(10, activation='tanh', input_shape=(seq_length, 1)),  
    Dense(1)  
])
model.compile(optimizer='adam', loss='mse')
model.fit(x_train, y_train, epochs=20, batch_size=64, callbacks=[early_stopping])  

x_test = x_train[-1].reshape((1, seq_length, 1))  
prediction = model.predict(x_test)
print("Predicción para la próxima muestra:", prediction[0][0])