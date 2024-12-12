
#include <string.h>
#ifndef ANALEX
#include "analex.h"
#define ANALEX
#endif

#define MAX 1000
struct symbol {
	char nome[50];
	int tam;
	int tipo;
	float valor;
	int arg_list[50];
	int tam_arg_list;
};
int offset=0;
int proximo_elem=0;
struct symbol Tabela[MAX] = {0};

int get_tam_tipo(int tipo)
{
    switch (tipo)
    {
    case INT:
        return 4;
    
    case FLOAT:
        return 4;

    case CHAR: 
        return 1;

    case VOID:
        return 0;

    default:
        yyerror("Erro de tipos");
    }
}

int procura(char *nome) {
	int i;	
	for(i=0; i<proximo_elem; i++) 
		if(strcmp(Tabela[i].nome,nome)==0)
	    	return i; 
	return -1;     
}

int insere(char *nome) {
	int i,pos;
	struct symbol aux;	
	pos = procura(nome);
	
	if (pos != -1)
		return pos;
		
	strcpy(aux.nome,nome);
	Tabela[proximo_elem] = aux;
	Tabela[proximo_elem].tipo = -1;
	Tabela[proximo_elem].tam_arg_list = 0;
	
	return proximo_elem++;	     
}

int set_type(int pos, int tipo){
	if(pos >= proximo_elem)
		return -1;
	Tabela[pos].tipo = tipo;
	//printf("Pos %d, var %s, tipo %d\n", pos, Tabela[pos].nome, tipo);
	Tabela[pos].tam = get_tam_tipo(tipo);
	offset+=Tabela[pos].tam;
	return 1;
}


char nome[50];
char *obtemNome(int pos) {
	strcpy(nome,Tabela[pos].nome);
	return nome;
}

int getTipo(int pos) 
{
    if(pos > proximo_elem)
        return -1;
    return Tabela[pos].tipo;
}


void imprime() {
	int i;
	printf("\nTABELA DE SIMBOLOS\n");	
	for(i=0; i<proximo_elem; i++) 	
		printf("%d - %s\n",i,Tabela[i].nome);
}
