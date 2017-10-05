#' @title Coordinate finder
#'
#' @description The 'coord' function is a function that convert the address to the coordinates.
#'
#' @param address A character string that includes address components
#'
#' @return A dataframe cointaining full address names as well as the coordinates
#'
#' @examples
#' coord(address = "Chang Sha, China")
#'
#' @export
coord<- function(address = NULL){

  #Intial
  if(is.null(address) | !is.character(address)){
    stop("input should be acharacter")
  }

  #Creating query and using GET verb
  address <- gsub("[[:space:]]","+",address)
  url <- "https://maps.googleapis.com/maps/api/geocode/json?address="
  key <- "&key=AIzaSyCnjsC4BPd2_cEQof7cG7NLpO0wTlxCEqw"
  url <- paste0(url,address,key)
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
