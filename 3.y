%{
#include <stdio.h>
%}
%token DET NOUN PRONOUN VERB Preposition ADJECTIVE
%nonassoc NOUN
%nonassoc Preposition
%nonassoc CONJ
%%
S1:S1 S
|S
;
S:SS '.' {printf("Simple Sentence\n");}
|CS'.' {printf("Compound Sentence\n");};
CS:SS CONJ SS 
|CS CONJ SS;

SS:NP VP ;
NP:DET NOUN 
| NOUN 
| PRONOUN 
| DET NOUN PP ;
VP:VERB NP | VERB ;
PP:Preposition NP ;


%%
main()
{
yyparse();
}
int yyerror(char* msg)
{
return 1;
}
