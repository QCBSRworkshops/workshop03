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
  qcbsRworkshops::first_slides(6, c('grid', 'gridExtra', 'ggplot2', 'ggsignif','ggdendro', 'maps', 'mapproj', 'RColorBrewer', 'GGally','patchwork','plotly'), lang = "fr")
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
class(iris) # Tout est prêt !

ir <- as_tibble(iris) # acceptable
class(ir)


## ---- eval=-1-----------------------------------------------------------------
?iris
str(iris)


## ---- fig.width = 10.25, fig.height = 6.5-------------------------------------
install.packages("GGally")
library(GGally)
ggpairs(iris, aes(colour = Species)) + theme_bw()


## ---- echo = FALSE, fig.height=7, fig.width=9---------------------------------
ggplot(data = iris,             # Données
       aes(x = Sepal.Length,    # Valeurs en X
           y = Sepal.Width,     # Valeurs en Y
           col = Species)) +    # Esthétiques
  geom_point(size = 5, alpha = 0.8) + # Point
  geom_smooth(method = "lm") +  # Régression linéaire
  labs(title = "Relation entre la longueur et la largeur\ndes sépales pour différentes espèces d'iris") + # Title
  theme(title = element_text(size = 18, face = "bold"),
      text = element_text(size = 14))


## ---- fig.height = 5----------------------------------------------------------
p <- ggplot(data = iris,
            aes(x = Sepal.Length,
                y = Sepal.Width))
p <- p + geom_point()
p # Imprimer le graphique final


## ---- fig.height = 5----------------------------------------------------------
s <- ggplot()
s <- s + geom_point(data = iris,
                    aes(x = Sepal.Length,
                        y = Sepal.Width))
s # Imprimer le graphique final


## ---- fig.height=4, fig.width=5-----------------------------------------------
ggplot(data = iris)


## ---- fig.height=4, fig.width=5-----------------------------------------------
ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) 


## ---- fig.height=4, fig.width=5-----------------------------------------------
ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point()


## ----fig.height=4.5-----------------------------------------------------------
ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point() + 
  facet_wrap(~Species) +
  coord_trans(x = "log10",
              y = "log10")


## -----------------------------------------------------------------------------
ggplot(data = iris, aes(x = Petal.Length,
                        y = Petal.Width)) +
  geom_point()


## -----------------------------------------------------------------------------
ggplot(data = iris, aes(x = Petal.Length,
                        y = Petal.Width)) +
  geom_point()


## -----------------------------------------------------------------------------
ggplot(data = iris, aes(x = Petal.Length,
                        y = Petal.Width)) +
  geom_point(shape = 2, color = "blue")


## ----echo = FALSE, fig.width = 8, fig.height = 6.5----------------------------
library(gridExtra)
source(file="./scripts/4plot_aesthetic.R")


## ---- echo = FALSE, fig.height=4.8, fig.width = 5-----------------------------
ggplot(iris, aes(Sepal.Length, Sepal.Width))+
  geom_point(aes(colour = Species)) +
  labs(title = "Couleurs qualitatives pour des groupes",
       x = "Longeur des sépales",
       y = "Largeur des sépales") +
  theme(title = element_text(size = 14, face = "bold"),
        legend.title = element_text(size = 14),
        legend.position = 'bottom')


## ---- echo = FALSE, fig.height=4.8, fig.width = 5-----------------------------
ggplot(iris, aes(Sepal.Length, Sepal.Width))+
  geom_point(aes(colour = Petal.Length)) +
  labs(title = "Gradient de couleurs pour des valeurs",
       x = "Longeur des sépales",
       y = "Largeur des sépales") +
  theme(title = element_text(size = 14, face = "bold"),
        legend.title = element_text(size = 14),
        legend.position = 'bottom')


