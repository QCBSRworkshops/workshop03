##Section: 01-introduction.R 

###Notice ###
#                                                                            #
#This is an automatically generated script based on the code chunks from the #
#book for this workshop.                                                     #
#                                                                            #
#It is minimally annotated to allow participants to provide their comments:  #
#a practice that we highly encourage.                                        #
#                                                                            #
#Note that the solutions to the challenges are also included in this script. #
#When solving the challenges by yourself, attempt to not scroll and peek at  #
#the solutions.                                                              #
#                                                                            #
#Happy coding!                                                               #




# Install the required packages
install.packages("gridExtra")
install.packages("ggplot2")
install.packages("ggsignif")
install.packages("ggdendro")
install.packages("maps")
install.packages("mapproj")
install.packages("RColorBrewer")
install.packages("reshape2")
install.packages("GGally")
install.packages("patchwork")
#install.packages("plotly")
install.packages("palmerpenguins")

# Load the required packages
library(gridExtra)
library(ggplot2)
library(ggsignif)
library(ggdendro)
library(maps)
library(mapproj)
library(RColorBrewer)
library(reshape2)
library(GGally)
library(patchwork)
#library(plotly)
library(palmerpenguins)


##Section: 02-visualization-in-science.R 




##Section: 03-ggplot2-mechanics.R 

str(penguins) # let's have a look at some penguin data!



class(penguins) # check the class of the data to ensure it is either a data.frame or tibble for ggplot2

# you can transform a dataset into a tibble using the as_tibble() function if need be
# peng <- tibble::as_tibble(penguins) 
# class(peng)

# Get a general overview of the data with multiple plot types
ggpairs(penguins, 
        aes(colour = species),
        progress = FALSE) + 
  theme_bw() 

# Let's explore how some of this data is structured by species
ggplot(data = penguins,               # Data
       aes(x = bill_length_mm,        # Your X-value
           y = bill_depth_mm,         # Your Y-value
           col = species)) +          # Aesthetics
  geom_point(size = 5, alpha = 0.8) + # Point
  geom_smooth(method = "lm") +        # Linear regression
  labs(title = "Relationship between bill length and depth\nfor different penguin species", # Title
       x = "Bill length (mm)", # X-axis title
       y = "Bill depth (mm)", # Y-axis title
       col = "Species") +  # Colour data point by species (also creates legend)
  theme_classic() + # Apply a clean theme
  theme(title = element_text(size = 18, face = "bold"),
      text = element_text(size = 16))





# Layer 1: Data
ggplot(data = penguins) 
# Without any other information, your data will not be visualised.

# Next layer: aesthetics.
# Here, we tell R to plot length on the x axis, and depth on the y axis
# but we still haven't told R how we want these data to be represented...
ggplot(data = penguins, 
       aes(x = bill_length_mm, 
           y = bill_depth_mm)) 
# See? Our variables are now assigned to the x and y axes, 
# but nothing is plotted yet.

# Next layer(s): geometric object(s)
ggplot(data = penguins, 
       aes(x = bill_length_mm, 
           y = bill_depth_mm)) + # Use the plus sign to add each additional layer
  geom_point() # The geom layer determines what style of plot we are using.
               # geom_point() plots the data as points!

# Next layer(s): customizations!
# Facets split a plot into separate windows according to some category in the data.
ggplot(data = penguins, 
       aes(x = bill_length_mm, 
           y = bill_depth_mm)) +
  geom_point() + 
  facet_wrap(vars(species)) # This splits the plot into three windows: one per species

ggplot(data = penguins,
       aes(x = bill_length_mm,
           y = bill_depth_mm)) +
  geom_point() +
  facet_wrap(vars(species)) +
  # this transforms the axes' coordinates using log10()
  coord_trans(x = "log10", y = "log10")

ggplot(data = penguins,
       aes(x = bill_length_mm,
           y = bill_depth_mm)) +
  geom_point() +
  facet_wrap(vars(species)) +
  coord_trans(x = "log10", y = "log10") +
  # this uses a nicer theme for our final plot
  theme_bw()



