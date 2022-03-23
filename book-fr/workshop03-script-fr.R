##Section: 01-introduction.R 

###Avis ###
#                                                                            #
#Ceci est un script généré automatiquement basé sur les morceaux de code du  #
#livre pour cet atelier.                                                     #
#                                                                            #
#Il est minimalement annoté pour permettre aux participants de fournir leurs #
#commentaires : une pratique que nous encourageons vivement.                 #
#                                                                            #
#Notez que les solutions aux défis sont également incluses dans ce script.   #
#Lorsque vous résolvez les défis par vous-méme, essayez de ne pas parcourir  #
#le code et de regarder les solutions.                                       #
#                                                                            #
#Bon codage !                                                               #


# Installez les librairies requises
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


##Section: 02-visualization-en-science.R 




##Section: 03-mecanique-ggplot2.R 

str(penguins) # regardons les données des pingouins !



class(penguins) # vérifier la classe des données pour s'assurer qu'il s'agit d'un data.frame ou d'un tibble pour ggplot2

# vous pouvez transformer un ensemble de données en tibble via la fonction as_tibble() si nécessaire
# peng <- tibble::as_tibble(penguins) 
# class(peng)

Voir un aperçu général de nos données avec plusieurs types de graphiques
ggpairs(penguins, 
        aes(colour = species),
        progress = FALSE) + 
  theme_bw() 

# Explorons comment nos données sont structurées par espèce
ggplot(data = penguins,               # Données
       aes(x = bill_length_mm,        # Valeurs X
           y = bill_depth_mm,         # Valeurs Y
           col = species)) +          # Esthétique (mettre une couleur par espèce)
  geom_point(size = 5, alpha = 0.8) + # Points
  geom_smooth(method = "lm") +        # Régression linéaire
  labs(title = "Relationship between bill length and depth\nfor different penguin species", # Title
       x = "Bill length (mm)", # titre de l'axe des X
       y = "Bill depth (mm)", # titre de l'axe des Y
       col = "Species") +  # Légende pour les couleurs dans aes(col = species)
  theme_classic() + # Utiliser un thème propre
  theme(title = element_text(size = 18, face = "bold"),
      text = element_text(size = 16))





# Couche 1: Données
ggplot(data = penguins) 
# Sans autre information, vos données ne seront pas visualisées.

# Prochaine couche: esthétiques
# Ici, nous disons à R de tracer la longueur sur l'axe des x, et la profondeur sur l'axe des y.
# mais nous n'avons toujours pas dit à R comment nous voulons que ces données soient représentées...
ggplot(data = penguins, 
       aes(x = bill_length_mm, 
           y = bill_depth_mm)) 
# Vous voyez ? Nos variables sont maintenant assignées aux axes x et y, 
# mais rien n'est encore tracé.

# Prochaine couche(s): géométries
ggplot(data = penguins, 
       aes(x = bill_length_mm, 
           y = bill_depth_mm)) + # Utilisez le signe + pour ajouter chaque couche
  geom_point() # La couche geom détermine le type de tracé que nous utilisons.
               # geom_point() trace les données sous forme de points !

# Prochaine couche(s): customizations!
# Les facettes divisent un graphique en fenêtres séparées selon une certaine catégorie dans les données.
ggplot(data = penguins, 
       aes(x = bill_length_mm, 
           y = bill_depth_mm)) +
  geom_point() + 
  facet_wrap(vars(species)) # Cela divise le graphique en trois fenêtres : une par espèce.

ggplot(data = penguins,
       aes(x = bill_length_mm,
           y = bill_depth_mm)) +
  geom_point() +
  facet_wrap(vars(species)) +
  # ceci transforme les coordonnées des axes avec log10()
  coord_trans(x = "log10", y = "log10")

ggplot(data = penguins,
       aes(x = bill_length_mm,
           y = bill_depth_mm)) +
  geom_point() +
  facet_wrap(vars(species)) +
  coord_trans(x = "log10", y = "log10") +
  # ce thème produit un rendu visuel plus attrayant
  theme_bw()



