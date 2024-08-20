#include "analex.h"

int token;

void E();
void E_linha();
void T();
void T_linha();
void F();
void consome(int, arvore);
void erro_sint();
int calcular(Pilha);

int main()
{
    token = analex();
    
    E();


    if(token == ';')
        printf("Sem erros sintaticos");
    else
        erro_sint();

    calcular();

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
        push(token);
        T();
        E_linha();
        break;
    
    case '-':
        consome('-');
        push(token)
        T();
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
        T_linha();
        break;
    
    case '/':
        consome('/');
        F();
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
        push(token);
        break;

    case ID:
        consome(ID);
        push(token);
        break;

    default:
        erro_sint();
    }
}

void consome(int t)
{
    if(token == t)
        token = analex();

    else
        erro_sint();
}

void erro_sint()
{
    printf("ERRO SINTATICO LINHA X: Token invalido");
    exit(1);
}

int calcular(Pilha pilha)
{

}