## ---- fig.align = 'default', fig.asp=2/3--------------------------------------
ggplot(data = iris,
       aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point() +
  geom_smooth(method = lm)+
  labs(title = "Avec code de couleur")


## ----  fig.align = 'default', fig.asp=2/3-------------------------------------
ggplot(data = iris, 
       aes(x = Sepal.Length, y = Sepal.Width, colour = Species)) +
  geom_point() +
  geom_smooth(method = lm) +
  labs(title = "Sans code de couleur")


## ---- fig.align = 'default', fig.asp=2/3--------------------------------------
pp <- ggplot(data = iris) +
  geom_point(aes(x = Sepal.Length, 
                 y = Sepal.Width, 
                 colour = Species))
pp + labs(title = "Défaut")


## ---- fig.align = 'default', fig.asp=2/3--------------------------------------
pp +
  scale_colour_manual(values = c("grey55", 
                                 "orange", 
                                 "skyblue")) +
  labs(title = "Personnalisé")


## ---- fig.align = 'default', fig.asp=2/3--------------------------------------
pp2 <- ggplot(data = iris) +
  geom_point(aes(x = Sepal.Length, 
                 y = Sepal.Width,
                 colour = Petal.Length))
pp2 + labs(title = "Défaut")


## ---- fig.align = 'default', fig.asp=2/3--------------------------------------
pp2 + 
  scale_colour_gradient(low = "blue", 
                        high = "red") +
  labs(title = "Personnalisé")


## ---- eval = FALSE------------------------------------------------------------
## install.packages("RColorBrewer")
## library(RColorBrewer)
## display.brewer.all()


## ---- fig.align = 'center', fig.asp=2/3---------------------------------------
pp + scale_colour_brewer(palette = "Dark2") +
  labs(title = "Palette pour des groupes")


## ---- fig.align = 'center', fig.asp=2/3---------------------------------------
pp2 + scale_color_viridis_c()+
  labs(title = "Palette pour des variables continues")


## ----  fig.align = 'center', fig.asp=2/3--------------------------------------
pp + scale_colour_grey() +
  labs(title = "Palette pour des groupes")


## ----  fig.align = 'center', fig.asp=2/3--------------------------------------
pp2 + scale_colour_gradient(low = "grey85", high = "black") +
  labs(title = "Palette pour des variables continues")


## ----colorblindr_install, message = FALSE-------------------------------------
# install.packages("remotes")
remotes::install_github("clauswilke/colorblindr", quiet = TRUE)
library(colorblindr)


## ---- fig.width = 11, fig.height = 7------------------------------------------
cvd_grid(pp)


## ---- fig.height = 5----------------------------------------------------------
pp + scale_colour_viridis_d() +
  labs(title = "Palette viridis pour des groupes")


## ---- fig.height = 5----------------------------------------------------------
pp2 + scale_colour_viridis_c() +
  labs(title = "Palette viridis pour des variables continues")


## ---- fig.height = 4.5, fig.width = 5.5---------------------------------------
ggplot(data = iris) +
  geom_point(aes(x = Sepal.Length, 
                 y = Sepal.Width, 
                 shape = Species)) +
  labs(title = "Formes pour des groupes")


## ---- fig.height = 4.5, fig.width = 5.5---------------------------------------
ggplot(data = iris) +
  geom_point(aes(x = Sepal.Length, 
                 y = Sepal.Width,
                 size = Petal.Length, 
                 alpha = Petal.Length)) +
  labs(title = "Taille et transparence pour des variables continues")


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


## ---- fig.height=3.5, fig.width=6---------------------------------------------
data(ToothGrowth)
ggplot(ToothGrowth, aes(x = dose, y = len, color = supp)) +
  geom_point() + 
  geom_smooth(method = lm, formula = 'y~x')


## ----fig.height=4-------------------------------------------------------------
ggplot(diamonds) +
  geom_point(aes(x = carat, y = price)) +
  labs(title = "Axe des x à l'échelle normale")


## ----fig.height=4-------------------------------------------------------------
ggplot(diamonds) + 
  geom_point(aes(x = carat, y = price)) +
  coord_trans(x = "log10",
              y = "log10") +
  labs(title = "Axes x et y sur une échelle log10")


## ---- fig.height = 5----------------------------------------------------------
pp + scale_colour_grey() +
  theme_classic() +
  labs(title = "Thème classique")


## ---- fig.height = 5----------------------------------------------------------
pp + scale_colour_grey() +
  theme_minimal() +
  labs(title = "Thème minimal")


## ---- fig.height = 5----------------------------------------------------------
# Choisir le thème classic par défaut
theme_set(theme_bw())
pp


## ---- fig.height = 5----------------------------------------------------------
# supprimer la grille mineure
theme_update(panel.grid.minor = element_blank())
pp


## ---- include=FALSE-----------------------------------------------------------
theme_set(theme_bw())
theme_update(panel.grid.minor = element_blank())


## ---- fig.align="center", fig.width=10, fig.height=6--------------------------
ggplot(data = iris) +
  geom_point(mapping = aes(x = Sepal.Length, y = Sepal.Width, colour = Species)) +
  facet_grid(~ Species, scales = "free")


## ---- fig.align="center", fig.width=10, fig.height=5.5------------------------
ggplot(data = CO2) +
  geom_point(mapping = aes(x = conc, y = uptake, colour = Treatment)) +
  xlab("Concentration du CO2 (mL/L)") + ylab("Absorption du CO2 (umol/m^2 sec)") +
  facet_grid(~ Type)


## ---- echo=FALSE, fig.align="center", fig.width=5.5, fig.height=5-------------
pp


## ---- echo=FALSE, fig.align="center", fig.width=5.5, fig.height=5-------------
pp +
  ggtitle("Relation entre longueur et largeur des sépales") +
  xlab("Longueur des sépales (cm)") +
  ylab("Largeur des sépales (cm)") +
  theme(axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 16),
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        plot.title = element_text(size = 16, face = "bold"),
        legend.title = element_text(size = 14, face = "bold"),
        legend.text = element_text(size = 12))


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
  labs(title = "Relation entre la facture totale et les pourboires pendant les repas",
       x = "Facture totale ($)", y = "Ratio entre pourboires et facture totale") +
  theme_classic() +
  theme(axis.title = element_text(size = 16,
                                  colour = "navy"),
        axis.text = element_text(size = 12),
        plot.title = element_text(size = 16,
                                  colour = "orange3",
                                  face = "bold"),
        strip.text.x = element_text(size = 14, face ="bold"))
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
##   labs(title = "Relation entre la facture totale et les pourboires pendant les repas",
##        x = "Facture totale ($)", y = "Ratio entre pourboires et facture totale") +
##   theme_classic() +
##   theme(axis.title = element_text(size = 16,
##                                   colour = "navy"),
##         axis.text = element_text(size = 12),
##         plot.title = element_text(size = 16,
##                                   colour = "orange3",
##                                   face = "bold"),
##         strip.text.x = element_text(size = 14, face ="bold"))
## tips.gg


