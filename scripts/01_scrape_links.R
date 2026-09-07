link_list <- list()

for (i in 1:26) {
  
  print(paste0("Hello, ", letters[i]))
  
  url <- paste0("https://medals.org.uk/index-", letters[i], ".htm")
  
  webpage <- xml2::read_html(url)
  
  #polities <- rvest::html_nodes(webpage, "td:nth-child(2) a")
  #polities <- rvest::html_text(polities)
  #polities <- polities[!polities %in% "Links"]
  
  links <- rvest::html_nodes(webpage, "td:nth-child(4) a")
  links <- rvest::html_attr(links, "href")
  links <- paste0("https://medals.org.uk/", links)
  
  link_list[[i]] <- links
  
  Sys.sleep(7)
}

link_list <- unlist(link_list)

write.csv(link_list, "Output\\01_linklist.csv")