# Défi 1 ----
# 
# Créez un ggplot pour répondre aux questions suivantes:
# 1. Y a-t-il une relation entre la longueur des becs et la longueur des nageoires des pingouins?
# 2. La longueur des becs augmente-t-elle avec celle des nageoires?




# SOLUTION # -----

# Faire un nuage de points pour visualiser la relation entre nos variables
ggplot(data = penguins, 
       aes(x = bill_length_mm,
           y = flipper_length_mm)) +
  geom_point()

# Personnalisez la forme et la couleur des points 
ggplot(data = penguins,
       aes(x = bill_length_mm,
           y = flipper_length_mm)) +
  geom_point(shape = 2, color = "blue") 


##Section: 04-esthetique.R 

ggplot(penguins,
       aes(x = bill_length_mm,
           y = bill_depth_mm)) +
  geom_point(aes(colour = species)) +
  labs(title = "Couleurs qualitatives \npour des groupes",
       x = "Longueur du bec (mm)",
       y = "Profondeur du bec (mm)",
       col = "Espèce") +
  theme(title = element_text(size = 16, face = "bold"),
        legend.title = element_text(size = 14),
        legend.position = 'bottom')

ggplot(penguins,
       aes(x = bill_length_mm,
           y = bill_depth_mm)) +
  geom_point(aes(colour = log10(body_mass_g))) +
  labs(title = "Gradient de couleurs \npour des valeurs",
       x = "Longueur du bec (mm)",
       y = "Profondeur du bec (mm)",
       col = "Masse corporelle (g)") +
  theme(title = element_text(size = 16, face = "bold"),
        legend.title = element_text(size = 14),
        legend.position = 'bottom')

# No colour mapping
ggplot(data = penguins,
       aes(x = bill_length_mm,
           y = flipper_length_mm)) +
  geom_point() +
  geom_smooth(method = lm)+
  labs(title = "Sans code de couleur",
       x = "Longueur du bec (mm)",
       y = "Profondeur du bec (mm)")

# Avec code de couleur
ggplot(data = penguins,
       aes(x = bill_length_mm,
           y = flipper_length_mm,
           col = species)) + # l'argument col met une couleur par espèce
  geom_point() +
  geom_smooth(method=lm) +
  labs(title = "Avec code de couleur",
       x = "Longueur du bec (mm)",
       y = "Profondeur du bec (mm)")

# Défaut

# Permettre à ggplot d'assigner un code de couleurs aux espèces
pp <- ggplot(data = penguins) +
  geom_point(aes(x = bill_length_mm,
                 y = bill_depth_mm,
                 colour = species)) +
  labs(title = "Default",
       x = "Longueur du bec (mm)",
       y = "Profondeur du bec (mm)")
pp

# Créer un code de couleur manuellement

# En utilisant scale_colour_manual(),
# nous pouvons spécifier les couleurs précises que nous voulons utiliser
pp +
scale_colour_manual(
  # Notez que l'ordre des couleurs correspondra à
  # l'ordre des espèces indiqué dans la légende
  values = c("grey55", "orange", "skyblue"))

# Défaut

# L'utilisation de l'argument couleur dans aes() va utiliser une
# palette de couleurs par défaut pour créer notre gradient.
pp2 <- ggplot(data = penguins) +
  geom_point(aes(x = bill_length_mm,
                 y = bill_depth_mm,
                 colour = log10(body_mass_g))) +
  labs(title = "Défaut",
       x = "Longueur du bec (mm)",
       y = "Profondeur du bec (mm)")
pp2

# Manual

# En utilisant scale_colour_graduent,
# nous pouvons définir manuellement notre gradient de couleur.
pp2 +
  scale_colour_gradient(low = "blue",
                        high = "red") +
  labs(title = "Manuellement")
# Note : il existe aussi scale_colour_gradient2() pour créer un # gradient avec
# une valeur médiane pour les palettes divergentes.

require(RColorBrewer)
display.brewer.all()



# Palette pour des groupes
pp +
  scale_colour_brewer(palette = "Dark2") +
  labs(title = "Palette pour des groupes")

# Palette pour des variables continues
pp2 +
  scale_color_viridis_c()+
  labs(title = "Palette pour des variables continues")

