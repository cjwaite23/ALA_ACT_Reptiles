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
library(ggstream)

##### Load Data #####
load("2_Data_Manipulation/plotting_data.RData")

ACT_map <- st_read("1_Data/STE_2021_AUST_SHP_GDA2020") %>%
  st_transform(crs=4326) %>%
  filter(STE_NAME21 == "Australian Capital Territory")

##### Begin making heatmap #####
ggplot() +
  geom_sf(data = ACT_map, fill = "grey98", col = "grey30") +
  stat_density_2d(data = reptiles_plotting_data,
                  geom = "raster",
                  aes(x = decimalLongitude, y = decimalLatitude, 
                      alpha = after_stat(density), fill = family),
             contour = FALSE) +
  facet_grid(rows = vars(family), cols = vars(year_interval)) +
  scale_alpha_continuous(name = "Reptile Observation Density",
                         trans = "log10",
                         range = c(0, 1),
                         limits = c(0.95, 100),
                         oob = squish) +
  theme_classic()

ggplotly(
ggplot() +
  geom_sf(data = ACT_map, fill = "grey98", col = "grey30") +
  geom_point(data = reptiles_plotting_data,
             aes(x = decimalLongitude, y = decimalLatitude,
                 colour = dataResourceUid),
             alpha = 0.3) +
  theme_classic()
)



##### We shall try looking at how the sources of sightings are changing #####
levels <- levels(reptiles_plotting_data$family)
#Set up label data frame
labels <- tibble(
  year = 1963,
  no_of_obs = c(600, 300, 300, 100, 150, 200),
  family = factor(levels, levels = levels))

##### Plotting of Figure
stream_plot1 <- reptiles_plotting_data %>%
  ggplot() +
  geom_stream(aes(x = year, y = no_of_obs, fill = dataResourceUid),
              type = "ridge") +
  facet_grid(family ~ .,
             space = "free",
             scales = "free_y") +
  geom_text(data = labels,
            aes(x = year, y = no_of_obs, label = family),
            hjust = 0, vjust = 0) +
  scale_x_continuous(breaks = seq(1965, 2020, by = 5)) +
  xlab("Year") + ylab("Number of Observations") +
  theme_classic() +
  theme(strip.background = element_blank(),
        strip.text = element_blank(),
        panel.spacing.y = unit(c(0.2, 0.2, 0.2, 0.6, 0.6), "cm"))











