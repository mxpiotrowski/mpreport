%
% mpreport, an attempt at a fancier report style
%

% NOTE:  This class automatically specifies the a4paper option and
%        loads the graphicx package.

% The class begins by announcing itself as |mpreport.cls|.
   \NeedsTeXFormat{LaTeX2e}
   \ProvidesClass{mpreport}[1996/12/15 A variant report class]

% It passes all specified options on to the |report| class.
   \DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
   \ProcessOptions

% It then loads the class |report|.
   \LoadClass[a4paper]{report}
   \usepackage{graphicx}

% The class then redefines |\maketitle|.
   \if@titlepage
   \renewcommand{\maketitle}{%
     \begin{titlepage}%
       % top line
       
       \hspace{-\mp@margwd}\rule{\mp@fullwd}{.25mm}%
       \vspace{-\baselineskip}\vspace{.25mm}%
       \par\hspace{-\mp@margwd}\rule{\mp@margwd}{2mm}%
       \par\hspace{-\mp@margwd}%

       % title

       \begin{flushright}
         \huge\sffamily\fontseries{mc}\slshape\bfseries
         \@author\\\@title\\\normalsize\@date
         \vfill
       \end{flushright}

       % bottom line
       \par
       \hspace{-\mp@margwd}%
       \rule{\mp@margwd}{2.25mm}%
       \hspace{-\mp@margwd}%
       \rule{\mp@fullwd}{.25mm}%
     \end{titlepage}%
     }
   \else
   \renewcommand{\maketitle}{%
     \begin{flushleft}
       \null\hfill
       \vskip 2cm
       \huge\sffamily\fontseries{mc}\slshape\bfseries
       \@title\\
       \large\mdseries\upshape
       \vspace{.5em}%
       \@author, \@date\\
                                % \rule{\textwidth}{.5mm}\\
     \end{flushleft}
     \@thanks
     \par
     \vskip 1cm
     }
   \fi

