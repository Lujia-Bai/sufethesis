%%Identification
%%The class identifies itself and the LaTeX version needed
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{SUFEThesis}[2014/08/16 Example class]

\RequirePackage{kvdefinekeys}
\RequirePackage{kvsetkeys}
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family=sufe,
  prefix=sufe@,
  setkeys=\kvsetkeys}
\newcommand\sufe@error[1]{%
  \ClassError{sufethesis}{#1}{}%
}
\newcommand\sufesetup{%
  \kvsetkeys{sufe}%
}
\newcommand\sufe@define@key[1]{%
  \kvsetkeys{sufe@key}{#1}%
}

\kv@set@family@handler{sufe@key}{%
  \@namedef{sufe@#1@@name}{#1}%
  \def\sufe@@default{}%
  \def\sufe@@choices{}%
  \kv@define@key{sufe@value}{name}{%
    \@namedef{sufe@#1@@name}{##1}%
  }%
  \kv@define@key{sufe@value}{code}{%
    \@namedef{sufe@#1@@code}{##1}%
  }%
  \@namedef{sufe@#1@@check}{}%
  \@namedef{sufe@#1@@code}{}%
  \@namedef{sufe@#1@@hook}{%
    \expandafter\ifx\csname\@currname.\@currext-h@@k\endcsname\relax
      \@nameuse{sufe@#1@@code}%
    \else
      \AtEndOfClass{%
        \@nameuse{sufe@#1@@code}%
      }%
    \fi
  }%
  \kv@define@key{sufe@value}{choices}{%
    \def\sufe@@choices{##1}%
    \@namedef{sufe@#1@@reset}{}%
    \@namedef{sufe@#1@@check}{%
      \@ifundefined{%
        ifsufe@\@nameuse{sufe@#1@@name}@\@nameuse{sufesufe@\@nameuse{sufe@#1@@name}}%
      }{%
        \sufe@error{Invalid value "#1 = \@nameuse{sufe@\@nameuse{sufe@#1@@name}}"}%
      }%
      \@nameuse{sufe@#1@@reset}%
      \@nameuse{sufe@\@nameuse{sufe@#1@@name}@\@nameuse{sufe@\@nameuse{sufe@#1@@name}}true}%
    }%
  }%
  \kv@define@key{sufe@value}{default}{%
    \def\sufe@@default{##1}%
  }%
  \kvsetkeys{sufe@value}{#2}%
  \@namedef{sufe@\@nameuse{sufe@#1@@name}}{}%
  \kv@set@family@handler{sufe@choice}{%
    \ifx\sufe@@default\@empty
      \def\sufe@@default{##1}%
    \fi
    \expandafter\newif\csname ifsufe@\@nameuse{sufe@#1@@name}@##1\endcsname
    \expandafter\g@addto@macro\csname sufe@#1@@reset\endcsname{%
      \@nameuse{sufe@\@nameuse{sufe@#1@@name}@##1false}%
    }%
  }%
  \kvsetkeys@expandafter{sufe@choice}{\sufe@@choices}%
  \expandafter\let\csname sufe@\@nameuse{sufe@#1@@name}\endcsname\sufe@@default
  \expandafter\ifx\csname sufe@\@nameuse{sufe@#1@@name}\endcsname\@empty\else
    \@nameuse{sufe@#1@@check}%
    \@nameuse{sufe@#1@@hook}%
  \fi
  \kv@define@key{sufe}{#1}{%
    \@namedef{sufe@\@nameuse{sufe@#1@@name}}{##1}%
    \@nameuse{sufe@#1@@check}%
    \@nameuse{sufe@#1@@hook}%
  }%
}


\sufe@define@key{
    title, 
    author, 
    id, 
    school, 
    discipline, 
    supervisor,
}


%%Preliminary definitions, needed by the options
\LoadClass[]{ctexart}
\RequirePackage{xcolor}
% \RequirePackage{greycolour}{HTML}{525252}
% \RequirePackage{sharelatexcolour}{HTML}{882B21}
% \RequirePackage{mybluecolour}{HTML}{394773}
%\RequirePackage{inputenc}



\RequirePackage{fontenc}
\RequirePackage{geometry}
\RequirePackage{changepage}
\RequirePackage{abstract}
\RequirePackage{titletoc}
\RequirePackage{amsmath}
\RequirePackage{mathrsfs} 
\RequirePackage{graphicx}
\RequirePackage{cite}
\RequirePackage{listings}
\RequirePackage{pdfpages}
\RequirePackage{gbt7714}
\RequirePackage{natbib}



%%This parts handles the options passed to the class.
\DeclareOption{onecolumn}{\OptionNotUsed}
\DeclareOption{green}{\renewcommand{\headlinecolor}{\color{green}}}
\DeclareOption{red}{\renewcommand{\headlinecolor}{\color{slcolor}}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

%%Body of the class, most of the declarations appear here.



\numberwithin{figure}{section}% 图片计数是以section为单位，第4章第n个图的意思
\numberwithin{table}{section}%同上

\setmainfont{Arial}
\geometry{a4paper,left=3cm,right=2cm,top=2.5cm,bottom=2.5cm}
\renewcommand{\abstractnamefont}{\heiti\zihao{3}}%读汉语拼音就知道在写啥了，摘要标题黑体3号
\renewcommand{\abstracttextfont}{\songti\zihao{4}}%读汉语拼音就知道在写啥了，摘要内容宋体4号
\renewcommand{\contentsname}{\heiti \zihao{3} 目录~\\~\\}
\renewcommand{\baselinestretch}{1.6}
 %就是一些目录里面空格的小问题， subsubsection的序号不要离标题太远
\titlecontents{subsubsection}[4em]{\zihao{5}}{\contentslabel{2ex}}{\hspace*{-2em}}{~\titlerule*[0.6pc]{$.$}~}

%就定义一下代码颜色什么的，然后后面可以直接插入代码文件
\lstset{language=r,
  numbers=left, %设置行号位置
  basicstyle=\ttfamily,
  numberstyle=\tiny, %设置行号大小
  keywordstyle=\color{blue}, %设置关键字颜色
  commentstyle=\color[cmyk]{1,0,1,0}, %设置注释颜色
  stringstyle = \color{red},
  escapeinside=``, %逃逸字符(1左面的键)，用于显示中文
  %breaklines, %自动折行
  extendedchars=false, %解决代码跨页时，章节标题，页眉等汉字不显示的问题
  xleftmargin=2em,xrightmargin=2em, aboveskip=1em, %设置边距
  tabsize=4, %设置tab空格数
  breaklines,%自动换行
  columns=flexible,%不随便添加空格,只在已经有空格的地方添加空格,
  showspaces=false %不显示空格
}

%contents setting
\renewcommand\thefigure{\thesection-\arabic{figure}}%图4-1：%就是这种东西也要调
\renewcommand\thetable{\thesection-\arabic{table}}%表4-1：%就是这种东西也要调

\renewcommand\maketitle{
    \pagestyle{plain}
\thispagestyle{empty}

\begin{titlepage}
  \begin{center}
    \includegraphics[width = 0.6\textwidth]{SUFE-logo.png}
  \end{center}
  \begin{center}
    \heiti\zihao{1}\ziju{0.5} 毕业论文
  \end{center}
  \vskip 2.3cm
  \parbox[t][2.4cm][t]{\textwidth}{%
  \heiti\zihao{2}%
  \parindent=4em%
  \hangindent=5em%
  \makebox[3em][l]{题目：}%
  \zihao{2}%
  \CJKunderline[skip=false, thickness=0.05em, depth=0.12em]{上海财经大学 \LaTeX 模板}\par
  }\par
  \vskip 2.5cm%
  \begin{center}
    \newlength{\lenth}
\settowidth{\lenth}{姓名}
  \parbox{80mm}{
  {\songti\zihao{3}
  姓 \hspace*{1.5em} 名 \uline{\makebox[60mm]{\sufe@author}}\\[5mm]
  \parindent=4em%
  学 \hspace*{1.5em} 号 \uline{\makebox[60mm]{\sufe@id}}\\[5mm]
  学 \hspace*{1.5em} 院 \uline{\makebox[60mm]{\sufe@school}}\\[5mm]
  专 \hspace*{1.5em} 业 \uline{\makebox[60mm]{\sufe@discipline}}\\[5mm]
  指导教师\uline{\makebox[60mm]{\sufe@supervisor} }}\\
  }
  \end{center}
  \vskip 3cm%
  \begin{center}
    \songti\zihao{3}
    定稿日期 \hspace*{1.5em} 2020\hspace*{0.5em}年\hspace*{0.5em}5\hspace*{0.5em}月
  \end{center}
\end{titlepage}
}

%%%%%%%%%%%%% Abstract %%%%%%%%%%%%%%
\sufe@define@key{
  keywords,
  keywords* = {
    name = keywords@en,
  },
}
\newcommand{\cabstractname}{摘要}
\newcommand{\eabstractname}{Abstract}

\RequirePackage{xparse}
\ExplSyntaxOn
\NewDocumentCommand{\sufe@clist@use}{mm}
{
    \def\sufe@@tmp{}%
    \clist_map_inline:nn {#1}{
        \ifx\sufe@@tmp\@empty
            \def\sufe@@tmp{#2}
        \else
            #2
        \fi
        ##1%
    }
}
\ExplSyntaxOff

% \newcommand\sufe@clist@use[2]{%
%   \def\sufe@@tmp{}%
%   \kv@set@family@handler{sufe@clist}{%
%     % \ifx\sufe@@tmp\@empty
%     %   \def\sufe@@tmp{#2}%
%     % \else
%     %   #2%
%     % \fi
%     {##1}%
%   }%
%   %\kvsetkeys@expandafter{sufe@clist}{}%
%   \kvsetkeys{sufe@clist}{LaTeX, 1}%
% }
\newbox\sufe@kw
\newcommand\sufe@put@keywords[2]{%
  \begingroup
    \setbox\sufe@kw=\hbox{#1}
    \box\sufe@kw#2\par
  \endgroup}
  
\renewenvironment{abstract}{%
  % \sufe@chapter*[]{\cabstractname} % no tocline
  \section*{\cabstractname}
}{%
  \sufe@put@keywords{\textbf{关键字：}}{%
    \sufe@clist@use{\sufe@keywords}{；}%
  }%
}
\newenvironment{abstract*}{%
  \section*{\eabstractname}
}{%
  \sufe@put@keywords{%
    \textbf{Key Words:}%
  }{%
    \sufe@clist@use{\sufe@keywords@en}{; }%
  }%
}


