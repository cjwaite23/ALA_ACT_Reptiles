##### Description #####
# This is an R Script for the production of an animated figure based on a subset of 
# ALA reptile data in the ACT, Australia

##### Libraries #####
library(extrafont)
library(remotes)
remotes::install_version("Rttf2pt1", version = "1.3.8")
loadfonts(device = "win")
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
  family = factor(levels, levels = levels),
  label = paste(levels, c("(Skinks)", "(Dragons)", "(Geckos)", "(Legless Lizards)", "(Elapid Snakes)", "(Freshwater Turtles)")))

titles <- tibble(
  year = c(1963, 1963),
  no_of_obs = c(650, 550),
  family = factor(c("Scincidae", "Scincidae"), levels = levels),
  size = c("big", "small"),
  label = c("**The Rise of Citizen Science: Reptiles**",
            "A visualisation of the recorded sightings of reptile species from the six most observed Reptilia families in the ACT, Australia, since 1965. Sightings are grouped vertically into plots by family. The size of the coloured streams represent the amount of sightings of a family sourced from citizen science, government, and museum citations in a given year.")
)

# Set the font
font = "Montserrat"

##### Plotting of Figure
stream_plot1 <- reptiles_plotting_data %>%
  ggplot() +
  theme_classic() +
  # set theme parameters
  theme(text = element_text(family = font, colour = "gray10"),
        axis.line = element_line(colour = "gray10"),
        axis.ticks = element_line(colour = "gray10"),
        axis.text = element_text(colour = "gray10"),
        strip.background = element_blank(),
        strip.text = element_blank(),
        panel.spacing.y = unit(c(0.2, 0.2, 0.2, 0.6, 0.6), "cm")) +
  # plot streams
  geom_stream(aes(x = year, y = no_of_obs, fill = factor(citation_type)),
              type = "ridge") +
  # facet the plot by family
  facet_grid(family ~ .,
             space = "free",
             scales = "free_y") +
  # add family labels
  geom_text(data = labels,
            aes(x = year, y = no_of_obs, label = label),
            hjust = 0, vjust = 0, 
            col = "gray20", family = font, fontface = "bold") +
  geom_textbox(data = titles,
               aes(x = year, y = no_of_obs, label = label, size = size),
               hjust = 0, vjust = 1,
               col = "gray10", family = font,
               height = unit(2, "cm"),
               width = unit(17, "cm"),
               fill = "grey95",
               box.colour = NA) +
  scale_x_continuous(breaks = seq(1965, 2020, by = 5), limits = c(1963, 2023)) +
  scale_fill_manual(values = c("#80b1d3", "#fdb462", "#b3de69")) +
  scale_size_manual(values = c("big" = 8, "small" = 3.5)) +
  xlab("Year") + ylab("Number of Observations") +
  guides(size = "none") +
  labs(fill = "Citation Type",
       caption = "Visualisation: Callum Waite • Data: Atlas of Living Australia (2023)")

ggsave(plot = stream_plot1,
       filename = "4_Figures/stream_plot.pdf",
       device = cairo_pdf,
       width = 12, height = 8, units = "in")









