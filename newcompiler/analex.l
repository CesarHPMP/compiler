%{
    #include "tokens.h"
    #include "tabsimb.h"
    int nline = 1;
%}

/* Regular Expressions */
dig [0-9]
letra [a-zA-Z]

%%

"/*"([^*]|\*[^/])*"*/"  {}
"//".*  {}

"+" {return UPLUS;}               
"-" {return UMINUS;}              
"*" {return UTIMES;}              
"/" {return UDIVIDE;}             
"=" {return ASSIGN_OP;}           
"==" {return EQ;}                 
"!=" {return NOTEQ;}              
">=" {return GE;}                 
"<=" {return LTEQ;}              
">" {return GT;}                 
"<" {return LT;}                      


"RUN_IT" {return DO;}  
"NO_PASS_TAKES_IT_TO_THE_RIM" {return WHILE_LOOP;}
"BLOCKED_BY_JAMES" {return BREAK;} 
"DECIDES_NOT_TO_CALL_TIMEOUT" {return CONTINUE;} 
"AIRNESS" {return CHAR;}
"BIG_FUNDAMENTAL" {return INTEGER;}
"LEBRONTO" {return FLOATING;} 
"BIG_DIESEL" {return STRING;}      
"GOAT" {return CONST;}                     
"FAST_BREAK" {return GOTO;}                
"NUMBER_RETIRED" {return HEX_CONST;}       
"NEW_ROOKIE" {return IMPORT;}              
"SEVEN-FOOTER" {return LONG;}              
"BENCH_WARMER" {return REGISTER;}          
"NO_TRADE_CONTRACT" {return RESTRICT;} 
"SHOT_CLOCK_EXPIRED" {return RETURN;}     
"FLOATER_IN_THE_LANE" {return SHORT;}     
"SHOOTING_FOUL" {return SIGNED;}          
"SHOT_ATTEMPT" {return SIZEOF;}           
"INJURED_RESERVE" {return STATIC;}        
"TEAM_CHEMISTRY" {return STRUCT;}         
"HEAD_COACH" {return SWITCH;}             
"GAME_PLAN" {return TEMPLATE;}            
"ROLE_ASSIGNMENT" {return TYPEDEF;}      
"PLAYER_TRADE" {return UNION;}           
"ALL-STAR_VOTE" {return UNSIGNED;}       
"PISTONS" {return VOID;}       
"FOUL_TROUBLE" {return VOLATILE;}     
"BUZZER_BEATER" {return IF;}
"BANG" {return ELSE;}
"ITS_ALL_OVER"  {return RETURN;}

{dig}+("."{dig}+)?	{ return NUM;}
{letra}({letra}|{dig})*  {insere(yytext); return IDENTIFIER;}  
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