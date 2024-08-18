#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#define NUM 256
#define ID 257
#define QUIT 258
#define PRINT 259

int analex();
int erro_lex();

int tokenval = 0;

int analex()
{
    char ch;
    int temp_tokenval;
    ch = getchar();

    switch (ch)
    {
    case '+':
        return '+';
           
    case '/':
        return '/';

    case '-':
        return '-';

    case '*':
        return '*';

    case '(':
        return '(';

    case ')':
        return ')';

    case ';':
        return ';';

    default:
        if(ch == '\n' || '\t' || ' ')
        {
            return 
        }
        else
            erro_lex();
    }

    if(isdigit(ch))
    {
        while(isdigit(ch))
        {
            temp_tokenval = ch - '0';
            tokenval = temp_tokenval + tokenval; 
            ch = getchar();
        }
        return NUM;
    }

    printf("ERRO LEXICO LINHA X: Token invalido");
    exit(1);
}

void erro_lex()
{
    printf("ERRO lexico LINHA X: input invalido");
    exit(1);
}
