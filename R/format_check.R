drop_na <- function(x) {
  index <- is.na(x)
  x <- x[!index]
  return(x)
}



#' format check
#'
#' @param format_list 
#' @param data 
#'
#' @return an informative error message if data does not pass validation
format_check <- function(format_list, data) {
  error_vector <- c()
  for (name in names(format_list)) {
    if (format_list[[name]][["required"]] & (!name %in% names(data))) { #if not required and not in data iteration continues
      error_vector <- paste0(error_vector, "DATA FORMAT ERROR: Column ", name," is missing or incorrectly named. ")
    }
    if (name %in% names(data)) { #if not in data we do not check format
      #check for missing values if they are not supported
      if(!"basic" %in% names(format_list[[name]])) {
        if (any(is.na(data[[name]])) & !format_list[[name]][["missing"]]) {
          error_vector <- paste0(error_vector, "DATA FORMAT ERROR: Column" , name," has missing values. Missing values not supported for this column. ")
        }
        #if missing values are supported we need to exclude them to past the next set of tests
        clean_column <- data[[name]] %>% drop_na()
        if (format_list[[name]][["type"]] == "range") {
          if (!(all(clean_column >= min(format_list[[name]][["valid"]])) &  all(clean_column <= max(format_list[[name]][["valid"]])))) {
            error_vector <- paste0(error_vector, "DATA FORMAT ERROR: Column ", name, " has one or more values which fall outside of valid range. ")
          }
        }
        if (format_list[[name]][["type"]] == "value") {
          if (!all(clean_column %in% format_list[[name]][["valid"]])) {
            error_vector <- paste0(error_vector, "DATA FORMAT ERROR: Column ", name, " has one or more values which are not allowed. ")
          }
        }
      }
    } # end what is done if column is found in user data
  }# end of loop through all columns
  if (!is.null(error_vector)) {
    stop(error_vector)
  }
} # end function



