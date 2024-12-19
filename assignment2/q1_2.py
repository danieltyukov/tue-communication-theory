import matplotlib.pyplot as plt

# Define signal points
s1 = (1, 0)
s2 = (1, (1/3)**0.5)
s3 = (-2, 0)
s4 = (-2, (1/3)**0.5)

# Calculate axis limits
x_min, x_max = min(s1[0], s2[0], s3[0], s4[0]), max(s1[0], s2[0], s3[0], s4[0])
y_min, y_max = min(s1[1], s2[1], s3[1], s4[1]), max(s1[1], s2[1], s3[1], s4[1])

# Determine center of axes
x_center = (x_min + x_max) / 2
y_center = (y_min + y_max) / 2

# Plot signal constellation points
plt.figure(figsize=(8, 8))
plt.scatter(*s1, color='red', label='s1 (1, 0)')
plt.scatter(*s2, color='blue', label='s2 (1, √(1/3))')
plt.scatter(*s3, color='green', label='s3 (-2, 0)')
plt.scatter(*s4, color='purple', label='s4 (-2, √(1/3))')

# Annotate points
plt.text(s1[0], s1[1] + 0.1, 's1', color='red', fontsize=12)
plt.text(s2[0], s2[1] + 0.1, 's2', color='blue', fontsize=12)
plt.text(s3[0], s3[1] + 0.1, 's3', color='green', fontsize=12)
plt.text(s4[0], s4[1] + 0.1, 's4', color='purple', fontsize=12)

# Define and annotate decision regions
plt.text((x_center + x_max) / 2, (y_center + y_max) / 2, 'I1', color='black', fontsize=14)
plt.text((x_center + x_min) / 2, (y_center + y_max) / 2, 'I2', color='black', fontsize=14)
plt.text((x_center + x_min) / 2, (y_center + y_min) / 2, 'I3', color='black', fontsize=14)
plt.text((x_center + x_max) / 2, (y_center + y_min) / 2, 'I4', color='black', fontsize=14)

# Add gridlines and centered axes
plt.axhline(y=y_center, color='black', linewidth=0.5, linestyle='--')
plt.axvline(x=x_center, color='black', linewidth=0.5, linestyle='--')

# Formatting the plot
plt.xlim(x_min - 1, x_max + 1)
plt.ylim(y_min - 0.5, y_max + 0.5)
plt.xticks([])  # Hide x ticks
plt.yticks([])  # Hide y ticks
plt.grid(True, linestyle='--', alpha=0.7)
plt.title("Signal Constellation Diagram", fontsize=14)
plt.xlabel("φ1 Axis", fontsize=12)
plt.ylabel("φ2 Axis", fontsize=12)
plt.legend()
plt.gca().set_aspect('equal', adjustable='box')

# Show the plot
plt.show()
