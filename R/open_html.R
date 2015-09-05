#' Open an HTML File With Default Browser
#'
#' Open an HTML file with default browser.
#'
#' @param x An HTML file to open.
#' @param \ldots Other arguments passed to \code{\link[utils]{browseURL}}.
#' @keywords open
#' @export
#' @seealso \code{\link[utils]{browseURL}}
open_html <-
function (x = "out.html", ...) {
    utils::browseURL(x, ...)
}

