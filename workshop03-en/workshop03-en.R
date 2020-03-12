## ----setup, echo = FALSE------------------------------------------------------
knitr::opts_chunk$set(
  comment = "#",
  collapse = TRUE,
  warning = FALSE,
  message = FALSE,
  cache = TRUE,
  fig.width = 6, fig.height = 6,
  fig.retina = 3,
  fig.align = 'center'
)
options(repos=structure(c(CRAN="http://cran.r-project.org")))


## ----install_pkgs, echo = FALSE, results = "asis"-----------------------------
cat(
  qcbsRworkshops::first_slides(6, c('grid', 'gridExtra', 'ggplot2', 'ggpubr', 'ggsignif','ggdendro', 'maps', 'mapproj', 'RColorBrewer', 'psych','plotly'), lang = "fr")
)


## ---- echo=FALSE, fig.width=9, fig.height=5.7---------------------------------
source(file="./scripts/multiExamplePlot.R")


## ---- eval = FALSE------------------------------------------------------------
## install.packages("ggplot2") # if not already installed
## library(ggplot2)


## ---- echo = FALSE------------------------------------------------------------
library(ggplot2)


## ----eval=TRUE, echo=TRUE-----------------------------------------------------
library(tibble)
class(iris) # all set!

ir <- as_tibble(iris) # acceptable
class(ir)


## ---- eval=-1-----------------------------------------------------------------
?iris
str(iris)


## ---- fig.width = 6.5, fig.height = 6.5---------------------------------------
library(psych)
pairs.panels(iris)


## ---- echo = FALSE, fig.height=7, fig.width=9---------------------------------
ggplot(data = iris,             # Data
       aes(x = Sepal.Length,    # Your X-value
           y = Sepal.Width,     # Your Y-value
           col = Species)) +    # Aesthtics
  geom_point(size = 5, alpha = 0.8) + # Point
  geom_smooth(method = "lm") +  # Linear regression
  labs(title = "Relation between sepal length and width\n for different iris species") + # Title
  theme(title = element_text(size = 18, face="bold"),
      text = element_text(size = 14))


## ---- fig.height = 5----------------------------------------------------------
p <- ggplot(data = iris,
            aes(x = Sepal.Length,
                y = Sepal.Width))
p <- p + geom_point()
p


## ---- fig.height = 5----------------------------------------------------------
s <- ggplot()
s <- s + geom_point(data = iris,
                    aes(x = Sepal.Length,
                        y = Sepal.Width))
s # Print your final plot


## ---- fig.height=4, fig.width=5-----------------------------------------------
ggplot()


## ---- fig.height=4, fig.width=5-----------------------------------------------
ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  xlab("x = Sepal length") +
  ylab("y = Sepal width")


## ---- fig.height=4, fig.width=5-----------------------------------------------
ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  xlab("x = Sepal length") +
  ylab("y = Sepal width") +
  geom_point()


## -----------------------------------------------------------------------------
ggplot(data = iris, aes(x = Petal.Length,
                        y = Petal.Width)) +
  geom_point()


## ----echo = FALSE, fig.width = 8, fig.height = 6.5----------------------------
library(gridExtra)
source(file="./scripts/4plot_aesthetic.R")


## ---- echo = FALSE, fig.height=4.8, fig.width = 5-----------------------------
ggplot(iris, aes(Sepal.Length, Sepal.Width))+
  geom_point(aes(colour = Species)) +
  labs(title = "Qualitative colour for groups") +
  theme(title = element_text(size = 16, face = "bold"),
        legend.title = element_text(size = 14),
        legend.position = 'bottom')


## ---- echo = FALSE, fig.height=4.8, fig.width = 5-----------------------------
ggplot(iris, aes(Sepal.Length, Sepal.Width))+
  geom_point(aes(colour = Petal.Length)) +
  labs(title = "Gradient colouring for values") +
  theme(title = element_text(size = 16, face = "bold"),
        legend.title = element_text(size = 14),
        legend.position = 'bottom')


## ---- out.width = "50%", fig.align = 'default', fig.asp=2/3-------------------
# No colour mapping
ggplot(data = iris) +
  geom_point(mapping = aes(x = Sepal.Length, y = Sepal.Width)) +
  labs(title = "No colour mapping")
# With colour mapping
ggplot(data = iris) +
  geom_point(mapping = aes(x = Sepal.Length, y = Sepal.Width, colour = Species)) +
  labs(title = "With colour mapping")


## ---- out.width = "50%", fig.align = 'default', fig.asp=2/3-------------------
# Default
pp <- ggplot(data = iris) +
  geom_point(mapping = aes(x = Sepal.Length, y = Sepal.Width, colour = Species))