# Challenge 1 ----
# 
# Make a ggplot to answer the following questions:
# 1. Is there a relationship between **bill length** & **flipper length**?
# 2. Does *bill length* increase with flipper *length*?




# SOLUTION # -----

# Make a scatter plot to visualize the variables
ggplot(data = penguins, 
       aes(x = bill_length_mm,
           y = flipper_length_mm)) +
  geom_point()

# Customize the points' shape and colour 
ggplot(data = penguins,
       aes(x = bill_length_mm,
           y = flipper_length_mm)) +
  geom_point(shape = 2, color = "blue") 


##Section: 04-aesthetic-mapping.R 

ggplot(penguins,
       aes(x = bill_length_mm,
           y = bill_depth_mm)) +
  geom_point(aes(colour = species)) +
  labs(title = "Qualitative colour for groups",
       x = "Bill length (mm)",
       y = "Bill depth (mm)") +
  theme(title = element_text(size = 16, face = "bold"),
        legend.title = element_text(size = 14),
        legend.position = 'bottom')

ggplot(penguins,
       aes(x = bill_length_mm,
           y = bill_depth_mm)) +
  geom_point(aes(colour = log10(body_mass_g))) +
  labs(title = "Gradient colour for values",
       x = "Bill length (mm)",
       y = "Bill depth (mm)",
       col = "Body mass (log10 g)") +
  theme(title = element_text(size = 16, face = "bold"),
        legend.title = element_text(size = 14),
        legend.position = 'bottom')

# No colour mapping
ggplot(data = penguins,
       aes(x = bill_length_mm,
           y = flipper_length_mm)) +
  geom_point() +
  geom_smooth(method = lm)+
  labs(title = "No colour mapping",
       x = "Bill length (mm)",
       y = "Bill depth (mm)")

# With colour mapping
ggplot(data = penguins,
       aes(x = bill_length_mm,
           y = flipper_length_mm,
           col = species)) + # Using the col argument, we can colour by species
  geom_point() +
  geom_smooth(method=lm) +
  labs(title = "With colour mapping",
       x = "Bill length (mm)",
       y = "Bill depth (mm)")

# Default

# Let ggplot assign colours to species
pp <- ggplot(data = penguins) +
  geom_point(aes(x = bill_length_mm,
                 y = bill_depth_mm,
                 colour = species)) +
  labs(title = "Default",
       x = "Bill length (mm)",
       y = "Bill depth (mm)")
pp

# Manual colour change

# By using scale_colour_manual(),
# we can specify the exact colours we want to use
pp +
scale_colour_manual(
  # Note that the colour order will correspond to
  # the order of the species given in the legend
  values = c("grey55", "orange", "skyblue"))

# Default

# Using the colour argument within aes() will use a
# default colour palette to make our gradient
pp2 <- ggplot(data = penguins) +
  geom_point(aes(x = bill_length_mm,
                 y = bill_depth_mm,
                 colour = log10(body_mass_g))) +
  labs(title = "Default",
       x = "Bill length (mm)",
       y = "Bill depth (mm)")
pp2

# Manual

# By using scale_colour_graduent,
# we can set our colour gradient manually
pp2 +
  scale_colour_gradient(low = "blue",
                        high = "red") +
  labs(title = "Manual")
# Note: there is also scale_colour_gradient2() to create a
# gradient with a midpoint value for diverging palettes


require(RColorBrewer)
display.brewer.all()



# Palette for groups
pp +
  scale_colour_brewer(palette = "Dark2") +
  labs(title = "Palette for groups")

# Palette for continuous values
pp2 +
  scale_color_viridis_c()+
  labs(title = "Palette for continuous values")

# Palette for groups
pp +
  scale_colour_grey() +
  labs(title = "Palette for groups")

# Palette for continuous values
pp2 +
  scale_colour_gradient(low = "grey85", high = "black") +
  labs(title = "Palette for continuous values")

# Let's install the colorBlindness package
install.packages("colorBlindness")
library(colorBlindness)

cvdPlot(pp)  # Let's check how our plot looks with different forms of colour blindness

# Let's use a viridis palette to make our plot more accessible
pp_viridis <- pp +
      scale_colour_viridis_d() +
      labs(title = "Viridis palette for groups")
pp_viridis

