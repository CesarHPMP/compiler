#ifndef TABSIMB
#define TABSIMB 
#include "tabsimb.h"
#endif
#ifndef SEMANTICA
#include "semantic.c"
#define SEMANTICA
#endif

int retorna_maior_tipo(int tipo1, int tipo2){

	switch(tipo1)
	{
		case INT:
			if(tipo2 != CHAR || tipo2 != -1)
			{
				if(tipo2 != INT)
				{
					if(tipo2 != FLOAT)
                    {
					    printf("tipo1 não compatível com tipo2: %d %d\n", tipo1, tipo2);
                    	yyerror("Erro Semântico");
                    }
                    return FLOAT;
				}
				return INT;
			}
			return INT;
		
		case FLOAT:
			if(tipo2 != CHAR || tipo2 != -1)
			{
				if(tipo2 != INT)
				{
					if(tipo2 != FLOAT)
                    {
                        printf("tipo1 não compatível com tipo2: %d %d\n", tipo1, tipo2);
						yyerror("Erro Semântico");
                    }
                    return FLOAT;
				}
				return FLOAT;
			}
			return FLOAT;

		case CHAR:
			if(tipo2 != FLOAT || tipo2 != -1)
			{
				if(tipo2 != INT)
				{
					if(tipo2 != CHAR)
                    {
                        printf("tipo1 não compatível com tipo2: %d %d\n", tipo1, tipo2);
						yyerror("Erro Semântico");
                    }
                    return CHAR;
				}
				return INT;
			}
			return FLOAT;

        case -1:
            return tipo2;
	}
}

int tipos_inconsistentes_atrib(int id, int tipo){
    struct symbol aux = Tabela[id];
	int tipof = retorna_maior_tipo(tipo, aux.tipo);
	return tipof;
}
