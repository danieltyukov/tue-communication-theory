import numpy as np
import matplotlib.pyplot as plt

# Define the 8-PSK symbols
angles = np.arange(0, 2 * np.pi, np.pi / 4)  # 8 angles
symbols = np.exp(1j * angles)  # 8-PSK symbols in polar form

# Extract real and imaginary parts for plotting
x = np.real(symbols)
y = np.imag(symbols)

# Plot the constellation points
plt.figure(figsize=(8, 8))
plt.scatter(x, y, color='blue', label='8-PSK Symbols')
for i, (xi, yi) in enumerate(zip(x, y)):
    plt.text(xi * 1.1, yi * 1.1, f'S{i+1}', fontsize=12, ha='center')

# Add decision region lines
for angle in angles:
    plt.plot([0, np.cos(angle + np.pi / 8)], [0, np.sin(angle + np.pi / 8)], linestyle='--', color='gray')

# Add axis and labels
plt.axhline(0, color='black', linewidth=0.8)
plt.axvline(0, color='black', linewidth=0.8)
plt.gca().set_aspect('equal', adjustable='box')
plt.title('8-PSK Constellation and Decision Regions')
plt.xlabel('In-phase Component')
plt.ylabel('Quadrature Component')
plt.grid(alpha=0.5)
plt.legend()
plt.show()
