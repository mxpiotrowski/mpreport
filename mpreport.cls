%%%
%%% mpreport, an attempt at a fancier report style
%%% @(#) $Id: mpreport.cls,v 1.4 1999-06-04 11:48:50+02 mxp Exp mxp $

%%% NOTE:  This class automatically specifies the a4paper option and
%%%        loads the graphicx package.

%%% The class begins by announcing itself as |mpreport.cls|.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mpreport}[1999/06/04 A variant report class]

%%% The class has one option, ``hyperref,'' to enable special hacks
%%% for hyperref.  Specify it if you want PDF bookmarks for sections and
%%% subsections.
\usepackage{ifthen}
\newboolean{hyperref}
\setboolean{hyperref}{false}
\DeclareOption{hyperref}{\setboolean{hyperref}{true}}

%%% It passes all other options on to the |report| class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions

%%% It then loads the class |report| and the graphicx package.
\LoadClass[a4paper]{report}
\usepackage{graphicx}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% This is hacked code from the hyperref package
\ifthenelse{\boolean{hyperref}}%
{
  \def\@mywritetorep#1#2#3{%
    \ifx\WriteBookmarks\relax\else
    \protected@write\@outlinefile%
    {\let~\space
      \def\LaTeX{LaTeX}%
      \def\eTeX{e-TeX}%
      \def\TeX{TeX}%
      \let\label\@gobble
      \let\index\@gobble
      \let\glossary\@gobble}%
    {\protect\BOOKMARK{#2}{#1}{#3}}%
    \fi}}
{\def\@mywritetorep#1#2#3{}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% The class then redefines |\maketitle|.
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
     \if@openright\cleardoublepage\else\clearpage\fi
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
     
%%% It redefines |\section|.
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
          \@mywritetorep{#1}{section.\thesection}{chapter.\thechapter}
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
% Normally, all we had to do was to say:
%   \renewcommand{\subsection}{%
%     \@startsection
%     {subsection}{2}{0pt}{-1.5ex plus -1ex minus -.2ex}%
%     {1ex plus .2ex}{\fontseries{mc}\normalsize\bfseries\sffamily}%
%     }
% But with hyperref hacking we need the following:
 \renewcommand{\subsection}{\secdef\@subsection\@ssubsection%
   }
 \newcommand{\@subsection}[2][?]%
 {%
   \refstepcounter{subsection}%
   \addcontentsline{toc}{subsection}{\protect\numberline{\thesubsection} #1}%
   \vspace*{.5\baselineskip}
   \pagebreak[3]%
   {%
     \fontseries{mc}\normalsize\bfseries\sffamily\thesubsection~#2
     }%
   \subsectionmark{#1}%
   \@mywritetorep{#1}{subsection.\thesubsection}{section.\thesection}
   \vspace*{.5\baselineskip}%
   }

   \newcommand{\@ssubsection}[1]%        % for subsection*{...}
   {
     \vspace*{.5\baselineskip}
     \pagebreak[3]%
     {%
       \large\bfseries\sffamily#1
     }%
     \vspace*{.5\baselineskip}%
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
   \setlength{\evensidemargin}{65mm}
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