pp + labs(title = "Default")
# Manual
pp +
  scale_colour_manual(values = c("grey55", "orange", "skyblue")) +
  labs(title = "Manual")


## ---- out.width = "50%", fig.align = 'default', fig.asp=2/3-------------------
# Default
pp2 <- ggplot(data = iris) +
  geom_point(mapping = aes(x = Sepal.Length, y = Sepal.Width,
                           colour = Petal.Length))
pp2 + labs(title = "Default")
# Manual
pp2 + scale_colour_gradient(low = "blue", high = "red") +
  labs(title = "Manual")


## ---- eval = FALSE------------------------------------------------------------
## install.packages("RColorBrewer")
## require(RColorBrewer)
## display.brewer.all()


## ---- fig.align = 'default', fig.asp=2/3--------------------------------------
# Palette for groups
pp + scale_colour_brewer(palette = "Dark2") +
  labs(title = "Palette for groups")


## ---- fig.align = 'default', fig.asp=2/3--------------------------------------
# Palette for continuous values
pp2 + scale_colour_gradientn(colours = rainbow(5)) +
  labs(title = "Palette for continuous values")


## ----  fig.align = 'default', fig.asp=2/3-------------------------------------
# Palette for groups
pp + scale_colour_grey() +
  labs(title = "Palette for groups")


## ----  fig.align = 'default', fig.asp=2/3-------------------------------------
# Palette for continuous values
pp2 + scale_colour_gradient(low = "grey85", high = "black") +
  labs(title = "Palette for continuous values")


## ----colorblindr_install, message = FALSE-------------------------------------
remotes::install_github("clauswilke/colorblindr", quiet = TRUE)
library(colorblindr)


## ---- echo = FALSE, fig.width = 11, fig.height = 7.5--------------------------
cvd_grid(pp)


## ---- out.width = "50%", fig.align = 'default', fig.asp=2/3-------------------
# Palette for groups
pp + scale_colour_viridis_d() +
  labs(title = "viridis palette for groups")
# Palette for continuous values
pp2 + scale_colour_viridis_c() +
  labs(title = "viridis palette for continuous values")


## ---- out.width = "50%", fig.align = 'default', fig.asp=2/3-------------------
# shape for groups
ggplot(data = iris) +
  geom_point(mapping = aes(x = Sepal.Length, y = Sepal.Width, shape = Species)) +
  labs(title = "shape for groups")

# size and alpha for continuous values
ggplot(data = iris) +
  geom_point(mapping = aes(x = Sepal.Length, y = Sepal.Width,
                           size = Petal.Length, alpha = Petal.Length)) +
  labs(title = "size and alpha for continuous values")


## ---- fig.height=3.5, fig.width=6---------------------------------------------
data(mtcars)
ggplot(data = mtcars) +
  geom_point(mapping = aes(x = wt, y = mpg,
                           colour = disp,
                           alpha = hp))


## ---- fig.height=3.5, fig.width=6---------------------------------------------
data(CO2)
ggplot(data = CO2) +
    geom_point(mapping = aes(x = conc, y = uptake,
                             colour = Treatment, shape = Type))


## ---- fig.height=3.5, fig.width=6---------------------------------------------
data(msleep)
ggplot(data = msleep) +
    geom_point(mapping = aes(x = log10(bodywt), y = awake,
                             colour = vore, shape = conservation))


## ---- out.width = "50%", fig.align = 'default', fig.asp=2/3-------------------
# x axis in regular scale
ggplot(diamonds) +
  geom_point(mapping = aes(x = carat, y = price)) +
  labs(title = "x-axis in regular scale")

# x-axis and y-axis in log10() scale
ggplot(diamonds) + geom_point(mapping = aes(x = carat, y = price)) +
  scale_x_log10() +
  scale_y_log10() +
  labs(title = "x- and y-axes in log10 scale")


## ---- out.width = "50%", fig.align = 'default', fig.asp=2/3-------------------
# Theme classic
pp + scale_colour_grey() +
  theme_classic() +
  labs(title = "Classic")

# Theme minimal
pp + scale_colour_grey() +
  theme_minimal() +
  labs(title = "Minimal")


## ---- fig.align="center", fig.width=10, fig.height=6--------------------------
ggplot(data = iris) +
  geom_point(mapping = aes(x = Sepal.Length, y = Sepal.Width, colour = Species)) +
  facet_grid(~ Species, scales = "free")


## ---- fig.align="center", fig.width=10, fig.height=5.5------------------------
ggplot(data = CO2) +
  geom_point(mapping = aes(x = conc, y = uptake, colour = Treatment)) +
  xlab("CO2 Concentration (mL/L)") + ylab("CO2 Uptake (umol/m^2 sec)") +
  facet_grid(~ Type)


