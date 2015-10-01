#' Mark Words Containing Stems With Class for Highlighting
#'
#' Mark words containing stems with a class for highlighting.
#'
#' @param x A character vector with stems to operate on.
#' @param stems The word stems to search for.
#' @param marks_class The classes to apply to word (must be equal to stems in
#' length).  These are dictated by the css generated for marks in
#' \code{highlight_template}.
#' @param ignore.case logical.  If \code{TRUE} case is ignored.
#' @param \ldots Other arguments passed to \code{\link[base]{gsub}}.
#' @return Returns a character vector with mark tags added around words that
#' contain the stems.
#' @family mark functions
#' @export
#' @examples
#' x <-"I like good cheeses but she hated Bad cheese"
#' stems <- c("cheese", "like", "good", "bad")
#' marks_class <- c("neutral", "pos", "pos", "neg")
#' marks <- c(pos = "lightgreen", neg = "pink", neutral = "yellow")
#'
#' (body <- mark_word_stems(x, stems, marks_class))
#' \dontrun{
#' ## To an external file
#' template2html(insert_body(highlight_template(marks), body))
#' open_html()
#' }
#'
mark_word_stems <- function(x, stems, marks_class, ignore.case = TRUE, ...){
    stopifnot(length(stems) == length(marks_class))

    reps <- paste0(mark_start(marks_class), "\\1", mark_end)
    .mgsub(paste0("\\b(", stems, "[^ ]*\\b)"), reps, text.var = x, fixed=FALSE,
        ignore.case = ignore.case, ...)
}