# Did we succeed? Let'd use cvdPlot() to check again
cvdPlot(pp_viridis)
# We succeeded!

pp2_viridis <- pp2 +
        scale_colour_viridis_c() +
        labs(title = "Viridis palette for continuous values")
pp2_viridis

cvdPlot(pp2_viridis)

# shape for groups
ggplot(data = penguins) +
  geom_point(aes(x = bill_length_mm,
                 y = bill_depth_mm,
                 shape = species)) + # Group data with data point shape
  labs(title = "Shapes for groups")

# size and alpha for continuous values
ggplot(data = penguins) +
  geom_point(aes(x = bill_length_mm,
                 y = bill_depth_mm,
                 size = body_mass_g,# Group data using point size
                 alpha = flipper_length_mm)) + # Group data using transparency
  labs(title = "Size and alpha for continuous values")

# Challenge 2 ----

# Produce an informative plot from built-in datasets such as `mtcars`, `CO2` or `msleep`.
# Use appropriate aesthetic mappings for different data types!




# SOLUTION # -----

# One of many solutions: mtcars
data(mtcars)
ggplot(data = mtcars) +
  geom_point(aes(x = wt,
                 y = mpg,
                 colour = disp,
                 alpha = hp))

# Another possible solution
data(CO2)
ggplot(data = CO2) +
  geom_point(
    aes(x = conc,
        y = uptake,
        colour = Treatment,
        shape = Type))

# Another possible solution
data(msleep)
ggplot(data = msleep) +
  geom_point(
    aes(x = log10(bodywt),
        y = awake,
        colour = vore,
        shape = conservation))

data(ToothGrowth)
ggplot(ToothGrowth,
       aes(x = dose,
           y = len,
           color = supp)) +
  geom_point() +
  geom_smooth(method = lm, formula = 'y ~ x')

ggplot(diamonds) +
  geom_point(aes(x = carat,
                           y = price)) +
  labs(title = "Original scale")

ggplot(diamonds) +
  geom_point(mapping = aes(x = carat, y = price)) +
  coord_trans(x = "log10", y = "log10") +
  labs(title = "log10 scale")


##Section: 05-fine-tuning-plots.R 

# Theme grey
pp + scale_colour_grey() + # Make data points gray
  theme_grey() + # Make background gray
  labs(title = "Default: Grey") # Title plot

pp + scale_colour_grey() +# Make data points gray
  theme_classic() + # Make background white
  labs(title = "Classic") # Title plot

pp + scale_colour_grey() +
  theme_minimal() + # Make background white with gray gridlines 
  labs(title = "Minimal")

# Set black & white theme as default
theme_set(theme_bw()) # Note the background is white with a black frame
pp

# remove minor gridlines 
theme_update(
  panel.grid.minor = element_blank()) # Adjust gridline scale
pp





mytheme <- theme_bw() + # You can start from an existing theme to get some of the basic elements set up
           theme(plot.title = element_text(colour = "red")) +
           theme(legend.position = c(0.9, 0.9))
pp + mytheme # Apply it to your plot!

install.packages("ggthemes")
library(ggthemes)

# Let's use the FiveThirtyEight blog's theme, and Tableau's color palette
pp + 
  theme_fivethirtyeight() + 
  scale_color_tableau()

# Let's use Tufte's "Maximal Data, Minimal Ink" theme
pp + 
  theme_tufte()

ggplot(data = penguins) +
  geom_point(aes(x = bill_length_mm, 
                 y = bill_depth_mm, 
                 colour = species)) + 
  facet_grid(~ species, 
             scales = "free") # the scale of the y axis can vary between facets.
# do not do this if you are comparing facets via the y axis!

ggplot(data = penguins) +
  geom_point(aes(x = bill_length_mm, 
                 y = bill_depth_mm, 
                 colour = species)) + 
  facet_grid(year ~ species, 
             scales = "free")

# Let's come back to our penguin plot from before
pp

