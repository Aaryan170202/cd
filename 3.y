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
S:SS '.' {printf("Simple Sentence");}
|CS'.' {printf("Compound Sentence");};
CS:SS CONJ SS {printf("Compound Sentence");}
|CS CONJ SS;
SS:NP VP {printf("SS\n");}| VP{printf("1\n");};
NP:DET NOUN {printf("Two No.\n");}
| NOUN {printf("3\n");}
| PRONOUN {printf("5\n");}
| DET NOUN PP {printf("6\n");};
VP:VERB NP {printf("7\n");}| VERB {printf("8\n");} |VP PP {printf("10\n");};
PP:Preposition NP {printf("11\n");};
%%
main()
{
yyparse();
}
int yyerror(char* msg)
{
return 1;
}