## ---- fig.width = 7, fig.height=5---------------------------------------------
theme_set(theme_classic())
tips.gg <- ggplot(tips) +
  geom_point(mapping = aes(x = total_bill, y = tip/total_bill,
                      shape = smoker, colour = sex, size = size))
tips.gg


## ---- include=FALSE-----------------------------------------------------------
theme_set(theme_classic())


## ---- fig.width=7, fig.height=5-----------------------------------------------
tips.gg <- tips.gg +
  facet_grid( ~ time)
tips.gg


## ---- fig.width=7,fig.height=5------------------------------------------------
tips.gg <- tips.gg +
  scale_colour_grey()
tips.gg


## ---- fig.width=7,fig.height=5------------------------------------------------
tips.gg <- tips.gg +
  labs(title = "Relation entre la facture totale et les pourboires pendant les repas",
       x = "Facture totale ($)", y = "Ratio entre pourboires et facture totale")
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


## ---- fig.align="center",fig.height=5.5---------------------------------------
ggplot(iris, aes(Sepal.Length)) +
  geom_histogram() +
  ggtitle("Histogramme de la longueur des longueurs")


## ---- fig.width=5.5, fig.height=5.5-------------------------------------------
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  labs(title = "Nuage de points")


## ---- fig.width=5.5, fig.height=5.5-------------------------------------------
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  labs(title = "Régression linéaire") +
  geom_smooth(method = lm)


## ---- fig.align="center"------------------------------------------------------
ggplot(data = iris, aes(Species, Sepal.Length,
                        fill = Species)) +
  geom_boxplot() +
  labs(title = "Diagramme en boîte")


