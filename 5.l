%{
# include<stdio.h>
# include "y.tab.h"
%}
L [A-Za-z]
D [0-9]
id {L}({L}|{D})*
%%
"int" {return INT;}
[0-9]+ {return INUM;}
{id} {return id;}
[,;=] {return yytext[0];}
\n {}
%%
int yywrap()
{
return 1;
}
