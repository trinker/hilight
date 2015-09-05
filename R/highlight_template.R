#' Generate an HTML Highlight Template
#'
#' Generate an HTML syntax with css for highlight marker tags that takes a body
#' insert and can then be used to generate an HTML output with text highlighting.
#'
#' @param marker_color A named list or vector of colors.  The colors will be used
#' for highlighting and the names will correspond to the class name of the marker
#' tag.
#' @return Returns a vector with an HTML read template.
#' @export
#' @examples
#' marks <- c(pos = "lightgreen", neg = "pink", neutral = "yellow")
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
highlight_template <- function(marker_color){

    stopifnot(length(names(marker_color)) == length(marker_color))
    marker_color <- unlist(marker_color)
    marks <- sprintf(paste(mark_temp, collapse="\n"), names(marker_color), marker_color)

    out <- sprintf(paste(html, collapse="\n"), paste(marks, collapse="\n"), "%s")
    class(out) <- c("highlight_template", class(out))
    out
}

mark_temp <- c(
    "mark.%s {",
    "    background-color: %s;",
    "    color: black;",
    "}"
)

html <- c("<!DOCTYPE html>", "<html lang=\"en\">", "", "<head>", "<meta charset=\"utf-8\">",
    "<title>Highlighting</title>", "</head>", "", "<style>", "%s", "h1 { ",
    "    display: block;", "    font-size: 1.2em;", "    margin-top: 0.0em;",
    "    margin-bottom: 0.0em;", "    margin-left: 0;", "    margin-right: 0;",
    "    font-weight: bold;", "}", ".indented {", "    margin-left: 5%%%%;",
    "    margin-right: 5%%%%;", "}", "</style>", "", "<body>", "",
    "%s", "", "</body>", "", "</html>")





