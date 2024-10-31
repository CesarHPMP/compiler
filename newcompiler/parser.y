%{
    #include "analex.c"
%}

%token NUM      
%token ID       
%token INT      
%token GE       
%token IF       
%token ELSE     
%token WHILE_LOOP  
%token LEQ      
%token GEQ          
%token EQ       
%token DIFF     
%token FLOAT    
%token VOID     
%token STRING      
%token AND      
%token OR           
%token FOR      
%token RETORNA  
%token CHARACTER 
%token ENDIF

%left '+' '-'
%left '*' '/'
%start Prog

%%

/* START PROGRAM */

Prog:
    LISTAFUNC
    ;

/* UTILS */
DECL:
    TIPO LISTAID 
    | TIPO ATR
    ;

TIPO: 
    INT | CHARACTER | FLOAT | STRING | VOID 
    ;
    
LISTAIDS:
    ID ',' LISTAID
    | ID 
    | ATR ',' LISTAID
    | ATR
    ;

/* EXPRESSION STUFF */
EXP:
    EXP '+' EXP {
        $$ = $1 + $3;
    } 
    | EXP '-' EXP {
        $$ = $1 - $3;
    } 
    | EXP '*' EXP {
        $$ = $1 * $3;
    } 
    | EXP '/' EXP {
        $$ = $1 / $3;
    } 
    
    /* expressoes aritmeticas */ 

    | EXP AND EXP {
        $$ = $1 * $3;
    }

    | EXP OR EXP {
        $$ = $1 + $3;
    }

    | !EXP {
        printf("Não sei esse");
    } 
    
    /* expressoes logicas */

    | EXP '>' EXP 

    | EXP '<' EXP

    | EXP GE EXP 

    | EXP LEQ EXP

    | EXP EQ EXP

    | EXP DIFF EXP

    /* expressoes de comparacao */

    | '(' EXP ')' {
        $$ = $2;
    }
    | NUM {
        $$ = yylval;
    }
    | ID {
        $$ = yytext;
      | ID'['NUM']'        $$ = yytext;
    | FUNKCALL ';'
    ; 

ATR:    
    ID '=' EXP 
    
    | ID'['NUM']' '=' EXP
    ;

LISTAEXP: 
    EXP ',' LISTAEXP
    | EXP 
    ;

/* STATEMENTS */
WST:
    WHILE_LOOP '(' EXP ')' ComandoComposto
    ;

FST:
    FOR '('ID ';' EXP ';' EXP')'
    ;

IFST:
    IF '(' EXP ')' ComandoComposto ENDIF
    | IF '(' EXP ')' ComandoComposto ELSE ComandoComposto ENDIF
    ;


/* COMANDO */
LISTACOMANDO:
    COMANDO LISTACOMANDO
    | COMANDO
    ;

COMANDO: 
    EXP ';'
    | ATR ';'
    | WST 
    | FST 
    | IFST 
    | FUNKCALL ';'
    ;


/* FUNCIONS */
FUNKCALL:
    ID'(' LISTAEXP ')'
    ;

FUNCSTM:
    DECLFUNC'(' LISTADECLFUN ')' '{'LISTACOMANDO'}'
    | DECLFUNC'(' ')' '{'LISTACOMANDO'}'
    ;

DECLFUNC:
    TIPO ID
    ;

LISTADECLFUNC:
    DECLFUNC ',' LISTADECLFUNC
    | DECLFUNC
    ;

LISTAFUNC:
    FUNCSTM LISTADECLFUNC
    | FUNCSTM
    ;

%%

void main(int argc, char **argv)
{
    yyin = fopen(argv[1], "r");
    yyparse();
}

