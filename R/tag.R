#' Wrapp Text With HTML Tags
#'
#' Wrap text with select HTML tags.  \code{tag} is generic in comparison to
#' specific tag types such as \code{p}.
#'
#' @param x A text string.
#' @param left A left tag.
#' @param right A right tag.
#' @param extra Additional arguments to pass to a left tag such as styling.
#' @return Returns a vector of strings wrpped in HTML tags.
#' @rdname tag
#' @export
#' @examples
#' tag(LETTERS, "<iframe>")
#'
#' p(LETTERS)
#' h1(paste0(LETTERS, ": ", em(letters)))
#' p(paste(b(LETTERS), 1:26, letters))
#'
#' span(LETTERS)
#' set.seed(10)
#' (body <-p(span(LETTERS, extra=sprintf("style=\"color:%s\"", sample(colors(), 26)))))
#' \dontrun{
#' template2html(insert_body(highlight_template(c(x="")), body))
#' open_html()
#' }
tag <- function(x, left, right = gsub("^<", "</", left)){
    paste0(left, x, right)
}

#' @rdname tag
#' @export
p <- function(x) tag(x, "<p>")

#' @rdname tag
#' @export
h1 <- function(x) tag(x, "<h1>")

#' @rdname tag
#' @export
h2 <- function(x) tag(x, "<h2>")

#' @rdname tag
#' @export
h3 <- function(x) tag(x, "<h3>")

#' @rdname tag
#' @export
h4 <- function(x) tag(x, "<h4>")

#' @rdname tag
#' @export
span <- function(x, extra = "") tag(x, sprintf("<span %s>", extra), "</span>")

#' @rdname tag
#' @export
b <- function(x) tag(x, "<b>")

#' @rdname tag
#' @export
em <- function(x) tag(x, "<em>")

#' @rdname tag
#' @export
u <- function(x) tag(x, "<u>")