## ---- echo=FALSE, fig.align="center", fig.width = 7, fig.height = 3.2---------
ggplot(data = iris, aes(Species, Sepal.Length, fill = Species)) +
  geom_boxplot() +
  labs(title = "Diagramme en boîte")


## ---- fig.align="center",fig.height=5.5---------------------------------------
library(ggsignif)
ggplot(data = iris, aes(Species, Sepal.Length)) +
  geom_boxplot() +
  geom_signif(comparisons = list(c("versicolor", "virginica")),
              map_signif_level = TRUE)


## ---- echo=FALSE, fig.height=4.4----------------------------------------------
# Data
names <- c(rep("A", 80), rep("B", 50), rep("C", 70))
value <- c(sample(2:5, 80, replace = TRUE), 
           sample(4:10, 50, replace = TRUE),
           sample(1:7, 70, replace = TRUE))
data <- data.frame(names, value)

#Graph
qplot(x = names, y = value, data = data, geom = c("boxplot", "jitter"), fill = names)


## ---- echo=FALSE, fig.height=4.4----------------------------------------------
ggplot(data = data, aes(names, value, fill = names)) + geom_violin()


## ---- fig.align="center"------------------------------------------------------
violin <- ggplot(data = iris, aes(x = Species, y = Sepal.Length)) +
  geom_violin(trim = FALSE, fill = "grey70", alpha = .5) +
  labs(title = "Graphique en forme de violon")
violin


## ---- fig.align="center"------------------------------------------------------
violin + 
  geom_jitter(shape = 16, position = position_jitter(0.2), alpha = .3) +
  geom_boxplot(width = .05)


## ---- fig.height=5, fig.width=4-----------------------------------------------
ggplot(mtcars, aes(cyl, mpg)) +
  geom_point() +
  stat_summary(fun = "mean", geom = "point",
               colour = "red", size = 5) +
  labs(title = "Moyenne")


## ---- fig.height=5, fig.width=4-----------------------------------------------
ggplot(mtcars, aes(cyl, mpg)) +
  geom_point() +
  stat_summary(fun.data = "mean_cl_boot", 
               colour = "red", size = 2) +
  labs(title = "Moyenne et intervalle de confiance")


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
# install.packages("patchwork")
library(patchwork)
iris.dens + cars.dens +
  plot_annotation(tag_levels = 'a')


## ---- fig.align='center',fig.height=4-----------------------------------------
data(msleep)
msleep.defi4 <- ggplot(msleep, aes(vore, log10(brainwt), fill = vore))
msleep.defi4 + geom_violin() +
  geom_signif(comparisons = list(c("herbi", "insecti"))) +
  labs(main = "Poids du cerveau pour les différents -vores", y = "log10(Poids du cerveau (Kg))") +
  scale_fill_grey() +
  theme_classic()


## ---- fig.align='center', fig.width=5, fig.height=4---------------------------
data(mtcars)
mtcars.short <- mtcars[1:20,]
mtcars.short.hc <- hclust(dist(mtcars.short), "complete")
dendro.defi4 <- ggdendrogram(mtcars.short.hc, rotate = TRUE, theme_dendro = FALSE)
dendro.defi4 + ggtitle("Dendrogramme des voitures selon les spécifications du moteur") +
  xlab("Voitures") +
  theme(axis.title.y = element_text(size = 16), axis.title.x = element_blank(),
        axis.text.x = element_blank(), axis.text.y = element_text(size = 12),
        plot.title = element_text(size = 14, face = "bold"))


## ---- echo = TRUE, fig.width=8, fig.height=5----------------------------------
library(plotly)
p <- ggplot(iris,
            aes(x = Sepal.Length, y = Sepal.Width, colour = Species, shape = Species)) +
  geom_point(size = 6, alpha = 0.6)

ggplotly(p)


## ---- eval=FALSE--------------------------------------------------------------
## mon_1er_graph <- ggplot(iris, aes(Petal.Length, Petal.Width)) +
##   geom_point()
## 
## ggsave("mon_1er_graph.pdf",
##        mon_1er_graph,
##        height = 8.5, width = 11, units = "in", res = 300)


## ---- eval=FALSE--------------------------------------------------------------
## pdf("./graph_du_jour.pdf")
##   print(mon_1er_graph) # la fonction print est nécessaire
## graphics.off()

