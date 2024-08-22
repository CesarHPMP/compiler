#include "analex.h"
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
void consome(int);
void erro_sint();

int main()
{
    token = analex();

    E();

    int holder = tam;

    while(holder > 0)
        printf("\npilha: %d\n", Pilha[holder--]);

    if(token == ';')
        printf("Sem erros sintaticos");
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
        a = pop();
        b = pop();
        push(a + b);
        E_linha();
        break;

    case '-':
        consome('-');
        T();
        a = pop();
        b = pop();
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
        a = pop();
        b = pop();
        push(a * b);
        T_linha();
        break;

    case '/':
        consome('/');
        F();
        a = pop();
        b = pop();
        push(a / b);
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
    printf("ERRO SINTATICO LINHA  %i: Token invalido", linha);
    exit(1);
}

