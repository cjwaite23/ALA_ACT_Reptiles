##### Description #####
# This is an R Script for the production of an animated figure based on a subset of 
# ALA reptile data in the ACT, Australia

##### Libraries #####
library(tidyverse)
library(gganimate)
library(magick)
library(patchwork)
library(ozmaps)
library(scales)
library(ggspatial)
library(RColorBrewer)
library(sf)

##### Load Data #####
load("2_Data_Manipulation/plotting_data.RData")

ACT_map <- st_read("1_Data/STE_2021_AUST_SHP_GDA2020") %>%
  st_transform(crs=4326) %>%
  filter(STE_NAME21 == "Australian Capital Territory")

##### Begin making heatmap
ggplot() +
  geom_sf(data = ACT_map, fill = "grey98", col = "grey30") +
  stat_density_2d(data = reptiles_plotting_data,
                  geom = "raster",
                  aes(x = decimalLongitude, y = decimalLatitude, fill = after_stat(density)),
             contour = FALSE) +
  theme_classic()


