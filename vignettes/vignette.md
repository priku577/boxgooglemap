---
title: "boxgooglemap"
author: "Boxi Zhang, Priya Pullolickal"
date: "2017-10-03"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteIndexEntry{boxgooglemap}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---

 ##Introduction
  The mapuloh package is connected with the google geocode API to provide with location and and coordination of the information provided using two main functions: 
  
  
  - address_lookup
- coord_lookup

To use both functions, it is **required to have the package httr installed** 
  
  ## Functions usage
  
  ###addres_lookup
  
  address_lookup is a function that provides the user with the address of a given a set of coordinates The funtion uses the google geocode API to retrieve the result. The main parameter. 

The only input is **latlong**, a character string that includes the latitude and the longitude.

The function returns a dataframe cointaining Full address names as well as the coordinates:


```r
library(boxgooglemap)
head(address_lookup("41.40450 2.17429"), n = 5)
```

```
##                                       Full_address      lat      lng
## 1 Carrer de la Marina, 255, 08025 Barcelona, Spain 41.40455 2.174106
## 2         Sagrada Família, 08025 Barcelona, Spain 41.40450 2.174290
## 3             La Sagrada Familia, Barcelona, Spain 41.40448 2.175728
## 4                       Eixample, Barcelona, Spain 41.39184 2.164197
## 5                                 Barcelona, Spain 41.38506 2.173404
```

```r
tail(address_lookup("24.83504 118.608"), n = 5)
```

```
##                              Full_address      lat      lng
## 3 China, Quanzhou Shi, Jinjiang Shi, 涵口 24.83491 118.6083
## 4       Jinjiang, Quanzhou, Fujian, China 24.78168 118.5524
## 5                 Quanzhou, Fujian, China 24.87413 118.6757
## 6                           Fujian, China 26.48368 117.9249
## 7                                   China 35.86166 104.1954
```


###coord_lookup
The 'coord_lookup' function is a function that provides the user with the coordinates of a given address. The function uses the google geocode API to retrieve the result.

The input needed is **address**, a character string that includes address components.

If the address has partial match, different locations with their full names and  coordinates will be retrieved as a dataframe:

```r
library(boxgooglemap)
coord_lookup("Sagrada Familia, Barcelona")
```

```
##                                      Full_address      lat      lng
## 1 Carrer de Mallorca, 401, 08013 Barcelona, Spain 41.40363 2.174356
```

```r
coord_lookup("Mapuloh")
```

```
##                                     Full_address       lat      lng
## 1 Mapulo, Bayan ng Taysan, Batangas, Philippines 13.733747 121.1854
## 2 Mapulo, Malaybalay City, Bukidnon, Philippines  8.194049 125.2698
```