% It redefines |\chapter|.

   \renewcommand{\thechapter}{\arabic{chapter}}
   
   \renewcommand{\chapter}{%
     \secdef\@chapter\@schapter%
     }

   \renewcommand{\@chapter}[2][?]{%
     \clearpage%
     \refstepcounter{chapter}%
     \addcontentsline{toc}{chapter}{\protect\numberline{\thechapter} #1}%
     {%
       \parindent \z@ \raggedright \normalfont%
       \ifnum \c@secnumdepth >\m@ne%
       \par%
       \hspace{-\mp@margwd}\rule{\mp@fullwd}{.25mm}%
       \vspace{-\baselineskip}\vspace{.25mm}%
       \par\hspace{-\mp@margwd}\rule{\mp@margwd}{2mm}%
       \par\hspace{-\mp@margwd}%
       % typeset the chapter number
       \makebox[\mp@margwd][r]{%
         \fontsize{6\EX}{6\EX}\sffamily\thechapter
         }%
       \hfill%
       % set variables for the formatting of the chapter title
       \settoheight{\mp@chapnoht}{%
         \fontsize{6\EX}{6\EX}\bfseries\sffamily\thechapter}%
       \settoheight{\mp@chaptlht}{\parbox[b]{.9\textwidth}{%
           \raggedleft\Huge\sffamily\bfseries #1}}
       % set the chapter title                                %
       \raisebox{-\mp@chaptlht}{\raisebox{\mp@chapnoht}{%
           \parbox[b]{.9\textwidth}{\raggedleft\Huge\sffamily\bfseries #1}}}%
       \par\nobreak%
       \vskip\mp@margwd%
       }}

   \renewcommand{\@schapter}[1]{%        % for chapter*{...}
     {%
       \newpage%
       \par%
       \hspace{-\mp@margwd}\rule{\mp@fullwd}{.25mm}%
       \vspace{-\baselineskip}\vspace{.25mm}%
       \par\hspace{-\mp@margwd}\rule{\mp@margwd}{2mm}%
       \par\hspace{-\mp@margwd}%
       % don't typeset the chapter number
       \hfill%
       % set variables for the formatting of the chapter title
       \settoheight{\mp@chapnoht}{%
         \fontsize{6\EX}{6\EX}\bfseries\sffamily\thechapter}%
       \settoheight{\mp@chaptlht}{\parbox[b]{.9\textwidth}{%
           \raggedleft\Huge\sffamily\bfseries #1}}
       % set the chapter title                                %
       \raisebox{-\mp@chaptlht}{\raisebox{\mp@chapnoht}{%
           \parbox[b]{.9\textwidth}{\raggedleft\Huge\sffamily\bfseries #1}}}%
       \par\nobreak%
       \vskip\mp@margwd%
       }%
     }
     
% It redefines |\section|.
   \renewcommand{\section}{\secdef\@section\@ssection}

   \newlength{\mp@headht}
   \newcommand{\@section}[2][?]%
   {%
     \refstepcounter{section}%
     \addcontentsline{toc}{section}{\protect\numberline{\thesection} #1}%
     \vspace{\baselineskip}%
     \pagebreak[3]%
     {%
          \hspace{-\mp@margwd}\rule{\mp@fullwd}{.25mm}%
          \par\vspace*{-.5\baselineskip}%
          \hspace{-\mp@margwd}%
          \large\bfseries\sffamily\thesection~#2
     }%
     \sectionmark{#1}%
     \vspace*{\baselineskip}%
   }

   \newcommand{\@ssection}[1]%        % for section*{...}
   {
     {%
       \hspace{-\mp@margwd}\rule{\mp@fullwd}{.25mm}%
       \par\vspace*{-.5\baselineskip}%
       \hspace{-\mp@margwd}%
       \large\bfseries\sffamily#1
     }%
     \vspace*{-.1\baselineskip}%
   }

% It redefines |\subsection|.
   \renewcommand{\subsection}{%
     \@startsection
     {subsection}{2}{0pt}{-1.5ex plus -1ex minus -.2ex}%
     {1ex plus .2ex}{\fontseries{mc}\normalsize\bfseries\sffamily}%
     }

% It redefines |\subsubsection|.
   \renewcommand{\subsubsection}{%
     \@startsection
     {subsubsection}{3}{0pt}{-1.5ex plus -1ex minus -.2ex}%
     {1ex plus .2ex}{\normalsize\bfseries\sffamily}%
     }

% Put caption in the margin, next to the figure/table (place caption first in
% figure/table environment)
   \newlength{\mp@capht}
   \newcommand{\mp@makefigcap}[2]{%
     \settoheight{\mp@capht}%
     {\parbox[b]{.9\mp@margwd}{\raggedleft\small\slshape\sffamily#1: #2}}%
     \hspace{-\mp@margwd}%
     \vspace{-\mp@capht}%
     \parbox[t]{.9\mp@margwd}{\raggedleft\small\slshape\sffamily#1: #2}
     }
   
   \renewcommand{\figure}{%
     \let\@makecaption\mp@makefigcap\@float{figure}%
     }
   \renewcommand{\table}{%
     \let\@makecaption\mp@makefigcap\@float{table}%
     }

% Page style
   \renewcommand{\ps@plain}{%
     \renewcommand{\@oddhead}{}%
     \renewcommand{\@evenhead}{}%
     \renewcommand{\@oddfoot}{\hfil\textsf{\thepage}}%
     \renewcommand{\@evenfoot}{\hspace{-\mp@margwd}\textsf{\thepage}\hfil}%
     }

% Footnote style
   \renewcommand{\@makefntext}[1]%
   {%
     \setlength{\parindent}{0mm}%
     \makebox[1em][l]{\@makefnmark}#1%
   }

% Dimensions
   \setlength\hoffset{-1in}
   \setlength\voffset{-1in}
   \setlength\textwidth{120mm}
   \setlength\textheight{.85\paperheight}
   \setlength{\oddsidemargin}{75mm}
   \setlength{\evensidemargin}{75mm}
   \pagestyle{plain}

   \parindent0mm
   \parskip1ex

   \newlength{\mp@margwd}
   \setlength{\mp@margwd}{50mm}

   \newlength{\mp@fullwd}
   \setlength{\mp@fullwd}{\textwidth}
   \addtolength{\mp@fullwd}{\mp@margwd}

   \newlength{\mp@chapnoht} % height of the chapter number
   \newlength{\mp@chaptlht} % height of the chapter title
   \newlength{\EX}
   \settoheight{\EX}{\normalsize X}
   \setlength{\EX}{2\EX}

\endinput
