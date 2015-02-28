%{
#include <stdio.h>
#include "instrucciones.tab.h"
%}

separador	([ \t])+
DIGITO	[0-9]
identificador	{letra}({letra}|{digito})*
constEntera	{digito}({digito})*
%%
"-"?{DIGITO}+("."{DIGITO}+)? {//printf("Encontrado TKN_NUM: %f\n", atof(yytext));
	yylval.real=atof(yytext);
	return (TKN_NUM);}
{separador}	{ }
";"		{ return TKN_PTOCOMA; }
"+"		{ return TKN_MAS; }
"-"		{ return TKN_MENOS; }
"^"		{ return TKN_POW; }
"*"		{ return TKN_MULT; }
"%"		{ return TKN_MOD; }
"/"		{ return TKN_DIV; }
"cos"		{ return TKN_COS; }
"tan"		{ return TKN_TAN; }
"sen"		{ return TKN_SEN; }
"raiz"		{ return TKN_RAIZ; }
"("		{ return TKN_PA; }
")"		{ return TKN_PC; }
"="		{return TKN_ASIGN; }
\n	{ }
.	ECHO;
%%