# Palette pour groupes
pp +
  scale_colour_grey() +
  labs(title = "Palette pour des groups")

# Palette pour des variables continues
pp2 +
  scale_colour_gradient(low = "grey85", high = "black") +
  labs(title = "Palette for continuous values")

install.packages("colorBlindness")
library(colorBlindness)

cvdPlot(pp)  # Vérifions le résultat de notre graphique selon les différentes formes de daltonisme.

# Utilisons une palette viridis pour rendre notre graphique plus accessible.
pp_viridis <- pp +
      scale_colour_viridis_d() +
      labs(title = "Palette viridis palette pour des groupes")
pp_viridis

# Avons-nous réussi ? Utilisons cvdPlot() pour vérifier à nouveau.
cvdPlot(pp_viridis)
# On a réussi!

pp2_viridis <- pp2 +
        scale_colour_viridis_c() +
        labs(title = "Palette viridis pour des variables continues")
pp2_viridis

cvdPlot(pp2_viridis)

# changer la forme des points
ggplot(data = penguins) +
  geom_point(aes(x = bill_length_mm,
                 y = bill_depth_mm,
                 shape = species)) + # regrouper les données par formes
  labs(title = "Formes pour des groupes")

# size and alpha for continuous values
ggplot(data = penguins) +
  geom_point(aes(x = bill_length_mm,
                 y = bill_depth_mm,
                 size = body_mass_g, # regrouper les données par taille des points
                 alpha = flipper_length_mm)) + # code de transparence par longueur de nageoire
  labs(title = "Taille et transparence pour des variables continues")

# Défi 2 ----

# Créer un graphique informatif à partir de jeu de données disponible de R, comme mtcars, CO2 ou msleep.
# Utiliser les esthétiques appropriés pour différents types de données




# SOLUTION # -----

# Une de plusieurs solutions: mtcars
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

# Une autre solution
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


##Section: 05-peaufinage.R 

# Theme grey
pp + scale_colour_grey() + # Dessiner les points en gris
  theme_grey() + # Utiliser le fond gris
  labs(title = "Défaut: Thème gris") # Titre de la figure

pp + scale_colour_grey() + # Dessiner les points en gris
  theme_classic() + # Utiliser un fond blac
  labs(title = "Thème classique") # Titre de la figure

pp + scale_colour_grey() +
  theme_minimal() + # Utiliser un fond blanc et un quadrillage
  labs(title = "Thème minimal") 

# Définir le thème noir et blanc pour tous les figures qui suivent
theme_set(theme_bw()) # Note: le fond est blanc avec un cadre noir
pp

theme_update(
  panel.grid.minor = element_blank()) # Enlever le quadrillage 'minor'
pp





mytheme <- theme_bw() + # Vous pouvez partir d'un thème existant pour mettre en place certains éléments de base.
           theme(plot.title = element_text(colour = "red")) +
           theme(legend.position = c(0.9, 0.9))
pp + mytheme # A# Appliquez-le à votre figure!

install.packages("ggthemes")
library(ggthemes)

# Utilisons le thème du blog FiveThirtyEight et la palette de couleurs de Tableau.
pp + 
  theme_fivethirtyeight() + 
  scale_color_tableau()

# Utilisons le thème de Tufte "Données maximales, encre minimale".
pp + 
  theme_tufte()

ggplot(data = penguins) +
  geom_point(mapping = aes(x = bill_length_mm, 
                           y = bill_depth_mm, 
                           colour = species)) +
  facet_grid(~ species, 
             scales = "free") # l'échelle de l'axe des y peut varier entre les facettes.
# ne faites pas ceci si vous comparez des facettes via l'axe des y !

ggplot(data = penguins) +
  geom_point(mapping = aes(x = bill_length_mm, 
                           y = bill_depth_mm, 
                           colour = species)) +
  facet_grid(year ~ species, 
             scales = "free")

# Revenons à notre visualisation des données de pingouins. 
pp

