#' cc_search options
#'
#' @name ccafs-search
#' @export
#' @details `cc_params` is a list with slots matching the
#' parameters in [cc_search()] - so you can more easily
#' get to the options you want to pass in to that function.
#'
#' The options are also listed below.
#'
#' @section file set options:
#' 
#' - 12: Delta Method IPCC AR5
#' - 4: Delta Method IPCC AR4
#' - 9: MarkSim Pattern Scaling
#' - 10: Eta South America
#' - 7: PRECIS Andes
#' - 8: CORDEX
#' - 11: Disaggregation IPCC AR4
#' - 3: Delta Climgen
#' - 2: Delta Method IPCC AR4 (Climgen Data)
#' - 5: Delta Method IPCC AR4 (Stanford Data)
#' - 6: Delta Method IPCC AR3
#'
#' @section scenario options:
#' 
#' - 1: Baseline
#' - 2: SRES A1B
#' - 3: SRES A2A
#' - 4: SRES B2A
#' - 5: SRES A2
#' - 6: SRES B1
#' - 7: RCP 2.6
#' - 8: RCP 4.5
#' - 9: RCP 6.0
#' - 10: RCP 8.5
#'
#' @section model options:
#' 
#' - 1: baseline
#' - 42: bcc_csm1_1
#' - 43: bcc_csm1_1_m
#' - 2: bccr_bcm2_0
#' - 44: bnu_esm
#' - 45: cccma_cancm4
#' - 46: cccma_canesm2
#' - 3: cccma_cgcm2_0
#' - 4: cccma_cgcm3_1_t47
#' - 5: cccma_cgcm3_1_t63
#' - 47: cesm1_bgc
#' - 48: cesm1_cam5
#' - 49: cesm1_cam5_1_fv2
#' - 50: cesm1_fastchem
#' - 51: cesm1_waccm
#' - 52: cmcc_cesm
#' - 53: cmcc_cm
#' - 54: cmcc_cms
#' - 6: cnrm_cm3
#' - 55: cnrm_cm5
#' - 56: csiro_access1_0
#' - 57: csiro_access1_3
#' - 7: csiro_mk2
#' - 8: csiro_mk3_0
#' - 25: csiro_mk3_5
#' - 58: csiro_mk3_6_0
#' - 59: ec_earth
#' - 60: fio_esm
#' - 9: gfdl_cm2_0
#' - 61: gfdl_cm2_1
#' - 10: gfdl_cm2_1
#' - 62: gfdl_cm3
#' - 63: gfdl_esm2g
#' - 64: gfdl_esm2m
#' - 11: giss_aom
#' - 65: giss_e2_h
#' - 66: giss_e2_h_cc
#' - 67: giss_e2_r
#' - 68: giss_e2_r_cc
#' - 26: giss_model_eh
#' - 27: giss_model_er
#' - 38: hadcm_cntrl
#' - 39: hadcm_high
#' - 40: hadcm_low
#' - 41: hadcm_midi
#' - 12: hccpr_hadcm3
#' - 13: iap_fgoals1_0_g
#' - 28: ingv_echam4
#' - 37: inm_cm3_0
#' - 69: inm_cm4
#' - 14: ipsl_cm4
#' - 70: ipsl_cm5a_lr
#' - 71: ipsl_cm5a_mr
#' - 72: ipsl_cm5b_lr
#' - 73: lasg_fgoals_g2
#' - 74: lasg_fgoals_s2
#' - 15: miroc3_2_hires
#' - 16: miroc3_2_medres
#' - 75: miroc_esm
#' - 76: miroc_esm_chem
#' - 77: miroc_miroc4h
#' - 78: miroc_miroc5
#' - 17: miub_echo_g
#' - 34: mohc_hadam3p_2
#' - 35: mohc_hadam3p_3
#' - 79: mohc_hadcm3
#' - 31: mohc_hadcm3q0
#' - 33: mohc_hadcm3q16
#' - 32: mohc_hadcm3q3
#' - 80: mohc_hadgem2_cc
#' - 81: mohc_hadgem2_es
#' - 29: mpi_echam4
#' - 18: mpi_echam5
#' - 30: mpi_echam5
#' - 82: mpi_esm_lr
#' - 83: mpi_esm_mr
#' - 84: mpi_esm_p
#' - 19: mri_cgcm2_3_2a
#' - 85: mri_cgcm3
#' - 20: ncar_ccsm3_0
#' - 86: ncar_ccsm4
#' - 21: ncar_pcm1
#' - 87: ncc_noresm1_m
#' - 88: ncc_noresm1_me
#' - 36: ncep_r2
#' - 22: nies99
#' - 89: nimr_hadgem2_ao
#' - 23: ukmo_hadcm3
#' - 24: ukmo_hadgem1
#'
#' @section period options:
#' 
#' - 1: 1970s
#' - 10: 1990s
#' - 2: 2000s
#' - 3: 2020s
#' - 4: 2030s
#' - 5: 2040s
#' - 6: 2050s
#' - 7: 2060s
#' - 8: 2070s
#' - 9: 2080s
#'
#' @section variable options:
#' 
#' - 1: Bioclimatics
#' - 6: Diurnal Temperature Range
#' - 3: Maximum Temperature
#' - 4: Mean Temperature
#' - 5: Minimum Temperature
#' - 2: Precipitation
#' - 7: Solar Radiation
#' - 9999: Other
#'
#' @section resolution options:
#' 
#' - 1: 30 seconds
#' - 2: 2.5
#' - 3: 5 minutes
#' - 4: 10 minutes
#' - 5: 30 minutes
#' - 6: 25 minutes
#' - 7: 20 minutes

