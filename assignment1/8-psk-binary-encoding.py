import numpy as np
import matplotlib.pyplot as plt

# Binary mapping
binary_labels = [
    "000", "001", "010", "011", "100", "101", "110", "111"
]

# Define 8-PSK symbols
angles = np.arange(0, 2 * np.pi, np.pi / 4)  # Angles for symbols
symbols = np.exp(1j * angles)  # Symbols on the unit circle

# Extract real and imaginary parts
x = np.real(symbols)
y = np.imag(symbols)

# Plot constellation
plt.figure(figsize=(8, 8))
plt.scatter(x, y, color='blue', label='8-PSK Symbols', zorder=5)
for i, (xi, yi, label) in enumerate(zip(x, y, binary_labels)):
    plt.text(xi * 1.2, yi * 1.2, label, fontsize=12, ha='center')

# Add unit circle
theta = np.linspace(0, 2 * np.pi, 500)
plt.plot(np.cos(theta), np.sin(theta), 'k--', label='Unit Circle')

# Axes and labels
plt.axhline(0, color='black', linewidth=0.8)
plt.axvline(0, color='black', linewidth=0.8)
plt.gca().set_aspect('equal', adjustable='box')
plt.title('8-PSK Constellation with Binary Mapping')
plt.xlabel('In-phase Component')
plt.ylabel('Quadrature Component')
plt.legend()
plt.grid(alpha=0.5)
plt.show()
