#' Generate an HTML/CSS Style
#'
#' Generate an HTML/CSS style syntax for highlight marker tags.  Useful in
#' \pkg{knitr}/\pkg{rmarkdown} style documents.
#'
#' @param marker_color A named list or vector of colors.  The colors will be used
#' for highlighting and the names will correspond to the class name of the marker
#' tag.
#' @return Returns a vector with an HTML/CSS style template.
#' @export
#' @examples
#' marks <- c(pos = "lightgreen", neg = "pink", neutral = "yellow")
#' highlight_style(marks)
#'
#' ## A .Rmd Example
#' ## 1. Read the lines below into `content`
#' ## 2. Paste together and `cat` a file out
#' ## 3. `render` via rmarkdown package
#' ## 4. Open the html document
#' \dontrun{
#' content <- readLines(n=26)
#' ---
#' title: "Test"
#' date: "`r format(Sys.time(), '%d %B, %Y')`"
#' output:
#'   html_document:
#'     toc: true
#'     theme: journal
#'     number_sections: true
#' ---
#'
#' ```{r, echo=FALSE}
#' pacman::p_load(hilight)
#' x <-"I like good cheeses but she hated Bad cheese"
#' stems <- c("cheese", "like", "good", "bad")
#' marks_class <- c("neutral", "pos", "pos", "neg")
#' marks <- c(pos = "lightgreen", neg = "pink", neutral = "yellow")
#' body <- mark_word_stems(x, stems, marks_class)
#' ```
#'
#' ```{r, echo=FALSE, results='asis'}
#' highlight_style(marks)
#' ```
#'
#' ```{r, echo=FALSE, results='asis'}
#' cat(body)
#' ```
#'
#' cat(paste(content, collapse="\n"), "\n", file="test.Rmd")
#' rmarkdown::render("test.Rmd")
#' browseURL("test.html")
#' }
highlight_style <- function(marker_color){

    stopifnot(length(names(marker_color)) == length(marker_color))
    marker_color <- unlist(marker_color)
    marks <- sprintf(paste(mark_temp, collapse="\n"), names(marker_color), marker_color)

    out <- sprintf(paste(style, collapse="\n"), paste(marks, collapse="\n"), "%s")
    class(out) <- c("highlight_style", class(out))
    out
}


style <- c("<style>", "%s", "h1 { ",
    "    display: block;", "    font-size: 1.2em;", "    margin-top: 0.0em;",
    "    margin-bottom: 0.0em;", "    margin-left: 0;", "    margin-right: 0;",
    "    font-weight: bold;", "}", ".indented {", "    margin-left: 5%%%%;",
    "    margin-right: 5%%%%;", "}", "</style>")



#' Prints a highlight_style Object
#'
#' Prints a highlight_style object.
#'
#' @param x The highlight_style object.
#' @param pretty logical.  If \code{TRUE} \code{\link[base]{cat}} will be used
#' to print the object.
#' @param \ldots Other arguments passed to \code{\link[base]{cat}}
#' @method print highlight_style
#' @export
print.highlight_style <- function(x, pretty = TRUE, ...){
    if(isTRUE(pretty)){
        cat(x, ...)
    } else {
        print(as.character(x))
    }
    return(invisible(x))
}


