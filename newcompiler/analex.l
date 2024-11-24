%{
    #include "parser.tab.h"
    #include "tabsimb.h"
	#include <stdlib.h>
    int nline = 1;
%}

/* Regular Expressions */
dig [0-9]
letra [a-zA-Z]
underscore ["_"]

%%

"+" {return '+';}               
"-" {return '-';}              
"*" {return '*';}              
"/" {return '/';}             
"=" {return '=';}           
"==" {return EQ;}                 
"!=" {return DIFF;}              
">=" {return GE;}                 
"<=" {return LEQ;}              
">" {return '>';}                 
"<" {return '<';}          
"(" {return '(';}
")" {return ')';}
"{" {return '{';}
"}"  {return '}';}
"[" {return '[';}
"]" {return ']';}
";" {return ';';}
',' {return ',';}
"&&" {return AND;}
"||" {return OR;}
"!" {return '!';}

"air_ball" {return VOID;}
"leint" {return INT;}
"lefloat" {return FLOAT;}
"shoots" {return IF;}
"bounces_on_rim" {return ELSE;}
"call_iso" {return FOR;}
"call_pr" {return WHILE_LOOP;}
"turnover" {return RETORNA;}
"lechar" {return CHARACTER;}
"shotclock_expired" {return ENDIF;}

("-")?{dig}+("."{dig}+)? {
	yylval = atoi(yytext);
	return NUM;
	}
{letra}({letra}|{dig}|{underscore})*  {insere(yytext); return ID;}  
[ \t\r] {}
\n	{ nline++; }
.	{printf("erro lexico na linha %d - %s\n", nline, yytext); }


%%

#ifndef yywrap
int yywrap() { return 1; }
#endif

int yyerror(char *s)
{
	fprintf(stderr,"%s na linha %d\n", s, nline);
}