# Tuning axes and titles to make the plot speak for itself
pp +
  # Label the title, axes, and color legend
  labs(title = "Relationship between Bill Length & Depth",
       x = "Bill Length (mm)",
       y = "Bill Depth (mm)",
       col = "Species") +
  # adjust the size of these labels
  theme(axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 16),
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        plot.title = element_text(size = 16, face="bold"), # bold the title
        legend.title = element_text(size=14, face="bold"), # bold the legend title
        legend.text = element_text(size=12))

# install and load the package
install.packages("reshape2")
library(reshape2)



# Challenge 3 ----
# 
# Use the tips dataset found in the package reshape2 to reproduce the plot in the slide or book.
# Our tip: start from theme_classic() and add theme() to make your additional changes.




# SOLUTION # -----

# Build the plot
tips.gg <- ggplot(tips,
                  # Step 1. Specify the aesthetic mapping from the axes and the legends
                  aes(x = total_bill,
                      y = tip/total_bill,
                      shape = smoker,
                      colour = sex,
                      size = size)) +
  # Step 2. Specify the geom used to represent the data
  geom_point() +
  # Step 3. Specify the variable used to make facets
  facet_grid( ~ time) +
  # Step 4. set the colour scale used to represent sex
  scale_colour_grey() +
  # Step 5. Label the plot title and axes
  labs(title = "Relation between total bill and tips during lunch and dinner",
       x = "Total bill ($)",
       y = "Ratio between tips and total bill") +
  # Step 6. Set the theme
  theme_classic() +
  # Step 7. Customise the theme to match the sizing and colour of the plot labels
  theme(axis.title = element_text(size = 16,
                                  colour = "navy"),
        axis.text = element_text(size = 12),
        plot.title = element_text(size = 16,
                                  colour = "orange3",
                                  face = "bold"),
        # this part adjusts the text in the facet labels (strips!)
        strip.text.x = element_text(size = 14, face="bold"))
# print our beautiful plot!
tips.gg



theme_set(theme_bw())
theme_update(panel.grid.minor = element_blank(),
             axis.text = element_text(size = 16),
             axis.title = element_text(size = 18))

ggplot(penguins)

ggplot(penguins, 
       aes(x = bill_length_mm)) +
  geom_histogram() +
  ggtitle("Histogram of penguin bill length ")

ggplot(mpg, 
       aes(x = displ, 
           y = hwy)) +
  geom_point() +
  labs(title = "Scatterplot")

ggplot(mpg, 
       aes(x = displ, 
           y = hwy)) +
  geom_point() +
  geom_smooth(method = lm) +
  labs(title = "Linear Regression") 

ggplot(data = penguins, 
       aes(x = species, 
           y = bill_length_mm,
           fill = species)) + # specify species as a grouping variable
  geom_boxplot() +
  labs(title = "Boxplot")



library(ggsignif)
ggplot(data = penguins, 
       aes(x = species, 
           y= bill_length_mm,
           fill = species)) +
  geom_boxplot() +
  geom_signif(
    # which groups should be compared?
    comparisons = list(c("Adelie", "Gentoo")), 
    map_signif_level=TRUE)





violin <- ggplot(data = penguins, 
                 aes(x = species, 
                     y = bill_length_mm)) +
  geom_violin(trim = FALSE, # do not trim the violins' tips if there are outliers
              fill = "grey70", # set all the violins to grey
              alpha = .5) + # transparency of the fill colour
  labs(title = "Violin plot")
violin

violin + 
  # this geom plots the data points with some additional (horizontal) noise
  # to see overlapping points
    geom_jitter(shape = 16, 
                position = position_jitter(0.2),
              alpha = .3) +
  geom_boxplot(width = .05)

# plot the median of the number of cylinders
ggplot(mtcars, 
       aes(x = cyl, y = mpg)) +
  geom_point() +
  stat_summary(fun = "median", 
               geom = "point",
               colour = "red",
               size = 6) +
  labs(title = "Medians")

# plot the mean of each group with bootstrapped confidence intervals
ggplot(mtcars, 
       aes(cyl, mpg)) +
  geom_point() +
  stat_summary(fun.data = "mean_cl_boot",
               colour = "red",
               size = 1.6) +
  labs(title = "Means and confidence intervals")

# load maps library
library(maps)
states_map <- map_data("state") # get a state-level map of the US

