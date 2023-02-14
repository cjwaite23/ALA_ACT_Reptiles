##### Description #####
# This is an R Script for the import, exploration and manipulation of the
# records-2023-02-14.csv file containing ALA records of reptiles in ACT, Australia

##### Libraries #####
library(tidyverse)
library(lubridate)


##### Load Data #####
reptiles <- read_csv(file = "1_Data/records-2023-02-14.csv") %>%
  # keep the columns of potential biological/analytical interest
  dplyr::select(institutionCode,
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

reptiles_small <- reptiles %>%
  dplyr::select()