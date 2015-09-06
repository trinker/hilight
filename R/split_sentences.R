#' Split Sentences
#'
#' Split sentences from a character vector.
#'
#' @param x A character vector with sentences.
#' @param \ldots Ignored.
#' @export
#' @return Returns a list of vectors of sentences.
#' @examples
#' (x <- paste0(
#'     "Mr. Brown comes! He says hello. i give him coffee.  i will ",
#'     "go at 5 p. m. eastern time.  Or somewhere in between!go there"
#' ))
#' split_sentences(x)
split_sentences <- function(x, ...) {
    lapply(lapply(get_sents2(x), function(x) gsub("<<<TEMP>>>", ".", x)),
        function(x) gsub("^\\s+|\\s+$", "", x))
}


