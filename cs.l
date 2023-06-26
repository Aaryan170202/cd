%{
  #include <stdio.h>
  #include "y.tab.h"
%}
noun "I"|"boy"|"girl"|"Someone"|"Sun"|"Moon"|"Aaryan"|"Computer"|"Fan"|"Mouse"|"Boy";
verb "am"|"is"|"are"|"was"|"were";
conj "and"|"or"|"but"|"because";
det "the"|"a"|"an";
pronoun "he"|"she"|"it"|"they";
%%
{noun} {return NOUN;}
{verb} {return VERB;}
{conj} {return CONJ;}
{det} {return DET;}
{pronoun} {return PRONOUN;}
"." {return yytext[0];}
.|\n {}
%%
 
int yywrap()
{
  return 1;
}
