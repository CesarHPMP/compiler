#include "semantic.h"
#include "stdio.h"

int retorna_maior_tipo(int tipo1, int tipo2){
	switch(tipo1)
	{
		case INT:
			if(tipo2 != CHAR)
			{
				if(tipo2 != INT)
				{
					yyerror("Erro Semântico");
				}
				return INT;
			}
			return CHAR;
	}
}

int tipos_inconsistentes_atrib(?,?){
    ???
}
