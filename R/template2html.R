#' Generate an HTML FIle from Finished Template
#'
#' Generate an HTML file from a template that has been created using
#' \code{highlight_template} and \code{insert_body}.
#'
#' @param template A template thate has been created using
#' \code{highlight_template} and \code{insert_body}.
#' @param file A file to output to.  Use \code{file = ""} to print to console.
#' @param protect logical.  If \code{TRUE} only allows a tempalte from
#' \code{insert_body}.  Use \code{FALSE} to override this behavior.
#' @param \ldots Other arguments passed to \code{\link[base]{cat}}.
#' @return Returns the HTML vector that was used to produce \code{file}.
#' @export
#' @examples
#' marks <- c(pos = "lightgreen", neg = "pink", neutral = "yellow")
#' \dontrun{
#' template2html(highlight_template(marks), file="", protect=FALSE)
#' }
#'
#' temp <- highlight_template(marks)
#' body <- paste0("I like <mark class=\"pos\">good</mark>",
#'     " <mark class=\"neutral\">fish</mark>",
#'     ", but <mark class=\"neg\">bad</mark> <mark class=\"neutral\">fish</mark>",
#'     " is <mark class=\"neg\">gross</mark>.")
#'
#' template2html(insert_body(highlight_template(marks), body), file="")
#'
#' \dontrun{
#' ## To an external file
#' template2html(insert_body(highlight_template(marks), body))
#' open_html()
#' }
template2html <- function(template, file = "out.html", protect = TRUE, ...){

    if (protect && !methods::is(template, "insert_body")) stop("Use the output from `insert_body`")
    cat(template, file = file, ...)

    return(invisible(template))
}
