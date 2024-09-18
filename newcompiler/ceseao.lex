%{
    #include "tokens.h"
    #include "tabsimb.h"
    int nline = 1;
%}

/* Regular Expressions */
Dig [0-9]
Letra [a-zA-Z]

%%

"//".*  { /* Ignore single-line comments */ }
"/*"([^*]|\*[^/])*"*/"  { /* Ignore multi-line comments */ }

"+" {return PLUS;}                /* "ASSIST" */
"-" {return MINUS;}               /* "BLOCK" */
"*" {return TIMES;}               /* "MULTIPLY POINTS" */
"/" {return DIVIDE;}              /* "DIVIDE POSSESSIONS" */
"=" {return ASSIGN;}              /* "TIMEOUT" */
"==" {return EQ;}                 /* "ALL-STAR GAME TIE" */
"!=" {return NOTEQ;}              /* "MISSED SHOT" */
">=" {return GE;}                 /* "OVERTIME GAME" */
"<=" {return LTEQ;}               /* "GAME-WINNING SHOT" */
"++" {return INC;}                /* "BACK-TO-BACK SHOTS" */
"--" {return DEC;}                /* "BACK-TO-BACK TURNOVERS" */
"&&" {return ANDAND;}             /* "LOCKDOWN DEFENSE" */
"||" {return OROR;}               /* "SCREEN AND ROLL" */
"!" {return NOT;}                 /* "FULL COURT PRESS" */
"(" {return LPAREN;}              /* "START OF QUARTER" */
")" {return RPAREN;}              /* "END OF QUARTER" */
"{" {return LBRACE;}              /* "START OF HALF" */
"}" {return RBRACE;}              /* "END OF HALF" */
";" {return SEMICOLON;}           /* "HALFTIME BREAK" */
"," {return COMMA;}               /* "ASSIST" */
":" {return COLON;}               /* "COACH'S CHALLENGE" */
"[" {return LBRACKET;}            /* "STARTING FIVE ANNOUNCEMENT" */
"]" {return RBRACKET;}            /* "PLAYER INTRODUCTION" */


"RUN IT" {return DO;}  
"NO PASS, TAKES IT TO THE RIM" {return WHILE_LOOP;}
"BLOCKED BY JAMES" {return BREAK;} 
"DECIDES NOT TO CALL A TIMEOUT" {return CONTINUE;} 
"AIRNESS" {return CHAR;}
"BIG FUNDAMENTAL" {return INT;}
"LEBRONTO" {return FLOAT;} 
"BIG DIESEL" {return STRING;}      
"GOAT" {return CONST;}                     
"FAST BREAK" {return GOTO;}                
"NUMBER RETIRED" {return HEX_CONST;}       
"NEW ROOKIE" {return IMPORT;}              
"SEVEN-FOOTER" {return LONG;}              
"TEAM HUDDLE" {return NAMESPACE;}          
"OFF-THE-BENCH SCORER" {return PRIVATE;}   
"LOCKDOWN DEFENDER" {return PROTECTED;}    
"FRANCHISE PLAYER" {return PUBLIC;}        
"BENCH WARMER" {return REGISTER;}          
"NO TRADE CONTRACT" {return RESTRICT;} 
"SHOT CLOCK EXPIRED" {return RETURN;}     
"FLOATER IN THE LANE" {return SHORT;}     
"SHOOTING FOUL" {return SIGNED;}          
"SHOT ATTEMPT" {return SIZEOF;}           
"INJURED RESERVE" {return STATIC;}        
"TEAM CHEMISTRY" {return STRUCT;}         
"HEAD COACH" {return SWITCH;}             
"GAME PLAN" {return TEMPLATE;}            
"PASS OUT OF THE DOUBLE TEAM" {return THROW;} 
"ATTEMPTS A POST-UP" {return TRY;}       
"ROLE ASSIGNMENT" {return TYPEDEF;}      
"PLAYER TRADE" {return UNION;}           
"ALL-STAR VOTE" {return UNSIGNED;}       
"PISTONS" {return VOID;}       
"FOUL TROUBLE" {return VOLATILE;}     
"BUZZER BEATER" {return IF;}
"OVERTIME" {return ELSE;}

{Dig}+ {return NUM;}                      /* Numbers */
{Letra}({Letra}|{Dig})* {insere(yytext); return ID;}  /* Identifiers */

%%

/* Main Function */
int main(int argc, char **argv)
{
    int token;
    yyin = fopen(argv[1], "r");
    token = yylex();
    while(token)
    {
        token = yylex();
    }
    imprime();
    return 0;
}
