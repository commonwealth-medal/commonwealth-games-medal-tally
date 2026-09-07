urllist <- read.csv("Output\\01_linklist.csv")
names(urllist) <- c("x", "url")

medal_list <- list()
link_list <- list()

for (i in 1:nrow(urllist)) {
  
  print(paste0(i, "- Now accessing: ", urllist$url[i]))
  
  urlbase <- stringr::str_remove(urllist$url[i], "\\/([^\\/]+)\\/?$")
    
  webpage <- xml2::read_html(urllist$url[i])
  
  medals <- rvest::html_nodes(webpage, "ul > li > a")
  medals <- rvest::html_text(medals)
  
  links <- rvest::html_nodes(webpage, "ul > li > a")
  links <- rvest::html_attr(links, "href")
  links <- paste0(urlbase, "/", links)
  
  medal_list[[i]] <- medals
  link_list[[i]] <- links
  
  Sys.sleep(4.5)
}

full_link_list <- unlist(link_list)
full_medal_list <- unlist(medal_list)

full_link_list <- unique(full_link_list)
full_medal_list <- unique(full_medal_list)

write.csv(full_link_list, "Output\\02_medallist.csv")
