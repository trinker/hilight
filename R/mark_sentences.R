#' Mark Words Containing Regex With Class for Highlighting
#'
#' Mark words containing regex with a class for highlighting.
#'
#' @param x A character vector with regex to operate on.
#' @param regex The regex to search for.
#' @param marks_class The classes to apply to word (must be equal to regex in
#' length).  These are dictated by the css generated for marks in
#' \code{highlight_template}.
#' @param ignore.case logical.  If \code{TRUE} case is ignored.
#' @return Returns a character vector with mark tags added around words that
#' contain the regex.
#' @importFrom data.table data.table
#' @family mark functions
#' @export
#' @examples
#' x <- c("I like good cheeses but she hated Bad cheese.  Do you?",
#'     "This is realy bad!", "I drank water.  I wanted juice but like it. Why not?")
#'
#' ## Example 1: Words
#' regex <- c("chees[^ ]*\\b", "like", "hate[^ ]*\\b", "good", "bad\\b")
#' marks_class <- c("neutral", "pos", "neg", "pos", "neg")
#' marks <- c(pos = "lightgreen", neg = "pink", neutral = "yellow")
#'
#' (body <- mark_sentences(x, regex, marks_class))
#' \dontrun{
#' ## To an external file
#' template2html(insert_body(highlight_template(marks), body))
#' open_html()
#' }
#'
#' ## Example 2: End Marks
#' regex <- c("\\.$", "\\?$", "\\!$")
#' marks_class <- c("statment", "question", "exclamation")
#' marks <- c(statment = "lightgreen", question = "pink", exclamation = "orange")
#'
#' (body <- mark_sentences(x, regex, marks_class))
#' \dontrun{
#' ## To an external file
#' template2html(insert_body(highlight_template(marks), body))
#' open_html()
#' }
mark_sentences <- function(x, regex, marks_class, ignore.case = FALSE){
    stopifnot(length(regex) == length(marks_class))

    .<-NULL

    sents <- get_sentences2(x)
    IDS <- add_row_id(sents)
    sents <- unlist(sents)

    classes <- data.frame(stats::setNames(lapply(regex, function(x) stringi::stri_detect_regex(sents, x)),
        marks_class), check.names = FALSE)


    classes <- title_tag_table(classes)

    starts <- mark_start(classes)
    starts[is.na(classes)] <- ""
    ends <- rep(mark_end, length(classes))
    ends[is.na(classes)] <- ""

    dat <- data.table::data.table(
        sents = paste0(starts, sents, ends),
        ID =IDS
    )

    dat[, list(sents = paste(sents, collapse=" ")), by="ID"][["sents"]]

}


