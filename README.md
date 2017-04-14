hilight   [![Follow](https://img.shields.io/twitter/follow/tylerrinker.svg?style=social)](https://twitter.com/intent/follow?screen_name=tylerrinker)
============


[![Build
Status](https://travis-ci.org/trinker/hilight.svg?branch=master)](https://travis-ci.org/trinker/hilight)
[![Coverage
Status](https://coveralls.io/repos/trinker/hilight/badge.svg?branch=master)](https://coveralls.io/r/trinker/hilight?branch=master)
<a href="https://img.shields.io/badge/Version-0.0.1-orange.svg"><img src="https://img.shields.io/badge/Version-0.0.1-orange.svg" alt="Version"/></a>
</p>

**hilight** is an **R** package to allow for easier highlighting of text
substrings as an HTML file.


Table of Contents
============

-   [Usage](#usage)
-   [Installation](#installation)
-   [Examples](#examples)
    -   [Mark Words](#mark-words)
    -   [Mark Word Stems](#mark-word-stems)
    -   [Mark Regex](#mark-regex)
    -   [Mark Sentences](#mark-sentences)
        -   [Example 1: Words](#example-1-words)
        -   [Example 2: End Marks](#example-2-end-marks)
-   [Contact](#contact)

Usage
============


The user goes through the following process:

1.  Generate a template via `highlight_template` with css markup for
    `mark` tags with classes and colors
2.  Generate a body using the `mark` family of functions (more below)
3.  Insert the body into `highlight_template` output with `insert_body`
4.  Generate an HTML file with `tempalte2html`

The user can generate a highlight marked body character vector to insert
into the html document using four functions:

<table>
<thead>
<tr class="header">
<th>Function</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>mark_words</code></td>
<td>Highlight specific words</td>
</tr>
<tr class="even">
<td><code>mark_word_stems</code></td>
<td>Highlight word stems</td>
</tr>
<tr class="odd">
<td><code>mark_regex</code></td>
<td>Highlight by regex</td>
</tr>
<tr class="even">
<td><code>mark_sentences</code></td>
<td>Highlight sentences by <code>grepl</code></td>
</tr>
</tbody>
</table>

These mark functions markup the body string with html `mark` tags with a
class that was supplied to `highlight_template`. These also correspond
to a color in the css in the `highlight_template` output.

Installation
============

To download the development version of **hilight**:

Download the [zip
ball](https://github.com/trinker/hilight/zipball/master) or [tar
ball](https://github.com/trinker/hilight/tarball/master), decompress and
run `R CMD INSTALL` on it, or use the **pacman** package to install the
development version:

    if (!require("pacman")) install.packages("pacman")
    pacman::p_load_gh("trinker/hilight")

Examples
========

First and foremost the user will want to markup some content to insert
into the template body. The following examples show how to mark up the
content and generate a highlighted HTML document.

Mark Words
----------

Highlight specific words. Also note the **dplyr** syntax that may make
ordering a bit more understandable. Notice that we generate highlighted
content and then put that into an HTML template.

    x <-"I like good cheese but hate Bad cheese"
    words <- c("cheese", "like", "good", "bad")
    marks_class <- c("neutral", "pos", "pos", "neg")
    marks <- c(pos = "lightgreen", neg = "pink", neutral = "yellow")
    body <- mark_words(x, words, marks_class)

    ## To an external file
    template2html(insert_body(highlight_template(marks), body))
    open_html()

    ## dplyr Syntax
    library(dplyr)

    marks %>%
        highlight_template() %>%
        insert_body(body) %>%
        template2html()

    open_html()

![](tools/figure/c1.png)

Mark Word Stems
---------------

Highlight word stems. For example `cheese` matches "cheese" and
"cheeses". Give the shortest possible substring as a stem.

    x <-"I like good cheeses but she hated Bad cheese"
    stems <- c("cheese", "like", "good", "bad")
    marks_class <- c("neutral", "pos", "pos", "neg")
    marks <- c(pos = "lightgreen", neg = "pink", neutral = "yellow")
    body <- mark_word_stems(x, stems, marks_class)

    ## To an external file
    template2html(insert_body(highlight_template(marks), body))
    open_html()

![](tools/figure/c2.png)

Mark Regex
----------

Highlight based on regexes. Ths is the most flexible but takes knowledge
of regular expressions.

    x <-"I like good cheeses but she hated Bad cheese.  Really hates it"
    regex <- c("chees[^ ]*\\b", "like", "hate[^ ]*\\b", "good", "bad\\b")
    marks_class <- c("neutral", "pos", "neg", "pos", "neg")
    marks <- c(pos = "lightgreen", neg = "pink", neutral = "yellow")

    body <- mark_regex(x, regex, marks_class)

    ## To an external file
    template2html(insert_body(highlight_template(marks), body))
    open_html()

![](tools/figure/c3.png)

Mark Sentences
--------------

Highlight sentences if they meet a condition (If multiple conditions are
met the first condition that is met will be highlighted). This
essentially splits content into sentences and uses a `grepl` to
determine if a condition is met.

### Example 1: Words

    x <- c("I like good cheeses but she hated Bad cheese.  Do you?",
        "This is realy bad!", "I drank water.  I wanted juice but like it. Why not?")

    regex <- c("chees[^ ]*\\b", "like", "hate[^ ]*\\b", "good", "bad\\b")
    marks_class <- c("neutral", "pos", "neg", "pos", "neg")
    marks <- c(pos = "lightgreen", neg = "pink", neutral = "yellow")

    body <- mark_sentences(x, regex, marks_class)

    ## To an external file
    template2html(insert_body(highlight_template(marks), body))
    open_html()

![](tools/figure/c4.png)

### Example 2: End Marks

    regex <- c("\\.$", "\\?$", "\\!$")
    marks_class <- c("statment", "question", "exclamation")
    marks <- c(statment = "lightgreen", question = "pink", exclamation = "orange")

    body <- mark_sentences(x, regex, marks_class)

    ## To an external file
    template2html(insert_body(highlight_template(marks), body))
    open_html()

![](tools/figure/c5.png)

Contact
=======

You are welcome to:    
- submit suggestions and bug-reports at: <https://github.com/trinker/hilight/issues>    
- send a pull request on: <https://github.com/trinker/hilight/>    
- compose a friendly e-mail to: <tyler.rinker@gmail.com>    