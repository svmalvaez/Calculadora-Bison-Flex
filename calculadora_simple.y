%{
#include <stdio.h>
#include <stdlib.h>
extern int yylineno;
extern char * yytext;
%}

%union
{
    float real;
}
%token <real> TKN_NUM
%token TKN_PTOCOMA
%token TKN_MAS
%token TKN_MENOS
%type <real> Expresion
%left TKN_MAS TKN_MENOS
%start Calculadora
%%

Calculadora :Expresion TKN_PTOCOMA { printf("%5.2f\n", $1); };
          
Expresion :  TKN_NUM {$$=$1;}|
             Expresion TKN_MAS Expresion {$$=$1+$3;}|
             Expresion TKN_MENOS Expresion {$$=$1-$3;}
;
%%

int yyerror(char *msg)
{
	printf("%d: %s en '%s'\n", yylineno, msg, yytext);
}

int main()
{

    yyparse();

    printf("Numero lineas analizadas: %d\n", yylineno);
    return (0);
}

