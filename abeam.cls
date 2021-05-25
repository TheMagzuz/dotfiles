\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{adoc}[2021/05/25 A custom presentation class]

\LoadClass{beamer}

% Make sure that UTF-8 is used
\RequirePackage[utf8]{inputenc}

% Allows the document language to be set
\RequirePackage{babel}
\RequirePackage{csquotes}

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

% A bunch of math packages
\RequirePackage{mathtools}
\RequirePackage{amssymb}

% Subfiles
\RequirePackage{subfiles}

% Bold in math mode
\RequirePackage{bm}

% Bibliography
\RequirePackage[style=authoryear,backend=biber]{biblatex}
