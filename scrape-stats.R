library(rvest)

gscholar_link <- "https://scholar.google.com/citations?user=IF5FDQUAAAAJ&hl=en"
readme_loc <- "README.md"

citations <- read_html(gscholar_link) %>%
  html_nodes("#gsc_rsb_st") %>%
  .[[1]] %>%
  html_table() %>%
  .[1, "All"]

# Download images in advance so we don't rely on img.shields.io at rendering time.
imgs <- list(
  cv = "https://img.shields.io/badge/CV--_.svg?style=social&logo=giphy",
  github = "https://img.shields.io/github/followers/jaredsofteng.svg?label=GitHub&style=social",
  linkedin = "https://img.shields.io/badge/LinkedIn--_.svg?style=social&logo=linkedin",
  sponsors = sprintf("https://img.shields.io/github/sponsors/jaredsofteng?label=Sponsors&style=social&logoColor=EA4AAA"),
  citations = sprintf("https://img.shields.io/badge/Citations-%sk-_.svg?style=social&logo=google-scholar", citations),
)

for (i in 1:length(imgs)) {
  download.file(imgs[[i]], sprintf('imgs/%s.svg', names(imgs)[[i]]), mode = 'wb')
}
