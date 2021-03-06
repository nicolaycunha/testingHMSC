# Trying everything again... 

# Libraries ---------------------------------------------------------------
# Load the libraries
library(HMSC)
library(doParallel)
library(tidyverse)


# Functions ---------------------------------------------------------------
# Load the functions
source("functions/prep_pars_fx.R")
source("functions/metacom_sim_fx.R")
# These functions are using the quadratic response
source("functions/main_sim_fx.R")
source("functions/full_process_fx.R")

# OrigLandscape -----------------------------------------------------------

XY <- readRDS("outputs/fixedLandscapes/orig-no-seed-XY.RDS")
E <- readRDS("outputs/fixedLandscapes/orig-no-seed-E.RDS")
MEMsel <- readRDS("outputs/fixedLandscapes/orig-no-seed-MEMsel.RDS")



#############################################################################
# Figures 2a and 2c... over a range of niche breadth without species interactions
# Create folder to save outputs -------------------------------------------

savedate <- format(Sys.Date(), "%Y%m%d")
folderpath <- paste0("outputs/", savedate, "-breadth_w_o_interactions/")

if(dir.exists(folderpath) == FALSE){
  dir.create(folderpath)
}


# Breadth terms -----------------------------------------------------------

values <- seq(from = 0.2, to = 2, by = 0.1)

# Run cycles --------------------------------------------------------------

for(j in 1:length(values)){
  namesrds <- paste0("scenario", j)
  
  pars <- prep_pars(N = 1000, D = 1, R = 15,
                    nicheOpt = NULL, breadth = values[j], alpha = 0.005,
                    interx_col = 0, interx_ext = 0, makeRDS = TRUE, whereToSave = folderpath, objName = namesrds)
  
  sims <- metacom_sim4HMSC(XY = XY, E = E, pars = pars,
                           nsteps = 200, occupancy = 0.8, niter = 5,
                           makeRDS = TRUE, whereToSave = folderpath, objName = namesrds)
  
  model <- metacom_as_HMSCdata(sims, numClusters = 4, E = E, MEMsel = MEMsel,
                               makeRDS = TRUE, whereToSave = folderpath, objName = namesrds)
  
  vpSpp <- get_VPresults(model, MEMsel = MEMsel, numClusters = 4,
                         makeRDS = TRUE, whereToSave = folderpath, objName = namesrds)
  
  vpSites <- get_VPresults_SITE(model, MEMsel = MEMsel, numClusters = 4,
                                makeRDS = TRUE, whereToSave = folderpath, objName = namesrds)
  
}

#############################################################################
# Figures 2b and 2d... over a range of niche breadth WITH species interactions
# Create folder to save outputs -------------------------------------------

savedate <- format(Sys.Date(), "%Y%m%d")
folderpath <- paste0("outputs/", savedate, "-breadth_with_interactions/")

if(dir.exists(folderpath) == FALSE){
  dir.create(folderpath)
}


# Breadth terms -----------------------------------------------------------

values <- seq(from = 0.2, to = 2, by = 0.1)

# Run cycles --------------------------------------------------------------

for(j in 1:length(values)){
  namesrds <- paste0("scenario", j)
  
  pars <- prep_pars(N = 1000, D = 1, R = 15,
                    nicheOpt = NULL, breadth = values[j], alpha = 0.005,
                    interx_col = 1.5, interx_ext = 1.5, makeRDS = TRUE, whereToSave = folderpath, objName = namesrds)
  
  sims <- metacom_sim4HMSC(XY = XY, E = E, pars = pars,
                           nsteps = 200, occupancy = 0.8, niter = 5,
                           makeRDS = TRUE, whereToSave = folderpath, objName = namesrds)
  
  model <- metacom_as_HMSCdata(sims, numClusters = 4, E = E, MEMsel = MEMsel,
                               makeRDS = TRUE, whereToSave = folderpath, objName = namesrds)
  
  vpSpp <- get_VPresults(model, MEMsel = MEMsel, numClusters = 4,
                         makeRDS = TRUE, whereToSave = folderpath, objName = namesrds)
  
  vpSites <- get_VPresults_SITE(model, MEMsel = MEMsel, numClusters = 4,
                                makeRDS = TRUE, whereToSave = folderpath, objName = namesrds)
  
}
