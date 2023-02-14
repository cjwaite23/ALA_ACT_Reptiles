# ALA_ACT_Reptiles

# Author: Callum Waite

Repository for my data visualisation exercise for ALA. In this repository you will find some short amounts of R code to produce a visualisation of ALA reptile data in the ACT.

I have chosen to produce a small infographic exploring the rise in citizen science relative to other sources of biological observations. To do this, I had to summarise the various sources of information as specified in the *"DataResourceUid"* column of the initial dataset, by referring to their definitions and help-pages provided in the citations dataset. I have informally (but hopefully accurately) classified each of the 22 sources as either Government initiatives, Museums, or Citizen Science.

Thank you, and I hope you enjoy my figure.

**Repository Contents**

***1_Data***

Contains all relevant data downloaded directly from ALA with link provided by Dr Martin Westgate. Note that I utilise both the *citation.csv* file and the *records-2023-02-14.csv* file

***2_Data_Manipulation***

The .R script in this file contains all code I wrote to initially manipulate the data into a format suitable for plotting. The .RData file contains the data I require for plotting.

***3_Figure_Production***

The .R script here contains the code required to produce my final figure. It saves the image in pdf format.

***4_Figures***

*ALA_reptile_plot.pdf* is my final figure.
