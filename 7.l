Program : Write a program to generate ICG using LEX and YACC.
Input :
Icg.l
%{
#include"y.tab.h"
extern char yyval;
%}
%%
[0-9]+ {yylval.symbol=(char)(yytext[0]);return NUMBER;}
[a-z] {yylval.symbol= (char)(yytext[0]);return LETTER;}
. {return yytext[0];}
\n {return 0;}
%%
