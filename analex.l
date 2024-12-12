%{
    #ifndef SEMANTICA
    #include "semantic.h"
    #define SEMANTICA
    #endif
    #ifndef TABSIMB
    #define TABSIMB 
    #include "tabsimb.h"
    #endif
	#include <stdlib.h>
    int nline = 1;
    int yy_tipo;
%}

dig [0-9]
letra [a-zA-Z]
underscore ["_"]
zero[0]

%%

"+" {return '+';}               
"-" {return '-';}              
"*" {return '*';}              
"/" {return '/';}             
"=" {return '=';}           
"==" {return EQ;}                 
"!=" {return NEQ;}              
">=" {return GE;}                 
"<=" {return LE;}              
">" {return '>';}                 
"<" {return '<';}          
"(" {return '(';}
")" {return ')';}
"{" {return '{';}
"}"  {return '}';}
"[" {return '[';}
"]" {return ']';}
";" {return ';'; }
"," {return ',';}
"&&" {return AND;}
"||" {return OR;}
"!" {return '!';}

"air_ball" {return VOID;}
"leint" {return INT;}
"lefloat" {return FLOAT;}
"shoots" {return IF;}
"rebound" {return ELSE;}
"coach_play" {return DO;}
"call_iso" {return FOR;}
"call_pr" {return WHILE;}
"turnover" {return RETORNA;}
"lechar" {return CHAR;}
"shotclock_expired" {return ENDIF;}

("-")?{dig}+("."{zero}+)? {
    yylval.ival = atoi(yytext);
    yy_tipo = INT;
    return NUM;
    }

("-")?{dig}+("."{dig}+)? {
    yylval.fval = atof(yytext);
    yy_tipo = FLOAT;

	return NUM;
	}

{letra}({letra}|{dig}|{underscore})*  {
    yylval.val = insere(yytext); 
    return ID;
    }  

"/*"([^*]|\*[^/])*"*/"  {}
"//".*  {}

\"[^\"]*\" {return STRING;} 
[ \t\r] {}
\n	{ nline++; }
.	{printf("erro lexico na linha %d - %s\n", nline, yytext); }


%%

#ifndef yywrap
int yywrap() { return 1; }
#endif

int yyerror(char *s)
{
	printf("%s na linha %d\n", s, nline);
	exit(0);
}
