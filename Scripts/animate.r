library(tidyverse)
library(gganimate)


# Create data for a spinner
spinner_data <- data.frame(
  angle = seq(0, 2 * pi, length.out = 100),
  radius = 1
)

# Create a sequence of rotation angles for the animation
rotation_frames <- data.frame(
  frame = 1:100,
  rotation_angle = seq(0, 2 * pi, length.out = 100)
)

# Join the data to create animated states
animated_data <- spinner_data %>%
  tidyr::crossing(rotation_frames) %>%
  mutate(
    x = radius * cos(angle + rotation_angle),
    y = radius * sin(angle + rotation_angle)
  )

# Create the ggplot
p <- ggplot(animated_data, aes(x = x, y = y)) +
  geom_point(color = "blue", size = 3) +
  coord_polar() + # Use polar coordinates for a circular appearance
  theme_void() # Remove unnecessary plot elements

# Animate the plot
anim <- p +
  transition_states(frame, transition_length = 1, state_length = 0) +
  ease_aes('linear')

# Save the animation (optional)
# anim_save("spinner_animation.gif", anim)

# Display the animation
anim