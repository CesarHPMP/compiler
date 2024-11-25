    %debug

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
    %token COMMA

    %left OR
    %left AND
    %left '>' '<' GE LEQ EQ DIFF
    %left '+' '-'
    %left '*' '/'
    %right '!'
    %nonassoc ELSE


    %start ProgL

    %%

    /* START PROGRAM */

    ProgL : Prog {printf("Sem erros sintáticos\n");}
        ;

    Prog:
        LISTAFUNC
        ;

    /* COMANDO */
    LISTACOMANDO:
        COMANDO LISTACOMANDO
        | COMANDO
        ;

    COMANDO: 
        ATR ';'
        | WST 
        | FST 
        | IFST 
        | DECL ';'
        | FUNKCALL ';'
        | RETORNAEXP ';' 
        ;

    ComandoComposto:
        '{'LISTACOMANDO'}'
        |COMANDO
        ;

    DECL:
        TIPO LISTAIDS
        ;

    /* FUNCTIONS */
    FUNKCALL:
        ID'(' LISTAEXP ')'
        | ID'(' ')'
        ;

    FUNCSTM:
        DECLFUNC '(' ')' '{'LISTACOMANDO'}' 
        | DECLFUNC '(' LISTADECLFUNC ')' '{'LISTACOMANDO'}'
        ;

    DECLFUNC:
        TIPO ID
        ;

    LISTADECLFUNC:
        DECLFUNC ',' LISTADECLFUNC
        | DECLFUNC
        ;

    LISTAFUNC:
        FUNCSTM LISTAFUNC
        | FUNCSTM
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
            $$ = $1 && $3;
        }

        | EXP OR EXP {
            $$ = $1 || $3;
        }

        | '!'EXP {
            $$ = !$2;
        } 
        
        /* expressoes logicas */

        | EXP '>' EXP {
            $$ = $1 > $3;
        }

        | EXP '<' EXP {
            $$ = $1 < $3;
        }

        | EXP GE EXP {
            $$ = $1 >= $3;
        }

        | EXP LEQ EXP {
            $$ = $1 <= $3;
        }

        | EXP EQ EXP {
            $$ = $1 == $3;
        }

        | EXP DIFF EXP {
            $$ = $1 != $3;
        }

        /* expressoes de comparacao */

        | '(' EXP ')' {
            $$ = $2;
        }
        | NUM {
            $$ = yylval;
        }
        | ID 
        | ID'['NUM']'
        | FUNKCALL ';'
        | STRING
        ; 

    ATR:    
        ID '=' EXP 
        | ID'['NUM']' '=' EXP
        ;

    /* UTILS */

    TIPO: 
        INT | CHARACTER | FLOAT | STRING | VOID 
        ;
        
    LISTAIDS:
        ID ',' LISTAIDS
        | ATR ',' LISTAIDS
        | ATR
        | ID 
        ;


    LISTAEXP: 
        EXP ',' LISTAEXP
        | EXP 
        ;

    RETORNAEXP:
        RETORNA 
        | RETORNA EXP
        ;

    %%

    void main(int argc, char **argv)
    {
        yydebug = 0;
        yyin = fopen(argv[1], "r");
        yyparse();
    }

