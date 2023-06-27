%{
#include"y.tab.h"
%}
NOUN "Tarkeshwari"|"Dog"|"Asha"|"Mayuri"|"Monali"|"Pratiksha"|"Car"
VERB "Play"|"Run"|"Sing"|"Act"|"Answer"|"Approve"|"Arrange"

PREPOSITION "In"|"On"|"Below"|"Above"|"Beside"
ADJECTIVE "Good"|"Bad"|"Big"|"small"|"Tall"|"Short"|"ugly"|"Beautiful"|"Adorable"
PRONOUN "He"|"She"|"It"|"They"|"Them"
DET "a"|"an"|"the"
CONJ "and"|"or"|"but"|"because";
%%
{NOUN} {return NOUN;}
{VERB} {return VERB;}
{PREPOSITION} {return Preposition;}
{ADJECTIVE} {return ADJECTIVE;}
{PRONOUN} {return PRONOUN;}
{DET} {return DET;}
{CONJ} {return CONJ;}
"." {return yytext[0];}
.|\n {}
%%
int yywrap()
{
return 1;
}
