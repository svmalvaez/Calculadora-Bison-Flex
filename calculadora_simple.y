%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

#define PI 3.141592
extern int yylex(void);
extern char* yytext;
extern int nlines;
int yyerror(char *s);
float toRadians(float grados);
float varTan(float grados);
void imprime(float resultado);
void imprime_invalido();
short int valores=1;
extern FILE * yyin;
FILE * fsalida;

typedef struct Elemento {
	
	char nombre[25] ; 
	float valor; 	 
	struct Elemento* siguiente;

}Variable;

Variable *cabeza;
void insertarEnLista(Variable** vCabeza , float valorVar, char* nombreVar);
Variable* nuevaVariable(float valorVar, char* nombreVar);
void imprimirVariables();
Variable* buscarVariable(Variable* cabeza,char* nombreVar);

%}

%union{
	float real;
	char *cadena;
}

%token <real> TKN_NUM
%type <real> expresion
%type <cadena> TKN_ID
%token TKN_PTOCOMA
%token TKN_MAS
%token TKN_MENOS
%token TKN_MULT
%token TKN_MOD
%token TKN_RAIZ
%token TKN_DIV
%token TKN_POW
%token TKN_PA
%token TKN_PC
%token TKN_SEN
%token TKN_COS
%token TKN_TAN
%token TKN_ASIGN
%token TKN_ID
%left TKN_ASIGN
%left TKN_MAS TKN_MENOS TKN_MOD
%left TKN_MULT TKN_DIV
%left TKN_SEN TKN_COS TKN_TAN 
%left TKN_POW
//%left TKN_PA TKN_PC
%left TKN_RAIZ
%start instrucciones
%%

instrucciones : instrucciones calculadora
		| calculadora
		;
		
calculadora	: expresion TKN_PTOCOMA 
			{
				if(valores > 0){
					imprime($1);
				}
				else
				{
					imprime_invalido();
					valores = 1;
				}
			}
			| TKN_ID TKN_ASIGN expresion TKN_PTOCOMA
			 {
			 	//dondeGuardas(tkn_id,valor_expresion);
			 	//BUscar variable y traer el valor, si no existe agregar variable
			 }
			;
 

expresion	: TKN_NUM { $$ = $1; }
			| TKN_PA expresion TKN_PC { $$ = $2; }
			| expresion TKN_MAS expresion { $$ = $1 + $3; }
			| expresion TKN_MENOS expresion { $$ = $1 - $3; }
			| expresion TKN_MULT expresion { $$ = $1 * $3; }			
			| expresion TKN_POW expresion { $$ = pow($1,$3); }
			| expresion TKN_MOD expresion { $$ = fmod($1,$3); }
			| TKN_RAIZ expresion 
			{
				if($2 < 0)
				{
					valores = 0;
				}
				else
				{
					$$ = sqrt($2);
					valores = 1;
				}
			}
			| expresion TKN_DIV expresion
			{
				if($3 == 0)
				{
					valores = 0;
				}
				else
				{
					$$ = $1 / $3;
					valores = 1;
				}
			}
			| TKN_SEN expresion { $$ = sin(toRadians($2)); }
			| TKN_COS expresion { $$ = cos(toRadians($2)); }
			| TKN_TAN expresion 
			{
				if(-0.000001 < cos(toRadians($2)) && cos(toRadians($2)) < 0.000001)
				{
					valores = 0;
				}
				else
				{
					$$ = tan(toRadians($2));
					valores = 1;
				
				}
			} 
			;

%%

int yyerror(char *s)
{
	printf("%s\n", s);
}


float toRadians(float grados)
{
	return grados*(3.1415926535/180);
}

float varTan(float grados){
	float t = toRadians(grados);
	return cos(t);
}

void imprime(float resultado)
{
	fprintf(fsalida,"Resultado %5.5f\n",resultado);
}

void imprime_invalido()
{
	fprintf(fsalida,"Valor indefinido\n");
}

void insertarEnLista(Variable** cabeza , float valorVar, char nombreVar[]){
	Variable *nueva;
	nueva = nuevaVariable(valorVar,nombreVar);
	nueva -> siguiente = *cabeza;
	*cabeza = nueva;
}


Variable* nuevaVariable(float valorVar, char nombreVar[]){
	Variable *var;
	var = (Variable*)malloc(sizeof(Variable));
	//var -> nombre = nombreVar;
	strcpy( var->nombre, nombreVar );
	var -> valor = valorVar;
	var -> siguiente = NULL;
	printf("\n[vl]Nueva variable: <%s> = %5.2f\n",nombreVar,valorVar);
	return var;
}


Variable* buscarVariable(Variable* cabeza,char nombreVar[]){
	int k;
	Variable *indice;
	printf("\n[vl]Buscando identificador");
		for( k = 0 , indice = cabeza; indice; ){
			if( strcmp( indice->nombre, nombreVar) == 0 )
  			{
     			printf("\n[vl]Var Encontrada...\n");
     			return indice;
  			}else{
  				printf(".");
  				k++;
				indice = indice->siguiente;
  			}
		}
		return NULL;
}


int main(int argc, char **argv)
{
	cabeza = (struct Variable *) NULL;

	if(argc > 2)
	{
		yyin = fopen(argv[1],"r");
		fsalida = fopen(argv[2], "w");
	}
	else
	{
		printf("Forma de uso: ./salida archivo_entrada archivo_salida\n");
		return 0;
	}
	/*Acciones a ejecutar antes del analisis*/
	yyparse();
	/*Acciones a ejecutar despues del analisis*/
	
	return 0;
}

