library(ggplot2)
library(palmerpenguins)
library(patchwork)
theme_set(theme_classic())

g1 = ggplot(penguins,
            aes(bill_length_mm,
                bill_depth_mm,
                color = species)) +
  geom_point() +
  xlab("Bill Length (mm)") +
  ylab("Bill Depth (mm)") +    
  ggtitle("Colour") +
  theme( legend.position = "none")

g2 = ggplot(penguins,
            aes(bill_length_mm,
                bill_depth_mm,
                alpha = flipper_length_mm)) +
  geom_point() +
  xlab("Bill Length (mm)") +
  ylab("Bill Depth (mm)") +    
  ggtitle("Alpha") +
  theme( legend.position = "none")

g3 = ggplot(penguins,
            aes(bill_length_mm,
                bill_depth_mm,
                shape = species)) +
  geom_point() +
  xlab("Bill Length (mm)") +
  ylab("Bill Depth (mm)") +    
  ggtitle("Shapes") +
  theme( legend.position = "none")

g4 = ggplot(CO2,
            aes(x = conc,
                y = uptake,
                colour = Treatment)) +
  geom_point() +
  geom_line(aes(group = Plant)) +
  xlab(expression(paste(CO[2], " Concentration (mL/L)"))) +
  ylab(expression(paste(CO[2], " Uptake (", mu, mol/m^2, " sec)"))) +    
  ggtitle("Grouping lines") +
  geom_line(aes(group = Plant)) +
  theme( legend.position = "none")

(g1 + g2) / (g3 + g4)
ggsave("images/4plot_aesthetic.png", width = 7.7, height = 6.45)
