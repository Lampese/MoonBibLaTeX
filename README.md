# MoonBibLaTeX

A MoonBit Mooncake for parsing and writing BibTeX and BibLaTeX files.

## How to use

Install it to your project:

```shell
moon add Lampese/biblatex
```

And import this package in your `moon.pkg.json`:

```json
"import": [
    "Lampese/biblatex/biblatex"
]
```

Example:

```moonbit
let code=
  #|@article{CitekeyArticle,
  #|  author   = "P. J. Cohen",
  #|  title    = "The independence of the continuum hypothesis",
  #|  journal  = "Proceedings of the National Academy of Sciences",
  #|  year     = 1963,
  #|  volume   = "50",
  #|  number   = "6",
  #|  pages    = "1143--1148",
  #|}
let bib = @biblatex.Bibliography::parse(resource).stringify()
// @article{CitekeyArticle,author = "P. J. Cohen", title = "The independence of the continuum hypothesis", journal = "Proceedings of the National Academy of Sciences", year = 1963, volume = "50", number = "6", pages = "1143--1148"}
```

## Jabber

The [Offical Format Explanation](https://www.bibtex.com/g/bibtex-format/) is too imprecise (for example, some Fields are not applicable to any Entry, while some Entries do not exist in the Field adaptation table), so I can only guess or refer to some other people's implementations on my own.

Regarding escape characters:
- For escape characters unique to biblatex such as `\{` `\}`, special handling will be applied.
- For `{` `}` written to preserve capitalization and include content, it will be automatically processed.
- For some LaTeX macros (such as `\url{}`, etc.) and their nested structures, they will be preserved.
- The escape of Unicode will be retained.