# Ajuster les axes et les titres pour que le graphique parle par lui-même.
pp +
  # Mettre un titre pour la figure, les axes, et la légende
  labs(title = "Relationship between Bill Length & Depth",
       x = "Bill Length (mm)",
       y = "Bill Depth (mm)",
       col = "Species") +
  # adjuster la taille des titres
  theme(axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 16),
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        plot.title = element_text(size = 16, face="bold"), # mettre le titre en gras
        legend.title = element_text(size=14, face="bold"), # mettre le titre en gras
        legend.text = element_text(size=12))

# install and load the package
install.packages("reshape2")
library(reshape2)



# Défi 3 ----
# 
# UUtilisez les données tips qui se trouvent dans reshape2 pour reproduire le graphique dans le livre ou dans la présentation.
# Notre conseil: Allez-y étape par étape! Commencez par theme_classic() et ajoutez theme() pour faire vos changements supplémentaires.




# SOLUTION # -----

# Construire le graphique
tips.gg <- ggplot(tips,
                  # Étape 1. Spécifiez le mappage esthétique des axes et des légendes
                  aes(x = facture_totale,
                      y = pourboire/facture totale,
                      shape = fumeur,
                      couleur = sexe,
                      size = taille)) +
  # Étape 2. Spécifiez le geom utilisé pour représenter les données
  geom_point() +
  # Etape 3. Spécifiez la variable utilisée pour faire des facettes
  facet_grid( ~ time) +
  # Étape 4. Spécifiez l'échelle de couleur utilisée pour représenter le sexe
  scale_colour_grey() +
  # Étape 5. Étiquettez le titre et les axes du graphique
  labs(title = "Relation entre l'addition totale et les pourboires pendant le déjeuner et le dîner",
       x = "Facture totale ($)",
       y = "Rapport entre les pourboires et l'addition totale") +
  # Étape 6. Définissez le thème
  theme_classic() +
  # Étape 7. Personnalisez le thème pour qu'il corresponde à la taille et à la couleur des titres du graphique.
  theme(axis.title = element_text(size = 16,
                                  couleur = "navy"),
        axis.text = element_text(size = 12),
        plot.title = element_text(size = 16,
                                  couleur = "orange3",
                                  face = "bold"),
        # cette partie ajuste le texte dans les titres des facettes
        strip.text.x = element_text(size = 14, face="bold"))
# générez notre beau graphique !
tips.gg



theme_set(theme_bw())
theme_update(panel.grid.minor = element_blank(),
             axis.text = element_text(size = 16),
             axis.title = element_text(size = 18))

ggplot(penguins)

ggplot(penguins, 
       aes(x = bill_length_mm)) +
  geom_histogram() +
  ggtitle("Histogramme de la longeur des becs")

ggplot(mpg, 
       aes(x = displ, 
           y = hwy)) +
  geom_point() +
  labs(title = "Nuage de points")

ggplot(mpg, 
       aes(x = displ, 
           y = hwy)) +
  geom_point() +
  geom_smooth(method = lm) +
  labs(title = "Régression linéaire") 

ggplot(data = penguins, 
       aes(x = species, 
           y = bill_length_mm,
           fill = species)) + # définir espèce comme variable de groupe (par couleur)
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
  geom_violin(trim = FALSE, # ne pas tailler les extrémités des violons s'il y a des valeurs extrêmes
              fill = "grey70", # mettre tous les violons en gris
              alpha = .5) + # transparence de la couleur de remplissage
  labs(title = "Violin plot")
violin

violin + 
  # ce geom trace les points de données avec un peu de bruit supplémentaire (horizontal)
  # pour voir les points qui se chevauchent
    geom_jitter(shape = 16, 
                position = position_jitter(0.2),
              alpha = .3) +
  geom_boxplot(width = .05)

# tracer la médiane du nombre de cylindre
ggplot(mtcars, 
       aes(x = cyl, y = mpg)) +
  geom_point() +
  stat_summary(fun = "median", 
               geom = "point",
               colour = "red",
               size = 6) +
  labs(title = "Médiannes")

# Tracez la moyenne de chaque groupe avec des intervalles de confiance (par bootstrapping)
ggplot(mtcars, 
       aes(cyl, mpg)) +
  geom_point() +
  stat_summary(fun.data = "mean_cl_boot",
               colour = "red",
               size = 1.6) +
  labs(title = "Moyennes et intervalles de confiance")

