%%Identification
%%The class identifies itself and the LaTeX version needed
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{SUFEThesis}[2014/08/16 Example class]

\RequirePackage{kvdefinekeys}
\RequirePackage{kvsetkeys}
\RequirePackage{kvoptions}
%%%%%%%%%%从setup文件中读参数%%%%%%%%
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
    title* = {
    name = title@en,
  },
    author, 
    id, 
    school, 
    discipline, 
    supervisor,
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%Preliminary definitions, needed by the options
\LoadClass[]{ctexart}
\RequirePackage{xcolor}
\RequirePackage{fontenc}
\RequirePackage{geometry}
\RequirePackage{changepage}
\RequirePackage{abstract}
\RequirePackage{titletoc}
\RequirePackage{amsmath}
\RequirePackage{mathrsfs} 
\RequirePackage{graphicx}
% \RequirePackage{cite}
\RequirePackage{subcaption}
\RequirePackage{booktabs}
\RequirePackage{tabu}
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

\newcommand{\titleformat}{

\ctexset{
  section = {
    name={,、 },number={\chinese{section}},format={\centering\heiti\zihao{3}},afterskip={2ex},beforeskip={2ex}, aftername={}
  },%出来是 一、标题
  subsection = {
    name={(,)},number={\chinese{subsection}},format={\heiti\zihao{4}},afterskip={2ex},beforeskip={2ex},aftername={ }
  },%出来是 (一) 标题
  subsubsection = {
    name={,.},number=\arabic{subsubsection},format={\heiti\zihao{5}},afterskip={2ex},beforeskip={2ex},aftername={ }
  }%出来是 1.标题
}

}
%%%%%%%%%%%%%%%%%%一些小细节%%%%%%%%%%%%%%%
\numberwithin{figure}{section}% 图片计数是以section为单位，第4章第n个图的意思
\numberwithin{table}{section}%同上

%英文字体
\setmainfont{Arial}
\songti
%打印要求
%采用计算机打印一律用A4规格复印纸输出，上下边距为2.5cm，左边距为3cm，右边距为2cm，页脚1.5cm，居中打印页号。
\geometry{a4paper,left=3cm,right=2cm,top=2.5cm,bottom=2.5cm}

%%%%%%%目录
\renewcommand\tableofcontents{%
  \section*{目录}
  \heiti\@starttoc{toc}\songti
  \thispagestyle{empty}
}
% \renewcommand{\contentsname}{\heiti \zihao{3} 目录~\\~\\}
% \renewcommand{\baselinestretch}{1.6}
%  %就是一些目录里面空格的小问题， subsubsection的序号不要离标题太远
\titlecontents{subsubsection}[4em]{\heiti\zihao{5}}{\contentslabel{2ex}}{\hspace*{-2em}}{~\titlerule*[0.6pc]{$.$}~\contentspage}



%%%%%%代码
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

%图表标号
\renewcommand\thefigure{\thesection-\arabic{figure}}%图4-1：%就是这种东西也要调
\renewcommand\thetable{\thesection-\arabic{table}}%表4-1：%就是这种东西也要调

%%%%%%%%%Define maketitle to output the cover page containing SUFE logo%%%%%%%%%%%%%%%%%%%
%%封页。封页上的内容一律按照统一封面的样张式样打印，必须正 确无误。题目用二号黑体字，其他用四号宋体字。
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
  \heiti\zihao{2}%二号黑体字
  \CJKunderline[skip=false, thickness=0.05em, depth=0.12em]{\sufe@title}\par
  }\par
  \vskip 2.5cm%
  \begin{center}
    \newlength{\lenth}
\settowidth{\lenth}{姓名}
  \parbox{80mm}{
  {\songti\zihao{4}% 四号宋体字
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
    \songti\zihao{4}%  四号宋体字
    定稿日期 \hspace*{1.5em} 2020\hspace*{0.5em}年\hspace*{0.5em}5\hspace*{0.5em}月
  \end{center}
\end{titlepage}
}

%%%%%%%%%%%%% Abstract  摘要%%%%%%%%%%%%%%
%题目和摘要。论文(设计)题目为三号黑体字，可以分为1或2行 居中打印。论文(设计)题目下空一项居中打印“摘要”二字(三号 黑体)，字间空一格，标点符号占一格。“摘要”二字下空一行打印 内容(四号宋体)。每段开头空二格，标点符号占一格。摘要内容后 下空一行打印“关键字”三字(四号黑体字)，其后为关键词(四号 宋体)。英文摘要题目全部采用Arial字体，可分成1-3行居中打印， 以下均用五号Arial字体。

\sufe@define@key{
  keywords,
  keywords* = {
    name = keywords@en,
  },
}

\newcommand\sufe@clist@use[2]{%
  \def\sufe@@tmp{}%
  \def\sufe@clist@processor##1{%
    \ifx\sufe@@tmp\@empty
      \def\sufe@@tmp{#2}%
    \else
      #2%
     \fi
     ##1%
   }%
   \comma@parse{#1}{\sufe@clist@processor}%
   \expandafter\comma@parse\expandafter{#1}{\sufe@clist@processor}%
 }

%%%%%%%%%%通过sufesetup命令可以读入关键字并格式化%%%%%
\newbox\sufe@kw
\newcommand\sufe@put@keywords[2]{%
  \begingroup
    \setbox\sufe@kw=\hbox{#1}
    \box\sufe@kw#2\par
  \endgroup}
 %%%%%%%%%%%%%%%% 

 %%%%%%%%%%%%%中文摘要%%%%%%%%%%%%%
 \newcommand{\cabstractname}{摘要}
\renewenvironment{abstract}{%
  \section*{\sufe@title}
  \section*{\cabstractname}
  \songti\zihao{4} %摘要内容是宋体4号
}{%摘要内容后 下空一行打印“关键字”三字(四号黑体字)，其后为关键词(四号 宋体)。
\\%空行不要动
\\%空行不要动
  \heiti\zihao{4} \sufe@put@keywords{\textbf{关键字：}}{%
  \songti\zihao{4}  \sufe@clist@use{\sufe@keywords}{；}%
   
  }%
  \thispagestyle{empty}
  \newpage
}

 %%%%%%%%%%%%%英文摘要%%%%%%%%%%%%%
\newcommand{\eabstractname}{Abstract}
\newenvironment{abstract*}{%
  \section*{\sufe@title@en}
  \section*{\eabstractname}
  \zihao{5}
}{%
\\%空行不要动
\\%空行不要动
  \sufe@put@keywords{\textbf{Key Words:}}{%
    \sufe@clist@use{\sufe@keywords@en}{; }%
  }%
  \thispagestyle{empty}
  \newpage
}

%%%%%%%%%%%%%%声明页%%%%%%%%%%%%%%%
\newcommand{\statement}{\clearpage\newpage 
\vspace*{1em}
\begin{center}
\zihao{1}\heiti \textbf{声\hspace*{1.5em}明}
\end{center}
\vspace*{1em}
\zihao{2}\heiti \par 本人郑重声明所呈交的论文是我个人在指导老师的指导下进行的研究工作及取得的研究成果，不存在任何剽窃、抄袭他人学术成果的现象。我同意（ \hspace*{1.5em}  ）/ 不同意（ \hspace*{1.5em}  ）本论文作为学校的信息资料使用。
\vskip 4.5 cm   
\hspace*{6em}   论文作者（签名）  
\vskip 1 cm 
\thispagestyle{empty}
    
}