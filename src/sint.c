#include "analex.h"
#ifndef PILHA_H__
#include "pilha.h"
#define PILHA_H__
#endif // PILHA_H__
#include <string.h>

int token;
char num[1000];
int x = 0;
char charhold;

void E();
void E_linha();
void T();
void T_linha();
void F();
void consome(int);
void erro_sint();

// Configurar resto do output para bater com o exigido.

int main()
{
    token = analex();

    int j = 0;

    E();

    if(token == ';')
    {
        printf("EXPRESSAO CORRETA\n");
        printf("NOTACAO POSFIXA: %s\n", num);  
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
        num[x] = ' ';
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
        num[x] = ' ';
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
        T_linha();
        F();
        charhold = '*';
        strcpy(&num[x], &charhold);
        x++;
        num[x] = ' ';
        x++;
        b = pop();
        a = pop();
        push(a * b);
        break;

    case '/':
        consome('/');
        F();
        charhold = '/';
        strcpy(&num[x], &charhold);
        x++;
        num[x] = ' ';
        x++;
        b = pop();
        a = pop();
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
        int make_char = tokenval;
        int len = 0;
        while (make_char != 0)
        {
            make_char = make_char/10;
            len++;
        }

        if (len == 0) 
        {
            len = 1;
            num[x] = '0';
            x++;
        }

        make_char = tokenval;

        for (int i = (len - 1) + x; i >= x; i--)
        {
        num[i] = (make_char % 10) + '0';
        make_char /= 10;
        }

        x += len;
        num[x] = ' ';
        x++;

        push(tokenval);
        break;

    case ID:
        consome(ID);
        break;

    default:
        erro_sint(linha_input);
    }
}

void consome(int t)
{
    if(token == t)
        token = analex();

    else
        erro_sint(linha_input);
}

void erro_sint(int linha)
{
    printf("ERRO SINTATICO NA LINHA %i\n", linha);
    exit(1);
}

