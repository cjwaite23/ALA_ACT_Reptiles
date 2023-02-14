##### Description #####
# This is an R Script for the import, exploration and manipulation of the
# records-2023-02-14.csv file containing ALA records of reptiles in ACT, Australia

##### Libraries #####
library(tidyverse)

##### Load Data #####
citations <- read_csv(file = "1_Data/citation.csv")

reptiles <- read_csv(file = "1_Data/records-2023-02-14.csv") %>%
  # keep the columns of potential biological/analytical interest
  dplyr::select(dataResourceUid,
                institutionCode,
                collectionCode,
                datasetName,
                basisOfRecord,
                occurrenceID,
                catalogNumber,
                individualCount,
                preparations,
                disposition,
                otherCatalogNumbers,
                occurrenceRemarks,
                associatedOccurrences,
                eventDate,
                eventTime,
                year,
                month,
                day,
                habitat,
                island,
                country,
                stateProvince,
                locality...87,
                sensitive_locality,
                verbatimElevation,
                decimalLatitude,
                sensitive_decimalLatitude,
                decimalLongitude,
                sensitive_decimalLongitude,
                coordinateUncertaintyInMeters,
                coordinatePrecision,
                identificationID,
                identifiedBy,
                dateIdentified,
                identificationVerificationStatus,
                taxonID,
                taxonConceptID,
                scientificName,
                order,
                family,
                genus,
                species,
                specificEpithet,
                scientificNameAuthorship,
                vernacularName,
                recordID)

##### Produce a smaller subset of biologically relevant data #####
reptiles_small <- reptiles %>%
  dplyr::select(dataResourceUid,
                eventDate, year, month, day,
                decimalLatitude, decimalLongitude,
                vernacularName, scientificName, genus, family, order,
                basisOfRecord, individualCount)

##### Produce a smaller subset of citations used in this data #####
used_citations <- unique(reptiles$dataResourceUid)

citations_small <- citations %>%
  filter(UID %in% used_citations)

# Identify the families with > 100 observations in the dataset
over_100_obs_fams <- reptiles_small %>%
  # remove observations not identified to family level
  filter(!is.na(family)) %>%
  # count observations per family
  group_by(family) %>%
  summarise(total_obs = n(), .groups = "drop") %>%
  # select those with >100 observations
  filter(total_obs > 100)

##### Filtering the data to be useful for my purposes #####

reptiles_plotting_data <- reptiles_small %>%
  # Keep observations ID'd to family level
  filter(!is.na(family) &
           # remove observations without a year
           !is.na(year) &
           # remove observations before 1963 (too patchy before then)
           year >= 1963 &
           # remove coastal observations (only focus on inland ACT)
           decimalLongitude < 150 &
           # only keep the 6 most sighted families
           family %in% over_100_obs_fams$family) %>%
  arrange(year) %>%
  mutate(family = factor(family,
                         levels = c("Scincidae", "Agamidae", "Pygopodidae",
                                    "Gekkonidae", "Elapidae", "Chelidae"))) %>%
  group_by(year, family, dataResourceUid) %>%
  summarise(no_of_obs = n(), .groups = "drop")


save(reptiles_plotting_data, citations_small, 
     file = "2_Data_Manipulation/plotting_data.RData")

  