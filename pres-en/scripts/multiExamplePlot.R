# Script to demo various plots in base R and ggplot

# load packages
library(palmerpenguins)
library(ggplot2)
library(cowplot)
library(ggplotify)
library(here)

# load penguin data
data("penguins") 
penguins$body_mass_g_log10 <- log10(penguins$body_mass_g)
penguins <- na.omit(penguins)

# scatter plot
a <- as_grob(~plot(penguins[,c("bill_length_mm","bill_depth_mm")], 
                   main = "Scatter plot",
                   xlab = "Bill length (mm)", ylab = "Bill depth (mm)",
                   pch = 16, col = penguins$species))

# density plot
b <- as_grob(~plot(density(penguins$bill_length_mm), main = "Density plot"))

# histogram
d <- as_grob(~hist(penguins$bill_length_mm,
                   main = "Histogram",
                   xlab = "Bill length (mm)",
                   breaks = 10))

#create your ggplot object
e <- ggplot(data = penguins,aes(x = bill_length_mm,
                                y = bill_depth_mm,
                                col = species)) +
  geom_point() +
  geom_smooth(method = "lm", formula = 'y ~ x') +
  labs(title = "Smoothed scatter plot", x = "Bill length (mm)", y = "Bill depth (mm)") +
  theme(legend.position="none")

f <- ggplot(data = penguins,aes(x = island,
                                y = body_mass_g_log10,
                                fill = island)) +
  geom_boxplot() + 
  labs(title = "Boxplot", x = "", y = "Body mass (log10 g)") +
  theme(legend.position="none")

g <- ggplot(data = penguins,aes(x = species,
                                y = bill_depth_mm,
                                fill = species)) +
  geom_violin() +
  labs(title = "Violin plot", x = "", y = "Bill depth (mm)") +
  theme(legend.position="none")

# plot the ggplot using the print command
plot_grid(a, b, d, e, f, g)

# save plot
ggsave("images/multiExamplePlot.png", width = 12, height = 7)