## ---- echo=FALSE, fig.align="center", fig.width=6, fig.height=6---------------
pp


## ---- echo=FALSE, fig.align="center", fig.width=6, fig.height=6---------------
pp +
  ggtitle("Relation between Sepal Length & Width") +
  xlab("Sepal length (cm)") +
  ylab("Sepal Width (cm)") +
  theme(axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 16),
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        plot.title = element_text(size = 16, face="bold"),
        legend.title = element_text(size=14, face="bold"),
        legend.text = element_text(size=12))


## ---- echo=FALSE, fig.width=10, fig.height=5----------------------------------
library(reshape2)
tips.gg <- ggplot(tips, aes(x = total_bill,
                            y = tip/total_bill,
                            shape = smoker,
                            colour = sex,
                            size = size)) +
  geom_point() +
  facet_grid( ~ time) +
  scale_colour_grey() +
  labs(title = "Relation between total bill and tips during lunch and dinner",
       x = "Total bill ($)", y = "Ratio between tips and total bill") +
  theme_classic() +
  theme(axis.title = element_text(size = 16,
                                  colour = "navy"),
        axis.text = element_text(size = 12),
        plot.title = element_text(size = 16,
                                  colour = "orange3",
                                  face = "bold"),
        strip.text.x = element_text(size = 14, face="bold"))
tips.gg


## ---- eval=FALSE--------------------------------------------------------------
## library(reshape2)
## tips.gg <- ggplot(tips, aes(x = total_bill,
##                             y = tip/total_bill,
##                             shape = smoker,
##                             colour = sex,
##                             size = size)) +
##   geom_point() +
##   facet_grid( ~ time) +
##   scale_colour_grey() +
##   labs(title = "Relation between total bill and tips during lunch and dinner",
##        x = "Total bill ($)", y = "Ratio between tips and total bill") +
##   theme_classic() +
##   theme(axis.title = element_text(size = 16,
##                                   colour = "navy"),
##         axis.text = element_text(size = 12),
##         plot.title = element_text(size = 16,
##                                   colour = "orange3",
##                                   face = "bold"),
##         strip.text.x = element_text(size = 14, face="bold"))
## tips.gg


## ---- fig.width = 7-----------------------------------------------------------
tips.gg <- ggplot(tips) +
  geom_point(mapping = aes(x = total_bill, y = tip/total_bill,
                      shape = smoker, colour = sex, size = size))
tips.gg


## ---- fig.width=7-------------------------------------------------------------
tips.gg <- tips.gg +
  facet_grid( ~ time)
tips.gg


## ---- fig.width=7-------------------------------------------------------------
tips.gg <- tips.gg +
  scale_colour_grey()
tips.gg


## ---- fig.width=7-------------------------------------------------------------
tips.gg <- tips.gg +
  labs(title = "Relation between total bill and tips during lunch and dinner",
       x = "Total bill ($)", y = "Ratio between tips and total bill")
tips.gg


## ---- fig.width=6, fig.height=4-----------------------------------------------
tips.gg <- tips.gg +
  theme_classic() +
  theme(axis.title = element_text(size = 16, colour = "navy"),
        axis.text = element_text(size = 12),
        plot.title = element_text(size = 16, colour = "orange3", face = "bold"),
        strip.text.x = element_text(size = 14, face = "bold"))
tips.gg


## ---- fig.align="center"------------------------------------------------------
ggplot(iris, aes(Sepal.Length))


## ---- fig.align="center"------------------------------------------------------
ggplot(iris, aes(Sepal.Length)) +
  geom_histogram() +
  ggtitle("Histogram of sepal length ")


## -----------------------------------------------------------------------------
ggplot(iris, aes(Sepal.Length)) +
  geom_histogram() +
  ggtitle("Histogram of sepal length")


## -----------------------------------------------------------------------------
hist(iris$Sepal.Length,
     main = "Histogram of sepal length")


## -----------------------------------------------------------------------------
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  labs(title = "Scatterplot")


## -----------------------------------------------------------------------------
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  labs(title = "Linear Regression") +
  geom_smooth(method = lm)


## ---- fig.align="center"------------------------------------------------------
ggplot(data = iris, aes(Species, Sepal.Length,
                        fill = Species)) +
  geom_boxplot() +
  labs(title = "Boxplot")


## ---- echo=FALSE, fig.align="center", fig.width = 7, fig.height = 3.7---------
ggplot(data = iris, aes(Species, Sepal.Length, fill = Species)) +
  geom_boxplot() +
  labs(title = "Boxplot")


