#include "analex.h"
#ifndef PILHA_H__
#include "pilha.h"
#define PILHA_H__
#endif // PILHA_H__
#include <string.h>

int token;
char num[1000];
int savenum[1000];
int y = 0;
int x = 0;
char charhold;

void E();
void E_linha();
void T();
void T_linha();
void F();
void consome(int);
void erro_sint();

int main()
{
    token = analex();
    int j = 0;

    E();

    if(token == ';')
    {
        printf("EXPRESSAO CORRETA\n");
        printf("NOTACAO POSFIXA: ");
        for(int i = 0; i < y; i++)
        {
            printf("%i", savenum[i]);
            if (i < y) 
            {
                printf(" ");
            }
        }
        for(int i = 0; i < x; i++)
        {
            printf("%c", num[i]); 
            if (i < y - 1) 
            {
                printf(" ");
            }
        }
        printf("\n");
        printf("RESULTADO DA EXPRESSAO: %i\n", pop());
    }
    else
        erro_sint(30);

    return 0;
}

void E()
{
    T();
    E_linha();
}

void E_linha()
{
    switch (token)
    {
    case '+':
        consome('+');
        T();
        b = pop();
        a = pop();
        push(a + b);
        charhold = '+';
        strcpy(&num[x], &charhold);
        x++;
        E_linha();
        break;

    case '-':
        consome('-');
        T();
        b = pop();
        a = pop();
        push(a - b);
        charhold = '-';
        strcpy(&num[x], &charhold);
        x++;
        E_linha();
        break;
    }
}

void T()
{
    F();
    T_linha();
}

void T_linha()
{
    switch (token)
    {
    case '*':
        consome('*');
        F();
        b = pop();
        a = pop();
        push(a * b);
        charhold = '*';
        strcpy(&num[x], &charhold);
        x++;
        T_linha();
        break;

    case '/':
        consome('/');
        F();
        b = pop();
        a = pop();
        push(a / b);
        charhold = '/';
        strcpy(&num[x], &charhold);
        x++;
        T_linha();
        break;

    default:
        break;
    }
}

void F()
{
    switch (token)
    {
    case '(':
        consome('(');
        E();
        consome(')');
        break;

    case NUM:
        consome(NUM);
        savenum[y] = tokenval;
        y++;
        push(tokenval);
        break;

    case ID:
        consome(ID);
        break;

    default:
        erro_sint(119);
    }
}

void consome(int t)
{
    if(token == t)
        token = analex();

    else
        erro_sint(129);
}

void erro_sint(int linha)
{
    printf("ERRO SINTATICO na LINHA %i\n", linha);
    exit(1);
}

