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
#'
#' ## More Elaborte Examples
#' \dontrun{
#' # EXAMPLE 1
#' data(presidential_debates_2012)
#'
#' ## What to search for
#' regex <- c(statement = "\\.$", question = "\\?$", exclamation = "\\!$", trailing = "\\|$")
#'
#' ## What to call the searched for elements
#' marks_class <- names(regex)
#'
#' ## Map of color to named elements
#' marks <- c(statement = "lightgreen", question = "pink", exclamation = "orange",
#'     trailing = "lightgray")
#'
#' ## Markup sentence by type
#' speech <- mark_sentences(presidential_debates_2012[["dialogue"]], regex, marks_class)
#'
#' ## Combine group variables and add <h> tags
#' person <- sapply(1:nrow(presidential_debates_2012), function(i) {
#'     x <- as.character(unlist(presidential_debates_2012[i, c("person", "time")]))
#'     h1(paste(x, collapse = ":"))
#' })
#'
#' ## Combine into the body
#' body <- p_(person, speech)
#'
#' ## Make a template with color mapping for mark markup
#' ## Insert the body into the template
#' ## Output the template to html
#' template2html(insert_body(highlight_template(marks), body))
#'
#' ## Open the html file
#' open_html()
#'
#' # EXAMPLE 2
#' data(sam_i_am)
#'
#' ## What to search for
#' regex1 <- c(statement = "\\.$", question = "\\?$", exclamation = "\\!$")
#' regex2 <- c(good = "\\b([Gg]ood|I like|I will(?! not))\\b", bad = "\\b([Nn]ot( like)*)\\b")
#'
#' ## What to call the searched for elements
#' marks_class <- names(c(regex1, regex2))
#'
#' ## Map of color to named elements
#' marks <- c(
#'        statement = "lightgray", question = "lightblue", exclamation = "yellow",
#'        bad = "pink", good = "lightgreen"
#' )
#'
#' ## Markup sentence by type
#' speech <- mark_words(sam_i_am, regex2, marks_class[4:5])
#' speech <- mark_sentences(speech, regex1, marks_class[1:3])
#'
#'
#' ## Combine into the body (need qdapTools package)
#' if (!require("pacman")) install.packages("pacman")
#' pacan::p_load(qdapTools)
#' body <- p(lapply(split_vector(speech), paste, collapse=" "))
#'
#' ## Make a template with color mapping for mark markup
#' ## Insert the body into the template
#' ## Output the template to html
#' template2html(insert_body(highlight_template(marks), body))
#'
#' ## Open the html file
#' open_html()
#' }
template2html <- function(template, file = "out.html", protect = TRUE, ...){

    if (protect && !methods::is(template, "insert_body")) stop("Use the output from `insert_body`")
    cat(template, file = file, ...)

    return(invisible(template))
}
