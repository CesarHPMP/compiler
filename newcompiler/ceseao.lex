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

"//".*  { /* Ignore single-line comments */ }
"/*"([^*]|\*[^/])*"*/"  { /* Ignore multi-line comments */ }

"+" {return PLUS;}
"break" {return BREAK;}
"case" {return CASE;}
"catch" {return CATCH;}
"char" {return CHAR;}
"const" {return CONST;}
"continue" {return CONTINUE;}
"default" {return DEFAULT;}
"do" {return DO;}
"double" {return DOUBLE;}
"else" {return ELSE;}
"enum" {return ENUM;}
"export" {return EXPORT;}
"extern" {return EXTERN;}
"float_const" {return FLOAT_CONST;}
"goto" {return GOTO;}
"hex_const" {return HEX_CONST;}
"import" {return IMPORT;}
"inline" {return INLINE;}
"long" {return LONG;}
"namespace" {return NAMESPACE;}
"oct_const" {return OCT_CONST;}
"private" {return PRIVATE;}
"protected" {return PROTECTED;}
"public" {return PUBLIC;}
"register" {return REGISTER;}
"restrict" {return RESTRICT;}
"return" {return RETURN;}
"short" {return SHORT;}
"signed" {return SIGNED;}
"sizeof" {return SIZEOF;}
"static" {return STATIC;}
"struct" {return STRUCT;}
"switch" {return SWITCH;}
"template" {return TEMPLATE;}
"this" {return THIS;}
"throw" {return THROW;}
"try" {return TRY;}
"typedef" {return TYPEDEF;}
"union" {return UNION;}
"unsigned" {return UNSIGNED;}
"void" {return VOID;}
"volatile" {return VOLATILE;}
"while" {return WHILE_LOOP;}


"if" {return IF;}
"int" {return INT;}
"float" {return FLOAT;}
"==" {return EQ;}
">=" {return GE;}
"-" {return MINUS;}
"*" {return TIMES;}
"/" {return DIVIDE;}
"(" {return LPAREN;}
")" {return RPAREN;}
"{" {return LBRACE;}
"}" {return RBRACE;}
";" {return SEMICOLON;}
"," {return COMMA;}
":" {return COLON;}
"=" {return ASSIGN;}
"!=" {return NOTEQ;}
"<>" {return LTGT;}
"+=" {return PLUSASSIGN;}
"-=" {return MINUSASSIGN;}
"*=" {return TIMESASSIGN;}
"/=" {return DIVIDEASSIGN;}
"%=" {return MODASSIGN;}
"++=" {return PLUSPLUSASSIGN;}
"--=" {return MINUSMINUSASSIGN;}
"[" {return LBRACKET;}
"]" {return RBRACKET;}
"%" {return MOD;}
">>" {return GTGT;}
"<<" {return LTLT;}
"<=" {return LTEQ;}
"&&" {return ANDAND;}
"||" {return OROR;}
"!" {return NOT;}
"++" {return INC;}
"--" {return DEC;}

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
        token = yylex();
    }
    imprime();
    return 0;
}