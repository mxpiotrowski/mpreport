%%%
%%% mparticle, an attempt at a fancier article style
%%% @(#) $Id: mparticle.cls,v 1.3 1999-06-04 11:54:52+02 mxp Exp mxp $

%%% NOTE:  This class automatically specifies the a4paper option.

% The class begins by announcing itself as |mparticle.cls|.
   \NeedsTeXFormat{LaTeX2e}
   \ProvidesClass{mparticle}[1999/06/04 A variant article class]

%%% The class has one option, ``hyperref,'' to enable special hacks
%%% for hyperref.  Specify it if you want PDF bookmarks for sections and
%%% subsections.
\usepackage{ifthen}
\newboolean{hyperref}
\setboolean{hyperref}{false}
\DeclareOption{hyperref}{\setboolean{hyperref}{true}}

%%% It passes all other options on to the |article| class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions

%%% It then loads the class |article|.
\LoadClass[a4paper]{article}

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

%%% It redefines |\section|.
   \renewcommand{\section}{\secdef\@mpsection\@smpsection}

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
       \@mywritetorep{#1}{section.\thesection}{}
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
