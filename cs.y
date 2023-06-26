%{
  #include <stdio.h>
%}
 
%token DET NOUN VERB CONJ PREPOSITION ADJECTIVE ADVERB PRONOUN 
%nonassoc NOUN
%nonassoc CONJ
%nonassoc PREP
 
%%
S1: S1 S|S;
S : Simple'.'{printf("simple");} | Compound'.'{printf("Compound");};
Simple : Subject VERB Object;
Compound : Simple CONJ Simple | Compound CONJ Simple;
Subject : NOUN | PRONOUN;
Object : NOUN | ADJECTIVE | PREPOSITION;
 
%%
 
void main(){
 yyparse();
}
 
int yyerror(char *msg){
   return 1;
}