## ---- fig.align="center"------------------------------------------------------
library(ggsignif)
ggplot(data = iris, aes(Species, Sepal.Length)) +
  geom_boxplot() +
  geom_signif(comparisons = list(c("versicolor", "virginica")),
              map_signif_level=TRUE)


## ---- echo=FALSE--------------------------------------------------------------
# Data
names <- c(rep("A", 80) , rep("B", 50) , rep("C", 70))
value <- c(sample(2:5, 80 ,replace=TRUE), sample(4:10, 50 , replace=TRUE),
       sample(1:7, 70 , replace=TRUE))
data <- data.frame(names,value)

#Graph
qplot(x=names ,y=value ,data=data ,geom=c("boxplot","jitter") ,fill=names)


## ---- echo=FALSE--------------------------------------------------------------
ggplot(data = data, aes(names, value, fill=names)) + geom_violin()



## ---- fig.align="center"------------------------------------------------------
ggplot(data = iris, aes(Species, Sepal.Length)) +
  geom_violin() +
  labs(title = "Violin plot")


## -----------------------------------------------------------------------------
ggplot(mtcars, aes(cyl, mpg)) +
  geom_point() +
  stat_summary(fun.y = "median", geom = "point",
               colour = "red") +
  labs(title = "Means")


## -----------------------------------------------------------------------------
ggplot(mtcars, aes(cyl, mpg)) +
  geom_point() +
  stat_summary(fun.data = "mean_cl_boot",
               colour = "red") +
  labs(title = "Means and confidence intervals")


## -----------------------------------------------------------------------------
crimes <- data.frame(state = tolower(rownames(USArrests)), USArrests)
crimesm <- reshape2::melt(crimes, id = 1)

library(maps)
states_map <- map_data("state")

ggplot(crimes, aes(map_id = state)) +
  geom_map(aes(fill = Murder), map = states_map) +
  expand_limits(x = states_map$long, y = states_map$lat) +
  coord_map()


## ---- echo=TRUE, fig.width=5, fig.height=4.4----------------------------------
iris.dens <- ggplot(iris, aes(Sepal.Length)) +
  geom_density()
iris.dens


## ---- echo=TRUE, fig.width=5, fig.height=4.4----------------------------------
cars.dens <- ggplot(cars, aes(dist)) +
  geom_density()
cars.dens


## -----------------------------------------------------------------------------
library(ggdendro)
USArrests.short = USArrests[1:10,]
hc <- hclust(dist(USArrests.short), "ave")

ggdendrogram(hc, rotate = TRUE, theme_dendro = FALSE)


## ---- fig.width=9, fig.height=5-----------------------------------------------
library(ggpubr)
ggarrange(iris.dens, cars.dens, labels = c('a)','b)'))


## ---- fig.align='center'------------------------------------------------------
data(msleep)
msleep.challenge4 <- ggplot(msleep, aes(vore, log10(brainwt), fill=vore))
msleep.challenge4 + geom_violin() +
  geom_signif(comparisons = list(c("herbi", "insecti"))) +
  labs(main = "Brain weight among different vore", y = "log10(Brain weight (Kg))") +
  scale_fill_grey() +
  theme_classic()


## ---- fig.align='center', fig.width=5, fig.height=4---------------------------
data(mtcars)
mtcars.short <- mtcars[1:20,]
mtcars.short.hc <- hclust(dist(mtcars.short), "complete")
dendro.challenge4 <- ggdendrogram(mtcars.short.hc, rotate = TRUE, theme_dendro = FALSE)
dendro.challenge4 + ggtitle("Car dendro from motor spec") +
  xlab("Cars") +
  theme(axis.title.y = element_text(size = 16),
        axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y = element_text(size = 12),
        plot.title = element_text(size = 14, face="bold"))


## ---- echo = TRUE, fig.width=10, fig.height=5---------------------------------
p = ggplot(iris,
           aes(x=Sepal.Length, y=Sepal.Width, colour=Species, shape=Species)) +
    geom_point(size=6, alpha=0.6)

plotly::ggplotly(p)


## ---- eval=FALSE--------------------------------------------------------------
## my1rstPlot <- ggplot(iris, aes(Petal.Length, Petal.Width)) +
##   geom_point()
## 
## ggsave("my1stPlot.pdf",
##        my1rstPlot,
##        height = 8.5, width = 11, units = "in", res = 300)


## ---- eval=FALSE--------------------------------------------------------------
## pdf("./graph_du_jour.pdf")
##   print(my1rstPlot) # print function is necessary
## graphics.off()

