#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#define NUM 256
#define ID 257
#define QUIT 258
#define PRINT 259

int tokenval;

int analex()
{
    char ch;

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
    }

    if(isdigit(ch))
    {
        while(isdigit(ch))
        {
            tokenval = ch - '0' + tokenval;
            ch = getchar();
        }
        return NUM;
    }

    printf("ERRO LEXICO LINHA X: Token invalido");
    exit(1);
}