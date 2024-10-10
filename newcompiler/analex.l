%{
    #include "tokens.h"
    #include "tabsimb.h"
    int nline = 1;
%}

/* Regular Expressions */
dig [0-9]
letra [a-zA-Z]
underscore ["_"]

%%

"/*"([^*]|\*[^/])*"*/"  {}
"//".*  {}

\"[^\"]*\" {return STRING;} 

"+" {return UPLUS;}               
"-" {return UMINUS;}              
"*" {return MUL;}              
"/" {return DIV;}             
"=" {return ASSIGN_OP;}           
"==" {return EQ;}                 
"!=" {return DIFF;}              
">=" {return GE;}                 
"<=" {return LEQ;}              
">" {return GT;}                 
"<" {return LT;}          
"""" {return STRING;}
"(" {return LPAREN;}
")" {return RPAREN;}
"{" {return LBRACE;}
"}"  {return RBRACE;}
"[" {return LSQUARE;}
"]" {return RSQUARE;}
";" {return USEMICOLON;}
"," {return COMMA;}
"&&" {return AND;}
"||" {return OR;}
"!" {return NOT;}

"air_ball" {return VOID;}
"leint" {return INT;}
"lefloat" {return FLOAT;}
"shoots" {return IF;}
"bounces_on_rim" {return ELSE;}
"call_iso" {return FOR;}
"call_pr" {return WHILE_LOOP;}
"turnover" {return RETORNA;}
"lechar" {return CHARACTER;}

("-")?{dig}+("."{dig}+)?	{return NUM;}
{letra}({letra}|{dig}|{underscore})*  {insere(yytext); return ID;}  
[ \t\r] {}
\n	{ nline++; }
.	{printf("erro lexico na linha %d - %s\n", nline, yytext); }
%%

#ifndef yywrap
int yywrap() { return 1; }
#endif

/* Main Function */

void main(int argc, char **argv) {
int token,i=1;	
	yyin = fopen(argv[1],"r");
	token = yylex();
	while(token) {
		printf("%d) %d %s\n", i++, token, yytext);
		token = yylex();
	}
	imprime();
}