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
#' @family mark functions
#' @export
#' @examples
#' x <-"I like good cheeses but she hated Bad cheese.  Really hates it"
#' regex <- c("chees[^ ]*\\b", "like", "hate[^ ]*\\b", "good", "bad\\b")
#' marks_class <- c("neutral", "pos", "neg", "pos", "neg")
#' marks <- c(pos = "lightgreen", neg = "pink", neutral = "yellow")
#'
#' (body <- mark_regex(x, regex, marks_class))
#' \dontrun{
#' ## To an external file
#' template2html(insert_body(highlight_template(marks), body))
#' open_html()
#' }
#'
mark_regex <- function(x, regex, marks_class, ignore.case = FALSE){
    stopifnot(length(regex) == length(marks_class))

    reps <- paste0(mark_start(marks_class), "\\1", mark_end)
    .mgsub(paste0("\\b(", regex, "[^ ]*\\b)"), reps, text.var = x, fixed=FALSE,
        ignore.case = ignore.case)
}



