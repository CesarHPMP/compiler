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

%left '+' '-'
%left '*' '/'
%start Prog

%%

Prog: EXP ';' { printf("Valor da exp %d\n", $1);} 
    ; 

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
    | '(' EXP ')' {
        $$ = $2;
    }
    | NUM {
        $$ = yylval;
    }
    | ID {
        $$ = $$;
    }
    ; 

%%

void main(int argc, char **argv)
{
    yyin = fopen(argv[1], "r");
    yyparse();
}

