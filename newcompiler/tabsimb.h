#include <stdio.h>
#include <string.h>
#define MAX 1000

int procura(char *);

struct symbol
{
    char lexema[100];
    int tam;
    int type;
};

int tam_tab = 0;
struct symbol tabela[MAX];

int insere(char *lexema)
{
    int onde_existe, existe_na_tabela;
    struct symbol aux;
    onde_existe = procura(lexema);

    if(onde_existe == -1)
        existe_na_tabela = 0;
    if(!existe_na_tabela)
    {
        strcpy(aux.lexema, lexema);
        tabela[tam_tab] = aux;
        return tam_tab++;
    }
    else 
        return onde_existe;
}

int procura(char *lexema)
{
    int i = 0;
    for(i = 0; i < tam_tab; i++)
        if(!strcmp(tabela[i].lexema, lexema))
            return i;
    
    return -1;
}

char lexema[50];
char *get_lexema(int pos)
{
    strcpy(lexema, tabela[pos].lexema);
    return lexema;
}

void imprime()
{
    int i;
    printf("\nTAbela de simbolos\n");
    for(i = 0; i < tam_tab; i++)
        printf("%d - %s\n", i, tabela[i].lexema);
}