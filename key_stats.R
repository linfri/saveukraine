# The code chunk which shows the key statistics.
# (in this instance, for the #SaveUkraine compilation)

library(tidyverse)

# Creating the tibble
key_stats <- tibble(
  x = c(2, 8.5, 2, 8.5),
  y = c(4.8, 4.8, 7.8, 7.8),
  h = c(2, 2, 2, 2),
  w = c(6.25, 6.25, 6.25, 6.25),
  val = c("99", "700", "4504", "56"),
  text = c(
    "Purchases (whole album)", "Donations collected (€)",
    "Plays (whole album)", "Downloads (whole album)"
  ),
  color = factor(c(1, 2, 3, 4))
)

# Plotting the data
ggplot(data = key_stats, aes(x, y, height = h, width = w, label = text)) +
  geom_tile(aes(fill = color)) +
  geom_text(
    color = "white", fontface = "bold", size = 16, family = "sans",
    aes(label = val, x = x - 2.9, y = y + 0.4), hjust = 0
  ) +
  geom_text(
    color = "white", fontface = "bold", size = 5, family = "sans",
    aes(label = text, x = x - 2.9, y = y - 0.6), hjust = 0
  ) +
  coord_fixed() +
  scale_fill_manual(values = c(
    "darkslategrey", "dark orange",
    "deepskyblue4", "darkslategray"
  )) +
  theme(plot.margin = unit(c(-0.30, 0, 0, 0), "null")) +
  theme_void() +
  labs(caption = "Source: Kalamine Records
       Retrieved on 9 April 2022") +
  guides(fill = FALSE)
