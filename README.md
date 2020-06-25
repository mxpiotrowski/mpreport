# mparticle and mpreport

The *mparticle* and *mpreport* LaTeX document classes are attempts at a more modern layout for articles and reports.  See my [dissertation](http://dynalabs.de/mxp/assets/diss.pdf) or my [master’s thesis](http://dynalabs.de/mxp/assets/ma-as-report.pdf) for examples of documents formatted with mpreport.

The classes can be used as a direct replacement for the standard *article* and *report* classes.  There are, however, some minor differences:

- *mparticle* and *mpreport* use A4 as default page format; if you want a different page format, add the appropriate option (e.g., `letterpaper` or `a5paper`).
- *mparticle* and *mpreport* place figure and table captions in the margin.  To ensure the correct placement, `\caption{}` must be placed **before** the figure or table proper, for example:

  ```
  \begin{table}[!ht]
	\caption{This is the table caption}
	\begin{tabular}{|l|l|}
	  .
	  .
	  .
	\end{tabular}
	\label{tab:terms}
  \end{table}
  ```
- *mparticle* and *mpreport* provide a `\subtitle{}` macro for specifying a subtitle.
- *mpreport* automatically loads the *graphicx* package, i.e., it is not necessary to specify `\usepackage{graphicx}`.


# Source and Feedback

The source of this package is maintained at <https://github.com/mxpiotrowski/mpreport>.  This site also allows you file issues in case you encounter problems with the package.

# License

Copyright © 2020 by Michael Piotrowski

This package may be distributed under the terms of the LaTeX Project Public License, as described in lppl.txt in the base LaTeX distribution. Either version 1.3 or, at your option, any later version.
