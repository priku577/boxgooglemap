#' @title boxgooglemap: Transfer between address and coordinates use the google geocode API.
#' @description Transfer between address and coordinates use the google geocode API.
#' @author Maintainer: Boxi Zhang bossyzhang@gmail.com
#' @references \url{https://developers.google.com/maps/documentation/geocoding/start}
#' @docType package
#' @name boxgooglemap
NULL



#' @title address
#'
#' @description The 'address' function is a function that convert the coordinates to address.
#'
#' @param latlong A character string.
#'
#' @return A dataframe cointaining full address information
#'
#' @examples
#' address(latlong = "58.39701, 15.57415")
#'
#' @export
address <- function(latlong = NULL){

  #Intial
  if(is.null(latlong) | !is.character(latlong)){
    stop("input should be character")
  }

  if(!grepl("[[:digit:]]|[[:punct:]]",latlong)){
    stop("input should be digits")
  }

grab <- function(x){

    x <- gsub("([[:space:]]|[[:punct:]])\\1+", "\\1", x)
    x <- gsub("[[:space:]]|[^[:alnum:],.+-]",",",x)
    x <- gsub("([[:punct:]])\\1+", "\\1", x)
    return(x)
  }

  latlong <- grab(latlong)
  url <- "https://maps.googleapis.com/maps/api/geocode/json?latlng="
  key <- "&key=AIzaSyCnjsC4BPd2_cEQof7cG7NLpO0wTlxCEqw"
  url <- paste0(url,latlong,key)
  get_res <- httr::GET(url)



  if(!grepl("^2",httr::status_code(get_res))){
    stop(httr::message_for_status(get_res))
  } else {

    content_res <- httr::content(get_res)
    geometry_res <- lapply(content_res[["results"]], "[[", "geometry")
    coord <- as.data.frame(t(sapply(geometry_res, "[[", "location")))
    full_adress <- unlist(lapply(content_res[["results"]], "[[", "formatted_address"))

    res_df <- data.frame("Full_address" = full_adress,
                         "lat" = unlist(coord[,1]),
                         "lng" = unlist(coord[,2]),
                         stringsAsFactors = FALSE)

    rownames(res_df) <- NULL

    if(nrow(res_df) == 0){
      stop("No match found")
    }

    return(res_df)
  }
}



