%
% mparticle, an attempt at a fancier article style
% @(#) $Id: mparticle.cls,v 1.2 1999-06-04 11:05:08+02 mxp Exp mxp $

% NOTE:  This class automatically specifies the a4paper option.

% The class begins by announcing itself as |mparticle.cls|.
   \NeedsTeXFormat{LaTeX2e}
   \ProvidesClass{mparticle}[1999/06/04 A variant article class]

% It passes all specified options on to the |article| class.
   \DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
   \ProcessOptions

% It then loads the class |article|.
   \LoadClass[a4paper]{article}

% The class then redefines |\maketitle|.
   \if@titlepage
   \renewcommand{\maketitle}{%
     \begin{titlepage}%
       \begin{flushleft}
         \huge\sffamily\fontseries{mc}\slshape\bfseries
         \@title\\
         \large\mdseries\upshape
         \vspace{.5em}%
         \rule{\textwidth}{.5mm}\\        
         \@author, \@date\\
       \end{flushleft}
       \@thanks
       \par
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
                                %\rule{\textwidth}{.5mm}\\
     \end{flushleft}
     \@thanks
     \par
     \vskip 1cm
     }
   \fi

% It redefines |\section|.

   \renewcommand{\thesection}{\arabic{section}}

   \renewcommand{\section}{%
     \secdef\@mpsection\@smpsection%
     }

   \newlength{\mp@headht}
   \newcommand{\@mpsection}[2][?]%
   {%
     \refstepcounter{section}%
     \addcontentsline{toc}{section}{\protect\numberline{\thesection} #1}%
     \vspace{\baselineskip}%
     \pagebreak[3]%
     {%
       \hspace{-\mp@margwd}\rule{\mp@fullwd}{.25mm}%
       \par\vspace*{-.5\baselineskip}%
       \hspace{-\mp@margwd}%
       \large\bfseries\sffamily\thesection~#2\par
     }%
     \sectionmark{#1}%
     % \vspace*{\baselineskip}%
   }

   \newcommand{\@smpsection}[1]%        % for section*{...}
   {
     {%
       \hspace{-\mp@margwd}\rule{\mp@fullwd}{.25mm}%
       \par\vspace*{-.5\baselineskip}%
       \hspace{-\mp@margwd}%
       \large\bfseries\sffamily#1\par
     }%
     % \vspace*{\baselineskip}%
   }

%   \newcommand{\@mpsection}[2][?]{%
%     \refstepcounter{section}%
%     \addcontentsline{toc}{section}{\protect\numberline{\thesection} #1}%
%     {\par\hspace{-\mp@margwd}\large\bfseries\sffamily\thesection~#2%
%       \par\vspace{-\baselineskip}%
%       \hspace{-\mp@margwd}\rule{\mp@fullwd}{.25mm}}%
%     \sectionmark{#1}\par}%

%   \newcommand{\@smpsection}[1]{%        % for section*{...}
%     {\par\hspace{-\mp@margwd}\large\bfseries\sffamily#1%
%       \par\vspace{-\baselineskip}%
%       \hspace{-\mp@margwd}\rule{\mp@fullwd}{.25mm}}%
%     \par}%

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
     \vspace{-1.2\mp@capht}%
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
   \setlength\textwidth{12cm}
   \setlength\textheight{.85\paperheight}
   \setlength{\oddsidemargin}{75mm}
   \setlength{\evensidemargin}{65mm}
   \pagestyle{plain} 

   \parindent0mm
   \parskip1ex

   \newlength{\mp@margwd}
   \setlength{\mp@margwd}{55mm}

   \newlength{\mp@fullwd}
   \setlength{\mp@fullwd}{\textwidth}
   \addtolength{\mp@fullwd}{\mp@margwd}
   
\endinput
