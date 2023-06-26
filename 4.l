%{
#include<stdio.h>
#include "y.tab.h"
%}
L [A-Za-z]
D [0-9]
id {L}({L}|{D})*
%%
"if" {return IF;}
"else" {return ELSE;}
"for" {return FOR;}
"do" {return DO;}
"while" {return WHILE;}
"++" {return INC;}
"--" {return DEC;}
"||" {return OR;}
"&&" {return AND;}
"!" {return NOT;}
"switch" {return SWITCH;}
"case" {return CASE;}
"break" {return BREAK;}
"default" {return DEFAULT;}
[0-9]+(\.[0-9]+)? {return NUM;}
{id} {return id;}
"<"|"<="|">"|">="|"=="|"!=" {return relop;}
[-/;=+*,\(\)\{\}:] {return yytext[0];}
[ ] {}
\n {}
%%
int yywrap()
{
return 1;
}
