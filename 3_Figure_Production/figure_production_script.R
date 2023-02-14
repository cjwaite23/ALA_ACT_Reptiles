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
library(ggtext)

##### Load Data #####
load("2_Data_Manipulation/plotting_data.RData")

##### We shall try looking at how the sources of sightings are changing #####
levels <- levels(reptiles_plotting_data$family)
#Set up label data frame
labels <- tibble(
  year = 1963,
  no_of_obs = c(100, 100, 50, 30, 50, 50),
  family = factor(levels, levels = levels))

##### Plotting of Figure
stream_plot1 <- reptiles_plotting_data %>%
  ggplot() +
  geom_stream(aes(x = year, y = no_of_obs, fill = factor(citation_type)),
              type = "ridge") +
  facet_grid(family ~ .,
             space = "free",
             scales = "free_y") +
  geom_text(data = labels,
            aes(x = year, y = no_of_obs, label = family),
            hjust = 0, vjust = 0) +
  scale_x_continuous(breaks = seq(1965, 2020, by = 5)) +
  scale_fill_manual(values = c("#80b1d3", "#fdb462", "#b3de69")) +
  xlab("Year") + ylab("Number of Observations") +
  labs(fill = "Citation Type",
       title = "The Rise of Citizen Science",
       subtitle = "A visualisation of the recorded sightings of reptile species from the six most observed species in the ACT, Australia, since 1965. Sightings are grouped by family and the size of the coloured streams represent the amount of sightings of that family sourced from that particular citation type. All observations are sourced from the Atlas of Living Australia (ALA, 2023).") +
  theme_classic() +
  theme(strip.background = element_blank(),
        strip.text = element_blank(),
        panel.spacing.y = unit(c(0.2, 0.2, 0.2, 0.6, 0.6), "cm"),
        plot.title = element_text(face = "bold", size = 16),
        plot.subtitle = element_textbox_simple(size = 10, 
                                               lineheight = 1.2,
                                               margin = margin(t = 0, b = 4)))











