#' Insert the Body Into a Template
#'
#' Insert the body into a template that has been created using
#' \code{highlight_template}.
#'
#' @param template A template that has been created using
#' \code{highlight_template}.
#' @param body The text body (a character vector).
#' @return Returns a template with a body inserted (character vector).
#' @export
#' @examples
#' marks <- c(pos = "lightgreen", neg = "pink", neutral = "yellow")
#'
#' temp <- highlight_template(marks)
#' body <- paste0("I like <mark class=\"pos\">good</mark>",
#'     " <mark class=\"neutral\">fish</mark>",
#'     ", but <mark class=\"neg\">bad</mark> <mark class=\"neutral\">fish</mark>",
#'     " is <mark class=\"neg\">gross</mark>.")
#'
#' template2html(insert_body(highlight_template(marks), body), file="")
#' \dontrun{
#' ## To an external file
#' template2html(insert_body(highlight_template(marks), body))
#' open_html()
#' }
insert_body <- function(template, body){

    if (!methods::is(template, "highlight_template")) stop("Use the output from `highlight_template`")
    out <- sprintf(template, body)
    class(out) <- c("insert_body", class(out))
    out
}
