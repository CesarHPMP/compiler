#include "analex.h"
#include <string.h>
#ifndef PILHA_H__
#include "pilha.h"
#define PILHA_H__
#endif // PILHA_H__

int token;

void E();
void E_linha();
void T();
void T_linha();
void F();
void consome(int );
void erro_sint(int ,int );
void pos_fixo(char );

char posfix[100];
char op[100];

int main()
{
    token = analex();

    E();

    int holder = tam;


    printf("\npilha: %d\n", pop());
    strcat(posfix, op);
    printf("\nConta Posfix = %s", posfix);

    if(token == ';')
        printf("Sem erros sintaticos");
    else
        erro_sint(30,  linha_input);

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
        pos_fixo('+');
        push(a + b);
        E_linha();
        break;

    case '-':
        consome('-');
        T();
        b = pop();
        a = pop();
        pos_fixo('-');
        push(a * b);
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
        pos_fixo('*');
        push(a * b);
        T_linha();
        break;

    case '/':
        consome('/');
        F();
        b = pop();
        a = pop();
        pos_fixo('/');
        push(a / b);
        T_linha();
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
        push(tokenval);
        break;

    case ID:
        consome(ID);
        break;

    default:
        erro_sint(119, linha_input);
    }
}

void consome(int t)
{
    if(token == t)
        token = analex();

    else
        erro_sint(129, linha_input);
}

void erro_sint(int linha, int linha_input)
{
    printf("ERRO SINTATICO LINHA  %i: Token invalido", linha, linha_input);
    exit(1);
}

void pos_fixo(char operador)
{
    char holder;
    char contratrio[100];
    char ab;
    int amom = a;
    char ba;
    int bmom = b;

    while(amom >= 1)
    {
        holder = amom % 10;
        strcat(contratrio, &holder);
        amom = amom/10;
    }

    strrev(contratrio);
    strcat(posfix, contratrio);

    memset(contratrio,0,strlen(contratrio));

    while(bmom >= 1)
    {
        holder = bmom % 10;
        strcat(contratrio, &holder);
        amom = bmom/10;
    }

    strrev(contratrio);
    strcat(posfix, contratrio);

    memset(contratrio,0,strlen(contratrio));

    strcat(posfix, &ab);
    strcat(posfix, &ba);
    strcat(op, &operador);
}

