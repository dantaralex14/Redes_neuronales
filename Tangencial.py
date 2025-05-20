import numpy as np
import matplotlib.pyplot as plt

# Definir los valores de x
x_values = np.linspace(-3, 3, 100)

# Definir el umbral (theta)
theta = 0

# Calcular la salida de la función umbral
y_threshold = [1 if x >= theta else 0 for x in x_values]

# Calcular la función sigmoidal
y_sigmoid = 1 / (1 + np.exp(-x_values))

# Calcular la función tangente hiperbólica
y_tanh = np.tanh(x_values)

# Gráfico de la función umbral
plt.figure(figsize=(8, 6))
plt.plot(x_values, y_threshold, label='Función Umbral', color='blue', linestyle='--', marker='o')
plt.title('Función de Activación Umbral')
plt.xlabel('x')
plt.ylabel('f(x)')
plt.grid(True)
plt.axhline(0, color='black', linewidth=0.5)
plt.axvline(0, color='black', linewidth=0.5)
plt.ylim(-0.1, 1.1)
plt.legend()
plt.show()

# Gráfico de la función sigmoidal
plt.figure(figsize=(8, 6))
plt.plot(x_values, y_sigmoid, label='Función Sigmoidal', color='green')
plt.title('Función de Activación Sigmoidal')
plt.xlabel('x')
plt.ylabel('f(x)')
plt.grid(True)
plt.axhline(0, color='black', linewidth=0.5)
plt.axvline(0, color='black', linewidth=0.5)
plt.ylim(-0.1, 1.1)
plt.legend()
plt.show()

# Gráfico de la función tangente hiperbólica
plt.figure(figsize=(8, 6))
plt.plot(x_values, y_tanh, label='Función Tangente Hiperbólica', color='red')
plt.title('Función de Activación Tangente Hiperbólica')
plt.xlabel('x')
plt.ylabel('f(x)')
plt.grid(True)
plt.axhline(0, color='black', linewidth=0.5)
plt.axvline(0, color='black', linewidth=0.5)
plt.ylim(-1.1, 1.1)
plt.legend()
plt.show()
