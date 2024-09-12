%{
    #include "tokens.h"
    #include "tabsimb.h"
    int nline = 1;
%}
/*Expressoes Regulares simple */
Dig [0-9]
DigNO [1-9]
Letra [a-z A-Z]
%%

"==" {return EQ;}
">=" {return GE;}
"if" {return IF;}
"int" {return INT;}
"float" {return FLOAT;}
{DigNO}{Dig}+|0 {return NUM;}
{Letra}({Dig}|{Letra})* {insere(yytext);}{return ID;} 
%%
/*Funcoes*/
int main(int argc, char **argv)
{
    int token, i = 1;
    yyin = fopen(argv[1], "r");
    token = yylex();
    while(token)
    {
        int token = yylex();
    }
    imprime();
    return 0;
}
