#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#define NUM 256
#define ID 257
#define QUIT 258
#define PRINT 259

int analex();
void erro_lex(int );
int tokenval = 0;
int linha_input = 0;

int analex()
{
    char ch;
    int temp_tokenval;
    ch = getchar();
    linha_input++;

    while(isspace(ch))
    {
        linha_input++;
        ch = getchar();
    }

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
        if(isdigit(ch))
        {
        tokenval = 0;
            while(isdigit(ch))
            {
                temp_tokenval = ch - '0';
                tokenval = (tokenval * 10) + temp_tokenval;
                ch = getchar();

            }
            ungetc(ch, stdin);
            return NUM;
        }

        printf("CH é %i\n", ch);
        erro_lex(54);
    }


    erro_lex(67);
}

void erro_lex(int linha)
{
    printf("ERRO lexico LINHA %i: input invalido \n", linha);
    exit(1);
}
