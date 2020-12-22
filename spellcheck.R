allowed.file <- "USTBook-spellcheck-allowed.csv"

do_spellcheck <- function() {
  allowed.words <- character()
  if(file.exists(allowed.file))
    allowed.words <- read.csv(allowed.file)$x
  res <- spelling::spell_check_files(list.files(pattern="Rmd"))
  idx <- which(!res[,1] %in% allowed.words)
  if (length(idx) == 0) {
    message("No spelling errors found.")
    return(data.frame())
  }
  return(data.frame(x   = res[idx,][[1]], 
                    loc = unlist(lapply(res[idx,][[2]], paste0, collapse=","))))
}

x <- do_spellcheck()
View(x)
# write.csv(data.frame(x = x$x), file = allowed.file)
