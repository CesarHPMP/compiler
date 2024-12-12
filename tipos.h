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
                    if(tipo2 == FLOAT)
                        return FLOAT;
                    yyerror("Tipos incompatíveis");
				}
				return INT;
			}
			return INT;
		
		case FLOAT:
			if(tipo2 != -1)
			{
				if(tipo2 != INT)
				{
					if(tipo2 != FLOAT)
                    {
                        yyerror("Tipos incompatíveis");
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
                    	yyerror("Tipos incompatíveis");
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

int tipos_inconsistentes_atrib(int tipo_destino, int tipo_origem){
    if (tipo_origem == -1 || tipo_destino == -1)
        return 0;
    if (tipo_destino == tipo_origem)
        return 0; 
    if (tipo_destino == FLOAT && tipo_origem == INT)
        return 0; 
    if (tipo_destino == INT && tipo_origem == CHAR)
        return 0; 
    return -1;
}