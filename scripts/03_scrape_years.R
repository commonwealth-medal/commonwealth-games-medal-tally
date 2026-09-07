medal_url <- read.csv("Output\\02_medallist.csv")
names(medal_url) <- c("x", "url")

medal_names <- list()
medal_names_sub <- list()
year_list <- list()
url_list <- list()

for (i in 1:nrow(medal_url)) {
  
  print(paste0(i, "- Now accessing: ", medal_url$url[i]))
    
  webpage <- xml2::read_html(medal_url$url[i])
  
  medal_name <- rvest::html_node(webpage, "h2")
  medal_name <- rvest::html_text(medal_name)
  
  medal_name_sub <- rvest::html_node(webpage, "h3")
  medal_name_sub <- rvest::html_text(medal_name_sub)

  yeartext <- rvest::html_text(webpage)
  yeartext <- stringr::str_extract(yeartext, "(?<=Instituted:).*(?=.|$)")
  yeartext <- trimws(yeartext)
  
  medal_names[[i]] <- medal_name
  medal_names_sub[[i]] <- medal_name_sub
  year_list[[i]] <- yeartext
  url_list[[i]] <- medal_url$url[[i]]
  
  Sys.sleep(2.6)
}

medal_names[sapply(medal_names, is.null)] <- NA
f_medal_names <- unlist(medal_names)

medal_names_sub[sapply(medal_names_sub, is.null)] <- NA
f_medal_names_sub <- unlist(medal_names_sub)

year_list[sapply(year_list, is.null)] <- NA
f_year_list <- unlist(year_list)

url_list[sapply(url_list, is.null)] <- NA
f_url_list <- unlist(url_list)

df <- data.frame("medal_name" = f_medal_names
                 , "medal_subname" = f_medal_names_sub
                 , "instituted" = f_year_list
                 , "url" = f_url_list)

write.csv(df, paste0("Output\\03_yearlist-", i, ".csv"))