cc_params <- list(
  file_set = list("Delta method IPCC AR5" = 12,
                  "Delta method IPCC AR4" = 4,
                  "MarkSim Pattern Scaling" = 9,
                  "Eta South America" = 10,
                  "PRECIS Andes" = 7,
                  "CORDEX" = 8,
                  "Disaggregation IPCC AR4" = 11,
                  "Delta Climgen" = 3,
                  "Delta Method IPCC AR4 (Climgen Data)" = 2,
                  "Delta Method IPCC AR4 (Stanford Data)" = 5,
                  "Delta Method IPCC AR3" = 6),
  scenario = list("Baseline" = 1,
                  "SRES A1B" = 2,
                  "SRES A2A" = 3,
                  "SRES B2A" = 4,
                  "SRES A2" = 5,
                  "SRES B1" = 6,
                  "RCP 2.6" = 7,
                  "RCP 4.5" = 8,
                  "RCP 6.0" = 9,
                  "RCP 8.5" = 10),
  model = list("baseline" = 1,
               "bcc_csm1_1" = 42,
               "bcc_csm1_1_m" = 43,
               "bccr_bcm2_0" = 2,
               "bnu_esm" = 44,
               "cccma_cancm4" = 45,
               "cccma_canesm2" = 46,
               "cccma_cgcm2_0" = 3,
               "cccma_cgcm3_1_t47" = 4,
               "cccma_cgcm3_1_t63" = 5,
               "cesm1_bgc" = 47,
               "cesm1_cam5" = 48,
               "cesm1_cam5_1_fv2" = 49,
               "cesm1_fastchem" = 50,
               "cesm1_waccm" = 51,
               "cmcc_cesm" = 52,
               "cmcc_cm" = 53,
               "cmcc_cms" = 54,
               "cnrm_cm3" = 6,
               "cnrm_cm5" = 55,
               "csiro_access1_0" = 56,
               "csiro_access1_3" = 57,
               "csiro_mk2" = 7,
               "csiro_mk3_0" = 8,
               "csiro_mk3_5" = 25,
               "csiro_mk3_6_0" = 58,
               "ec_earth" = 59,
               "fio_esm" = 60,
               "gfdl_cm2_0" = 9,
               "gfdl_cm2_1" = 61,
               "gfdl_cm2_1" = 10,
               "gfdl_cm3" = 62,
               "gfdl_esm2g" = 63,
               "gfdl_esm2m" = 64,
               "giss_aom" = 11,
               "giss_e2_h" = 65,
               "giss_e2_h_cc" = 66,
               "giss_e2_r" = 67,
               "giss_e2_r_cc" = 68,
               "giss_model_eh" = 26,
               "giss_model_er" = 27,
               "hadcm_cntrl" = 38,
               "hadcm_high" = 39,
               "hadcm_low" = 40,
               "hadcm_midi" = 41,
               "hccpr_hadcm3" = 12,
               "iap_fgoals1_0_g" = 13,
               "ingv_echam4" = 28,
               "inm_cm3_0" = 37,
               "inm_cm4" = 69,
               "ipsl_cm4" = 14,
               "ipsl_cm5a_lr" = 70,
               "ipsl_cm5a_mr" = 71,
               "ipsl_cm5b_lr" = 72,
               "lasg_fgoals_g2" = 73,
               "lasg_fgoals_s2" = 74,
               "miroc3_2_hires" = 15,
               "miroc3_2_medres" = 16,
               "miroc_esm" = 75,
               "miroc_esm_chem" = 76,
               "miroc_miroc4h" = 77,
               "miroc_miroc5" = 78,
               "miub_echo_g" = 17,
               "mohc_hadam3p_2" = 34,
               "mohc_hadam3p_3" = 35,
               "mohc_hadcm3" = 79,
               "mohc_hadcm3q0" = 31,
               "mohc_hadcm3q16" = 33,
               "mohc_hadcm3q3" = 32,
               "mohc_hadgem2_cc" = 80,
               "mohc_hadgem2_es" = 81,
               "mpi_echam4" = 29,
               "mpi_echam5" = 18,
               "mpi_echam5" = 30,
               "mpi_esm_lr" = 82,
               "mpi_esm_mr" = 83,
               "mpi_esm_p" = 84,
               "mri_cgcm2_3_2a" = 19,
               "mri_cgcm3" = 85,
               "ncar_ccsm3_0" = 20,
               "ncar_ccsm4" = 86,
               "ncar_pcm1" = 21,
               "ncc_noresm1_m" = 87,
               "ncc_noresm1_me" = 88,
               "ncep_r2" = 36,
               "nies99" = 22,
               "nimr_hadgem2_ao" = 89,
               "ukmo_hadcm3" = 23,
               "ukmo_hadgem1" = 24),
  extent = list("global" = "global",
                "region" = "region"),
  format = list("ascii" = "ascii",
                "esri" = "esri"),
  period = list("1970s" = 1,
                "1990s" = 10,
                "2000s" = 2,
                "2020s" = 3,
                "2030s" = 4,
                "2040s" = 5,
                "2050s" = 6,
                "2060s" = 7,
                "2070s" = 8,
                "2080s" = 9),
  variable = list("Bioclimatics" = 1,
                  "Diurnal Temperature Range" = 6,
                  "Maximum Temperature" = 3,
                  "Mean Temperature" = 4,
                  "Minimum Temperature" = 5,
                  "Precipitation" = 2,
                  "Solar Radiation" = 7,
                  "Other" = 9999),
  resolution = list("30 seconds" = 1,
                    "2.5 minutes" = 2,
                    "5 minutes" = 3,
                    "10 minutes" = 4,
                    "30 minutes" = 5,
                    "25 minutes" = 6,
                    "20 minutes" = 7),
  tile = list("A1" = "A1",
              "A2" = "A2",
              "A3" = "A3",
              "A4" = "A4",
              "A5" = "A5",
              "A6" = "A6",
              "B1" = "B1",
              "B2" = "B2",
              "B3" = "B3",
              "B4" = "B4",
              "B5" = "B5",
              "B6" = "B6",
              "C1" = "C1",
              "C2" = "C2",
              "C3" = "C3",
              "C4" = "C4",
              "C5" = "C5",
              "C6" = "C6")
)