# charger la librairie maps
library(maps)
states_map <- map_data("state") # obtient une carte des Etats-Unis à l'échelle des états

# Le nom de l'état est défini comme rownames. Créons une nouvelle colonne pour ceux-ci
# qui correspond à la colonne des noms d'états dans notre states_map.
USArrests$region <- tolower(rownames(USArrests))

# Construisons notre carte
ggplot(USArrests, 
       aes(map_id = region)) + # le nom de la variable pour lier notre carte et notre dataframe
  geom_map(aes(fill = Murder), # variable que nous voulons représenter avec une esthétique
           map = states_map) + # cadre de données qui contient des coordonnées
  expand_limits(x = states_map$long, 
                y = states_map$lat) +
  coord_map() + # projection 
  labs(x = "", y = "") # suppression des titres des axes

(peng.dens <- ggplot(penguins, 
                     aes(x = bill_length_mm)) +
   geom_density())

(cars.dens <- ggplot(cars, 
                    aes(x = dist)) +
   geom_density())

library(ggdendro)

USArrests.short <- USArrests[1:10,] # prendre un petit échantillon pour simplifier
hc <- hclust(dist(USArrests.short), "average") # regroupement par distance moyenne (UPGMA)

# visualiser le dendrogramme
ggdendrogram(hc, rotate = TRUE)

# charger patchwork pour arranger nos graphiques de densité
library(patchwork)

# les ajouter ensemble signifie "les placer les uns à côté des autres".
peng.dens + cars.dens +
  plot_annotation(tag_levels = 'a') # ajoute a) et b) à vos figures, afin de 
  # les mentionner ans les descriptions de vos figures.

# Défi 4 ----
# 
# Créez votre propre graphique et suivez ces recommandations :
#   * Jeu de données : n'importe lequel (recommandation : utilisez votre jeu de données)
#   * Explorez un nouveau `geom_*` et d'autres couches de graphiques
# 
# Utilisez les liens suivants pour obtenir des conseils :
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
  labs("Poids du cerveau pour les différents -vores", 
       y = "log10(Poids du cerveau (Kg))") +
  scale_fill_grey() +
  theme_classic()

data(mtcars)
# let's do some clustering!
mtcars.short <- mtcars[1:20,]
mtcars.short.hc <- hclust(dist(mtcars.short), "average")

ggdendrogram(mtcars.short.hc, rotate = TRUE) + 
  # fine-tuning
  labs(title = "Dendrogramme des voitures selon les spécifications du moteur", 
       y ="Voitures") +
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
# convertir en objet plotly!
ggplotly(p)


##Section: 06-sauvegarder.R 

my1stPlot <-  # Créer une figure pour pratiquer comment sauvegarder
  ggplot(penguins,
         aes(x = bill_length_mm,
             y = bill_depth_mm)) +
  geom_point()

ggsave(filename = "my1stPlot.pdf", # Nommez le fichier dans lequel vous voulez enregistrer, ajoutez l'extension du format de fichier que vous voulez utiliser (ex. pdf).
       plot = my1stPlot, # Fournir le nom de l'objet plot dans R
       height = 8.5, # Fournir les dimensions voulues
       width = 11,
       units = "in")

# Astuce : Les fonctions `quartz()` (mac) ou `window()` (pc) facilitent le dimensionnement avant `ggsave()` ! Tracez simplement votre ggplot dans quartz() ou window(), ajustez la taille jusqu'à ce qu'elle soit bonne, et lancez ggsave() avec le nom du fichier pour voir quelles dimensions vous avez utilisées ! Vous pouvez ensuite ajouter ceci dans votre code avec height = et width = comme indiqué ci-dessus.

my2ndPlot <-  # Créer un 2eme graphique pour pratiquer pdf()
  ggplot(penguins,
         aes(x = bill_length_mm,
             y = bill_depth_mm)) +
  geom_point()

pdf("./graph_du_jour.pdf")
  print(my1stPlot) # print() est nécessaire
  print(my2ndPlot)
graphics.off()


##Section: 07-conclusion.R 




