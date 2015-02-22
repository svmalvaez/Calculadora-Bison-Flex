%option yylineno
%{
#include "calculadora_simple.tab.h"
%}
DIGITO [0-9]
%%
{DIGITO}+("."{DIGITO}+)? {yylval.real=atof(yytext); return(TKN_NUM);}
";"	{return(TKN_PTOCOMA);}
"+"     {return(TKN_MAS);}
"-"     {return(TKN_MENOS);}
\n  	{}
%%

