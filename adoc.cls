\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{adoc}[2021/04/08 A custom document class]

\LoadClass[12pt,a4paper]{article}

% Make sure that UTF-8 is used
\RequirePackage[utf8]{inputenc}

% Allows the document language to be set
\RequirePackage{babel}
\RequirePackage{csquotes}

% Nicer conditionals
\RequirePackage{etoolbox}
\RequirePackage{iflang}

% Allow experimental syntax
\RequirePackage{expl3}
\RequirePackage{xparse}

% Foreach loops
\RequirePackage{pgffor}

% Package for inserting images
\RequirePackage{graphicx}
\graphicspath{ {./images} {../images} }

% Add the H modifier for floats
\RequirePackage{float}

% Add nicer lines in tables
\RequirePackage{booktabs}

% Some utilities for making tables
\RequirePackage{ragged2e}
\RequirePackage{tabularx}
\newcolumntype{Y}{>{\RaggedRight\arraybackslash}X}
\newcolumntype{C}{>{\centering\arraybackslash}X}

% Use 1.5 line spacing
\RequirePackage{setspace}
\onehalfspacing{}

% Packages for setting up header and footer
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage[hidelinks]{hyperref}

% A bunch of math packages
\RequirePackage{mathtools}
\RequirePackage{amssymb}

% Subfiles
\RequirePackage{subfiles}

% Bold in math mode
\RequirePackage{bm}

% Don't indent paragraphs
\RequirePackage{parskip}

% Bibliography
\RequirePackage[
  style=numeric,
  sorting=none,
  backend=biber,
]{biblatex}

% Function to extract the last word of a sentence
%\newcommand*\lastword[1]{\expandafter\xreverseit\expandafter{\expandafter}#1 \relax}
%\def\xreverseit#1#2 #3{%
%\ifx\relax#3%
%#2%
%\expandafter\xthree
%\fi
%\xreverseit{#1 #2}#3% 
%}
%\def\xthree#1#2#3{}

\ExplSyntaxOn
\seq_new:N \l_input_seq % declare a list (seq) variable
\tl_new:N \l_last_word_tl % declare a "token list" variable

% TODO: Make this work when a command is given as input
\NewDocumentCommand{\sclast}{m}
{
  \tl_if_blank:nF {#1} % If the input contains no words, do nothing.
  {
    % Split the argument into words (~ stands for a space here).
    \seq_set_split:Nnn \l_input_seq { ~ } {#1}
    % Remove the last word from the seq.
    \seq_pop_right:NN \l_input_seq \l_last_word_tl
    % Use the contents of the sequence, separating words by a space (~).
    \seq_use:Nnnn \l_input_seq { ~ } { ~ } { ~ }

    \textsc
    {
      ~ \tl_use:N \l_last_word_tl
    }
  }
}


% Get the number of elements in a comma-separated list
\NewDocumentCommand \listlength { m } {
  \clist_count:N #1
}

\ExplSyntaxOff

% Returns the second parameter, if the first parameter is a list of length 1, otherwise returns the third parameter
\newcommand{\pluralize}[3]{\ifnumequal{\listlength{#1}}{1}{#2}{#3}}

% Remove the header and footer
\newcommand{\nohf}{
  \pagestyle{plain}
  \pagenumbering{gobble}
}

% Put the page number in the footer
\newcommand{\sethf}[1][\IfLanguageName{danish}{af}{of}]{
  \pagestyle{fancy}
  \fancyhf{}
  \pagenumbering{arabic}
  \setlength{\headheight}{16pt}
  \if@twoside
    \fancyfooter[CE,CO]{\thepage\space #1~\pageref{LastPage}}
    \fancyheader[LE,LO]{\@institution}
    \fancyheader[RE,RO]{\rightmark}
  \else
    \cfoot{\thepage\space #1~\pageref{LastPage}}
    \lhead{\@institution}
    \rhead{\rightmark}
  \fi
  \renewcommand{\sectionmark}[1]{\markright{\thesection\ ##1}}
  \renewcommand{\subsectionmark}[1]{}
  \renewcommand{\subsubsectionmark}[1]{}
}

% Number sets
\newcommand{\N}{\ensuremath{\mathbb{N}}}
\newcommand{\Z}{\ensuremath{\mathbb{Z}}}
\newcommand{\Q}{\ensuremath{\mathbb{Q}}}
\newcommand{\R}{\ensuremath{\mathbb{R}}}
\newcommand{\C}{\ensuremath{\mathbb{C}}}


% Centers some text and puts two lines under it
\newcommand{\facit}[1]{\begin{center}\underline{\underline{#1}}\end{center}}

% Partial differentiation fraction
\newcommand{\pfrac}[2]{\frac{\partial{} #1}{\partial{} #2}}

% Set builder notation
\newcommand{\setbuild}[2]{\{#1\ |\ #2\}}

% Thicker hline
\newcommand{\HRule}{\rule{\linewidth}{0.5mm}}


% Title page variables
\newcommand{\@institution}{}
\newcommand{\@subtitle}{}
\newcommand{\@mentor}{}
\newcommand{\@pagecountfp}{}
\newcommand{\institution}[1]{\renewcommand{\@institution}{#1}}
\newcommand{\subtitle}[1]{\renewcommand{\@subtitle}{#1}}
\newcommand{\mentor}[1]{\renewcommand{\@mentor}{#1}}
\newcommand{\pagecountfp}[1]{\renewcommand{\@pagecountfp}{#1}}


% Create the title page
\renewcommand{\maketitle}{
  \nohf{}
  \clearpage
  \begin{titlepage}
    \centering
    \textsc{\LARGE \@institution}\\[1.5cm]


    \HRule\\[0.4cm]

    {\huge\bfseries \@title}\\[0.4cm]

    \textsc{\Large \@subtitle}\\

    \HRule\\[1.5cm]

    \begin{minipage}[t]{0.45\textwidth}
      \begin{flushleft}
        \large
        %\textit{\IfLanguageName{danish}{Forfatter\pluralize{\@author}{}{e}}{Author\pluralize{\@author}{}{s}}:} \\
        \textit{\IfLanguageName{danish}{Forfatter\pluralize{\@author}{}{e}}{Author:}} \\
        \foreach \authorname in \@author {% 
          \authorname\\
        }
      \end{flushleft}
    \end{minipage}
    \begin{minipage}[t]{0.45\textwidth}
      \begin{flushright}
        \ifdef{\@mentor}{%
            \large
            %\textit{\IfLanguageName{danish}{\pluralize{\@mentor}{Vejleder}{Vejledere}}{\pluralize{\@mentor}{Mentor}{Mentors}}:} \\
            \foreach \mentorname in \@mentor {% 
              \mentorname\\
            }
          }{}
        \end{flushright}
      \end{minipage}

      \vfill\vfill\vfill

      \large\today
      \ifdef{\@pagecountfp}{\\ \normalsize \@pagecountfp}

      \vfill\vfill

      \vfill	

    \end{titlepage}
    \clearpage
  }

