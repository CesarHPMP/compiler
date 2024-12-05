%{ 
	/* Para simplificar a notação, S é para sintetizar. A atualizar. V verificar */
	#ifndef  ANALEX
	#include "analex.c"
	#define ANALEX
	#endif 
	#ifndef CODIGO
	#include "codigo.h" 
	#endif
%}

%union{
	struct no{
		int place;
		char *code;
		int tipo;
	} node;
	int val;
	struct ids{
		int ids[50];
		int tam;
		char *code;
	} id_list;
}

%token <node> NUM 
%token <val> ID 
%token WHILE
%token IF 
%token ELSE
%token ENDIF
%token CHAR
%token INT
%token FLOAT
%token VOID
%token OR
%token AND
%token NOT
%token GE
%token LE
%token EQ
%token NEQ
%token DO
%token STRING
%token FOR
%token RETORNA

%type <val> Type TypeF
%type <id_list> IDs ParamList ArgList
%type <node> Atribuicao Exp Function Prog Statement Statement_Seq 
%type <node> If While Compound_Stt DoWhile FunctionCall

%right '='

%left OR
%left AND

%nonassoc EQ NEQ

%left '>' '<' GE LE

%left '+' '-'
%left '*' '/' '%'

%right NOT

%right '(' '['


%start ProgL
%% 
ProgL : Prog {
		printf("%s",$1.code);
	} /* S código. */
    ;
    
Prog : Prog Function {
		create_cod(&$$.code); 
		insert_cod(&$$.code,$1.code); 
		insert_cod(&$$.code,$2.code);
	} /* S código. */
	| Function /* S código. */
	;	

Function :
	TypeF ID '(' ParamList ')' '{' Decls Statement_Seq '}'  {} /* A. Tabela. S código. */
	| TypeF ID '(' ')' '{' Decls Statement_Seq '}'  {} /* A. Tabela. S código. */
	;
	
FunctionCall :
    ID '(' ArgList ')' {} /* V declaração, # argumentos. S código*/
	| ID '(' ')' {} /* V declaração, # argumentos. S código*/
    ;
    
ArgList:
    Exp ',' ArgList {} /* S código e Lista de IDs*/
    | Exp  {} /* S código e Lista de IDs*/
    ;

ParamList: 
    ParamList ',' Type ID  {} /* S Lista de IDs. A Tabela*/
    | Type ID {} /* S Lista de IDs. A Tabela*/
	; 
		
Decls:
	  Decl ';' Decls  
	| 
	;

Decl:
	Type IDs {} /* A tabela. */
	; 
	
IDs :
	  IDs ',' ID {} /* S Lista de IDs. */
	| IDs ',' Atribuicao {} /* S Lista de IDs. */
	| IDs ',' ID '[' NUM ']' {} /* S Lista de IDs. */
	| ID '[' NUM ']' {} /* S Lista de IDs. */
	| ID {} /* S Lista de IDs. */
	| Atribuicao {} /* S Lista de IDs. */
	;
	
TypeF :
	  VOID {$$ = VOID;} /* S Tipo. */
	| Type {$$ = $1;}
	;

Type :
	  INT {$$ = INT;} /* S Tipo. */
	| CHAR {$$ = CHAR;} /* S Tipo. */
	| FLOAT {$$ = FLOAT;} /* S Tipo. */
	;
			
Statement_Seq :
	Statement Statement_Seq {?} /* S Codigo. */
	| Statement { create_cod(&$$.code); insert_cod(&$$.code,$1.code);} /* S Codigo. Exemplo */
	;
		
Statement: 
	  Atribuicao ';' {verifica_var_declarada($1.place); verifica_tipos_atrib(Tabela[$1.place].tipo, $1.tipo);} /* V declaracao, tipos atribuicao. */
	| If  /* S código. */
	| While /* S código. */
	| DoWhile /* S código. */
	| FunctionCall ';'  /* S código. */
	;

Compound_Stt :
	  Statement  /* S código. Exemplo resolvido */
	| '{' Statement_Seq '}' {$$ = $2;}  /* S código. Exemplo resolvido */
	;
		
If :
	  IF '(' Exp ')' Compound_Stt ENDIF { 
		If(&$$, $3,$5);
	} /* S código. Exemplo */
	| IF '(' Exp ')' Compound_Stt ELSE Compound_Stt ENDIF {
		IfElse(&$$, $3, $5, $7);
	} /* S código. */
	;

While:
	WHILE '(' Exp ')' Compound_Stt  {} /* S código. */
	;

DoWhile:
	DO Compound_Stt WHILE '(' Exp ')' ';' {} /* S código. */
	;
			
Atribuicao : 
	ID '[' NUM ']' '=' Exp {
    	if (procura($1) == -1)
    		Atrib(&$$, $3);
    	else
    		yyerror("Erro Semântico")
    	/* Teste de tipo e validade de vetor não implementado*/	
	} /* V tipo indice. S tipo, place, código. */
    | ID '=' Exp {
    	if (procura($1) == -1)
    		Atrib(&$$, $3);
    	else
    		yyerror("Erro Semântico")
    } /* S tipo, place, código. */
	;
				
Exp :
	  Exp '+' Exp {ExpAri(&$$, $1, $3, "add");} /* S tipo, cod */
	| Exp '-' Exp {ExpAri(&$$, $1, $3, "sub");} /* S tipo, cod */
	| Exp '*' Exp {ExpAri(&$$, $1, $3, "mul");} /* S tipo, cod */
	| Exp '/' Exp {ExpAri(&$$, $1, $3, "div");} /* S tipo, cod */
	| Exp '>' Exp {
		$$.tipo = INT;
		Bgt(&$$, $1, $3, "bgt");
		} /* S tipo, cod (bgt) */
	| Exp '<' Exp {
		$$.tipo = INT;
		Bgt(&$$, $1, $3, "blt");
		} /* S tipo, cod (blt) */
	| Exp GE Exp  {
		$$.tipo = INT;
		Bgt(&$$, $1, $3, "blt");
		} /*  S tipo. Não precisa implementar código*/
	| Exp LE Exp  {
		$$.tipo = INT;
		Bgt(&$$, $1, $3, "bgt");
		} /*  S tipo. Não precisa implementar código*/
	| Exp EQ Exp  {
		$$.tipo = INT;
		Bgt(&$$, $1, $3, "beq");
		} /*  S tipo. Não precisa implementar código*/
	| Exp NEQ Exp {
		$$.tipo = INT;
		Bgt(&$$, $1, $3, "bnq");
	} /*  S tipo. Não precisa implementar código*/
	| Exp OR Exp {
		$$.tipo = INT;
		Explog(&$$, $1, $3, "or");
	} /* S tipo, cod */
	| Exp AND Exp {
		$$.tipo = INT;
		Explog(&$$, $1, $3, "and");
	} /* S tipo, cod */
	| NOT Exp {
		$$.tipo = INT;
	} /*  S tipo. Não precisa implementar código*/
	| '(' Exp ')' {
		$$.tipo = $2.tipo;
	} /*  S tipo, cod*/
	| NUM {
		$$.tipo = $1.tipo;
	} /* S tipo, código */
	| FLOAT {
		$$.tipo = FLOAT;
	}
	| ID '[' NUM ']' {}  /* V declaracao, indice. S tipo, codigo  */
	| ID  {} /* V declaracao. S tipo, codigo  */
	| STRING {} /* Ignore, não precisa implementar  */
	;   
	
	
%%  
int main(int argc, char **argv) {     
  yyin = fopen(argv[1],"r");
  yyparse();      
} 

/* Funcoes auxiliares podem ser implementadas aqui */
