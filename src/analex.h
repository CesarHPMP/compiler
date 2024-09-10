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
int linha_input = 1;

int analex()
{
    char ch;
    int temp_tokenval;
    ch = getchar();

    while(isspace(ch))
    {
        if(ch == '\n')
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

        erro_lex(linha_input);
    }


    erro_lex(linha_input);
}

void erro_lex(int linha)
{
    printf("ERRO LEXICO NA LINHA %i\n", linha);
    exit(1);
}