# State name is set as rownames. Let's make a new column for these
# that matches the column of state names in our states_map
USArrests$region <- tolower(rownames(USArrests))

# Build our map
ggplot(USArrests, 
       aes(map_id = region)) + # the variable name to link our map and dataframe
  geom_map(aes(fill = Murder), # variable we want to represent with an aesthetic
           map = states_map) + # data frame that contains coordinates
  expand_limits(x = states_map$long, 
                y = states_map$lat) +
  coord_map() +  # projection 
  labs(x = "", y = "") # remove axis labels

(peng.dens <- ggplot(penguins, 
                     aes(x = bill_length_mm)) +
   geom_density())

(cars.dens <- ggplot(cars, 
                    aes(x = dist)) +
   geom_density())

library(ggdendro)

USArrests.short <- USArrests[1:10,] # take a small sample for simplicity
hc <- hclust(dist(USArrests.short), "average") # cluster by average distance (UPGMA)

# plot the clustering dendrogram
ggdendrogram(hc, rotate = TRUE)

# load patchwork to arrange our density plots
library(patchwork)

# adding them together means "place them beside each other"
peng.dens + cars.dens +
  plot_annotation(tag_levels = 'a') # adds a) and b) to your plots, to reference
# in your figure captions.

# Challenge 4 ----
# 
# Create your own ggplot and follow these recommendations:
#   * Dataset: any (recommended: use your dataset)
#   * Explore a new geom_* and other plot elements (recall Chapter @ref/(#gg-layers))
#
# Use the following links for tips and inspiration:
#
# - [ggplot2 Reference](https://ggplot2.tidyverse.org/reference/index.html)
# - [R Graph Gallery](https://www.r-graph-gallery.com/ggplot2-package.html)
# - [Data to Viz](https://www.data-to-viz.com/)
# 
# 
# 
# 
# SOLUTION # -----

data(msleep)
ggplot(msleep, 
       aes(x = vore, 
           y = log10(brainwt), 
           fill = vore)) + 
  geom_violin() +
  geom_signif(comparisons = list(c("herbi", "insecti"))) +
  labs(main = "Brain weight among different vore", 
       y = "log10(Brain weight (Kg))") +
  scale_fill_grey() +
  theme_classic()

data(mtcars)
# let's do some clustering!
mtcars.short <- mtcars[1:20,]
mtcars.short.hc <- hclust(dist(mtcars.short), "average")

ggdendrogram(mtcars.short.hc, rotate = TRUE) + 
  # fine-tuning
  labs(title = "Car dendro from motor spec", y ="Cars") +
  theme(axis.title.y = element_text(size = 16),
        axis.text.y = element_text(size = 12),
        axis.title.x = element_blank(), axis.text.x = element_blank(),
        plot.title = element_text(size = 14, face="bold"))

library(plotly)
p <- ggplot(penguins,
           aes(x = bill_length_mm,
               y = bill_depth_mm,
               colour = species,
               shape = species)) +
    geom_point(size=6, alpha=0.6)
# convert to a plotly object!
ggplotly(p)


##Section: 06-saving-plots.R 

my1stPlot <-  # Create a plot to practice saving
  ggplot(penguins,
         aes(x = bill_length_mm,
             y = bill_depth_mm)) +
  geom_point()

ggsave(filename = "my1stPlot.pdf", # Name the file you want to save to, add extension of the file format you want to use (ex. pdf)
       plot = my1stPlot, # Provide the name of the plot object in R
       height = 8.5, # Provide the desired dimensions
       width = 11,
       units = "in")

# Tip:`quartz()` (mac) or `window()` (pc) functions make sizing easier before `ggsave()`!
# Just plot your ggplot in quartz() or window(), adjust the size until it looks good,
# and run ggsave() with the filename to see which dimensions you used! You can
# then add this in your code with height = and width = as shown above.

my2ndPlot <-  # Create a 2nd plot to practice saving
  ggplot(penguins,
         aes(x = bill_length_mm,
             y = bill_depth_mm)) +
  geom_point()

pdf("./graph_du_jour.pdf")
  print(my1stPlot) # print function is necessary
  print(my2ndPlot)
graphics.off()


##Section: 07-conclusion.R 




