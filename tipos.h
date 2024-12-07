#ifndef TABSIMB
#define TABSIMB 
#include "tabsimb.h"
#endif
#ifndef SEMANTICA
#include "semantic.c"
#define SEMANTICA
#endif

int retorna_maior_tipo(int tipo1, int tipo2){
	if(tipo1 == -1 || tipo2 == -1)
	{
		yyerror("Erro Semântico");
	}

	switch(tipo1)
	{
		case INT:
			if(tipo2 != CHAR)
			{
				if(tipo2 != INT)
				{
					if(tipo2 != FLOAT)
						yyerror("Erro Semântico");
					return FLOAT;
				}
				return INT;
			}
			return INT;
		
		case FLOAT:
			if(tipo2 != CHAR)
			{
				if(tipo2 != INT)
				{
					if(tipo2 != FLOAT)
						yyerror("Erro Semântico");
					return FLOAT;
				}
				return FLOAT;
			}
			return FLOAT;

		case CHAR:
			if(tipo2 != FLOAT)
			{
				if(tipo2 != INT)
				{
					if(tipo2 != CHAR)
						yyerror("Erro Semântico");
					return CHAR;
				}
				return INT;
			}
			return FLOAT;
			
	}
}

int tipos_inconsistentes_atrib(int id, int tipo){
    struct symbol aux = Tabela[id];
	int tipof = retorna_maior_tipo(tipo, aux.tipo);
	return tipof;
}
