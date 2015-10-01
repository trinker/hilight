#' Paste Wrappers - Preset Collapse
#'
#' \code{ah} - \code{\link[base]{paste}} with \code{collapse = " "}.  The name
#' comes from the interjection "ah" as in "Ah I don't need to type
#' \code{collapse = " "}."
#'
#' @param x A vector to collapse.
#' @param collapse An character string to separate the results.
#' @param \ldots Other arguments passed to \code{\link[base]{paste}}.
#' @return Returns a collapsed, pasted vector.
#' @rdname ah
#' @export
#' @examples
#' ah(LETTERS[1:8])
#' cat(nah(LETTERS[1:8]))
ah <- function(x, collapse = " ", ...){
    paste(x, collapse = collapse, ...)
}


#' Paste Wrappers-Preset Collapse
#'
#' \code{nah} - \code{\link[base]{paste}} with \code{collapse = "\n"}, useful
#' in concert with \code{\link[base]{cat}}.  The name is simpley \code{ah} +
#' \code{n} from \code{collapse = "\n"}.
#'
#' @rdname ah
#' @export
nah <- function(x, collapse = "\n", ...){
    paste(x, collapse = collapse, ...)
}
