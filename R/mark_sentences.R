#' Mark Words Containing Regex With Class for Highlighting
#'
#' \code{mark_sentences} - Mark sentences containing regex with a class for highlighting.
#'
#' @param x A character vector with regex to operate on.
#' @param regex The regex to search for.
#' @param marks_class The classes to apply to word (must be equal to regex in
#' length).  These are dictated by the css generated for marks in
#' \code{highlight_template}.
#' @param ignore.case logical.  If \code{TRUE} case is ignored.
#' @return Returns a character vector with mark tags added around sentences that
#' contain the regex.
#' @importFrom data.table data.table
#' @family mark functions
#' @rdname mark_sentences
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
#'
#' ## `mark_sentences2`: predetermined classes per sentence
#' x <- c("I like it.  Well I like it some.",  "You lie!",
#'     "I do?  I try not to.  I suppose sometimes...")
#'
#' ## `classes` must be this length
#' length(unlist(split_sentences(x)))
#'
#' (body <- mark_sentences2(x, c("neg", "", "", "pos", "neutral", "")))
#' \dontrun{
#' ## To an external file
#' marks <- c(pos = "lightgreen", neg = "pink", neutral = "yellow")
#' template2html(insert_body(highlight_template(marks), p(body)))
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

#' Mark Words Containing Regex With Class for Highlighting
#'
#' \code{mark_sentences2} - Mark sentences predetemined class for highlighting.
#'
#' @param classes A predetermined vector of classes to apply to
#' \code{split_sentences(x)}.
#' @return Returns a character vector with mark tags added around predetermined
#' sentences.
#' @family mark functions
#' @rdname mark_sentences
#' @export
mark_sentences2 <- function(x, classes){

    sents <- get_sentences2(x)
    if(length(unlist(sents)) != length(classes)) {
        stop("`classes` must be equal in length the length of `split_sentences(x)`")
    }

    .<-NULL

    IDS <- add_row_id(sents)
    sents <- unlist(sents)

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

