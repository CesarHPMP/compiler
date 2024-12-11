%{ 
	/* Para simplificar a notação, S é para sintetizar. A atualizar. V verificar */
    #include <string.h>
	#ifndef  ANALEX
	#include "analex.c"
	#define ANALEX
	#endif 
    #ifndef  CODIGO
	#include "codigo.h"
    #define CODIGO
    #endif
    #ifndef TIPOS
    #include "tipos.h"
    #define TIPOS
    #endif
%}

%union {
    int ival;   /* Para armazenar números inteiros */
}

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
%type <node> If While Compound_Stt DoWhile FunctionCall Decl

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
    TypeF ID '(' ParamList ')' '{' Statement_Seq '}' {
        adiciona_funcao_tabela(obtemNome($2), $1, &$4);
        create_cod(&$$.code);
    }
    | TypeF ID '(' ')' '{'Statement_Seq '}' {
        adiciona_funcao_tabela(obtemNome($2), $1, NULL); 
        Funct(&$$, $2, $6);                
    }
    ;
	
FunctionCall :
    ID '(' ArgList ')' {
        int funcPos = $1; 
        if (funcPos == -1) {
            yyerror("Função não declarada!");
        } else if (Tabela[funcPos].tam_arg_list != $3.tam) {
            yyerror("Número de argumentos incompatível!");
        }
        Call(&$$, funcPos, $3);
    } /* V declaração, # argumentos. S código*/
    | ID '(' ')' {
        int funcPos = procura(obtemNome($1));
        if (funcPos == -1) {
            yyerror("Função não declarada!");
        } else if (Tabela[funcPos].tam_arg_list != 0) {
            yyerror("Número de argumentos incompatível!");
        }
        Call_blank(&$$);
    } /* V declaração, # argumentos. S código*/
    ;

    
ArgList:
    Exp ',' ArgList {
        create_cod(&$$.code);
        $$.tam = $3.tam + 1; 
        $$.ids[0] = $1.place; 
        for (int i = 0; i < $3.tam; i++) 
        {
            $$.ids[i + 1] = $3.ids[i];
        }
        insert_cod(&$$.code, $1.code);
        insert_cod(&$$.code, $3.code);
    } /* S código e Lista de IDs*/
    | Exp {
        create_cod(&$$.code);
        $$.tam = 1;
        $$.ids[0] = $1.place;
        insert_cod(&$$.code, $1.code);
    } /* S código e Lista de IDs*/
    ;


ParamList: 
    ParamList ',' Type ID {
        $$.ids[$$.tam] = insere(obtemNome($4));
        if(getTipo($4) == -1)
            set_type($$.ids[$$.tam], $3);
        else 
            if(getTipo($4) != $3)
                yyerror("Tipos de argumentos incompatíveis!");
        $$.tam++;
    } /* S Lista de IDs. A Tabela*/
    | Type ID {
        $$.ids[$$.tam] = insere(obtemNome($2));
        if(getTipo($2) == -1)
            set_type($$.ids[$$.tam], $1);
        else 
            if(getTipo($2) != $1)
                yyerror("Tipos de argumentos incompatíveis!");
        } /* S Lista de IDs. A Tabela*/
    ;

Decl:
    Type IDs {
        int tipo;
        create_cod(&$$.code);
        if ($2.code != NULL)
            insert_cod(&$$.code, $2.code);

        for (int i = 0; i < $2.tam; i++)
         {
            tipo = getTipo($2.ids[i]);
            if (tipo != $1 && tipo != -1) 
            {
                printf("O tipo %i de %s não é %i\n", tipo, obtemNome($2.ids[i]), $1);
                yyerror("Erro Semântico Decl");
            }
            printf("Iteração %i, pos %i, ID %s, Tipo %d;\n", i, $2.ids[i], obtemNome($2.ids[i]), $1);
            set_type($2.ids[i], $1);  // Define o tipo corretamente
            
        }

        // Certifique-se de que o tamanho da lista é reinicializado
        $2.tam = 0;
    }
    ;


IDs: 
    IDs ',' ID {
        for ($$.tam = 0; $$.tam < $1.tam; $$.tam++) 
        {
            $$.ids[$$.tam] = $1.ids[$$.tam];
            printf("Transferindo %s para %s\n IDs, ID\n", obtemNome($$.ids[$$.tam]), obtemNome($1.ids[$$.tam]));
        }
        $$.ids[$$.tam] = procura(obtemNome($3));  // Add the new identifier
        $$.tam++;  // Increment the tam
    }
    | IDs ',' Atribuicao {
        for ($$.tam = 0;$$.tam < $1.tam; $$.tam++) 
        {
            $$.ids[$$.tam] = $1.ids[$$.tam];
            printf("Transferindo %s para %s\n, Ids atrib", obtemNome($$.ids[$$.tam]), obtemNome($1.ids[$$.tam]));
        }

        int pos = procura(obtemNome($3.place));
        create_cod(&$$.code);
        insert_cod(&$$.code, $3.code);
        $$.ids[$$.tam] = pos;
        $$.tam++;  // Increment the tam
    }
    | IDs ',' ID '[' NUM ']' {
        if($5.tipo != INT)
            yyerror("Erro Semântico, array com tipo diferente de int");
        for ($$.tam = 0; $$.tam < $1.tam; $$.tam++) 
        {
            $$.ids[$$.tam] = $1.ids[$$.tam];
            printf("Transferindo %s para %s\n Ids ID vec", obtemNome($$.ids[$$.tam]), obtemNome($1.ids[$$.tam]));
        }
        $$.ids[$$.tam] = $3;  // Add the new identifier with array
        $$.tam++;
    }
    | ID '[' NUM ']' 
    {
        if($3.tipo != INT)
            yyerror("Erro Semântico, array com tipo diferente de int");
        $$.ids[$$.tam] = $1;  // Handle single array element
        $$.tam++;
    }
    | ID 
    {
        $$.tam = 1;
        $$.ids[$$.tam] = $1;  // Handle single ID
    }
    | Atribuicao 
    {
        int pos = $1.place;
        create_cod(&$$.code);
        insert_cod(&$$.code, $1.code);
        $$.ids[$$.tam] = pos;  // Handle assignment
    }
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
    Statement Statement_Seq {
        create_cod(&$$.code);
        insert_cod(&$$.code, $1.code);
        insert_cod(&$$.code, $2.code);
    } /* S Codigo. */
    | Statement {
        create_cod(&$$.code);
        insert_cod(&$$.code, $1.code);
    } /* S Codigo. Exemplo */
    ;

		
Statement: 
	  Atribuicao ';' {
        procura(obtemNome($1.place));
        if($1.tipo == -1)
        {
            yyerror("Erro Semântico, var não declarada");
        }
        retorna_maior_tipo(Tabela[$1.place].tipo, $1.tipo);
        create_cod(&$$.code);
        insert_cod(&$$.code, $1.code);
    } /* V declaracao, tipos atribuicao. */
	| If  
    {
        create_cod(&$$.code);
        insert_cod(&$$.code, $1.code);
    }/* S código. */
	| While 
    {
        create_cod(&$$.code);
        insert_cod(&$$.code, $1.code);
    } /* S código. */
	| DoWhile 
    {
        create_cod(&$$.code);
        insert_cod(&$$.code, $1.code);
    }/* S código. */
	| FunctionCall ';' 
    {
        create_cod(&$$.code);
        insert_cod(&$$.code, $1.code);
    }  /* S código. */
    | Decl ';' 
    {
        create_cod(&$$.code);
        insert_cod(&$$.code, $1.code);
    }
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
    WHILE '(' Exp ')' Compound_Stt {
        While(&$$, $3, $5);
    }
    ;

DoWhile:
    DO Compound_Stt WHILE '(' Exp ')' ';' {
        DoWhile(&$$, $2, $5);
    }
    ;

			
Atribuicao : 
    ID '[' NUM ']' '=' Exp 
    {
        if (getTipo($3.tipo) != INT) 
        {
            yyerror("Erro Semântico: Tipo incompatível para atribuição com índice");
        }

        // Valida o tipo da expressão
        if (retorna_maior_tipo(getTipo($1), $6.tipo) == -1) 
        {
            yyerror("Erro Semântico: Tipo da expressão incompatível com a variável");
        }
        create_cod(&$$.code);
        if($3.code != NULL)
            insert_cod(&$$.code, $3.code);

        Atrib(&$$, $3);
        
        $$.tipo = retorna_maior_tipo(getTipo($1), $6.tipo);
        $$.place = $1;
    } /* V tipo indice. S tipo, place, código. */
    | ID '=' Exp 
    {
        create_cod(&$$.code);
        if($3.code != NULL)
            insert_cod(&$$.code, $3.code);
        Atrib(&$$, $3);  // Gera o código para a atribuição
        $$.tipo = retorna_maior_tipo(getTipo($1), $3.tipo);
        $$.place = $1;
    } /* S tipo, place, código. */
    ;

				
Exp :
	  Exp '+' Exp {
        create_cod(&$$.code);
        if($1.code != NULL)    
            insert_cod(&$$.code, $1.code);
        if($3.code != NULL)
            insert_cod(&$$.code, $3.code);
        $$.tipo = retorna_maior_tipo($1.tipo, $3.tipo);
        ExpAri(&$$, $1, $3, "add");
        } /* S tipo, cod */
	| Exp '-' Exp {
        printf("Passo começo");
        create_cod(&$$.code);
        printf("Passo antes if $1");
        if($1.code != NULL)
            insert_cod(&$$.code, $1.code);
        printf("Passo antes if $3");
        if($3.code != NULL)
            insert_cod(&$$.code, $3.code);
        printf("Passo pos if");
        
        $$.tipo = retorna_maior_tipo($1.tipo, $3.tipo);
        ExpAri(&$$, $1, $3, "sub");
        } /* S tipo, cod */
	| Exp '*' Exp {        
        create_cod(&$$.code);
        if($1.code != NULL)
            insert_cod(&$$.code, $1.code);
        if($3.code != NULL)
            insert_cod(&$$.code, $3.code);
        $$.tipo = retorna_maior_tipo($1.tipo, $3.tipo);
        ExpAri(&$$, $1, $3, "mul");
        } /* S tipo, cod */
	| Exp '/' Exp {
        create_cod(&$$.code);
        if($1.code != NULL)
            insert_cod(&$$.code, $1.code);
        if($3.code != NULL)
            insert_cod(&$$.code, $3.code);
        $$.tipo = retorna_maior_tipo($1.tipo, $3.tipo);
        ExpAri(&$$, $1, $3, "div");
        } /* S tipo, cod */
	| Exp '>' Exp {
        create_cod(&$$.code);
        if($1.code != NULL)
            insert_cod(&$$.code, $1.code);
        if($3.code != NULL)
            insert_cod(&$$.code, $3.code);
		$$.tipo = INT;
		Bgt(&$$, $1, $3, "bgt");
		} /* S tipo, cod (bgt) */
	| Exp '<' Exp {
        create_cod(&$$.code);
        if($1.code != NULL)
            insert_cod(&$$.code, $1.code);
        if($3.code != NULL)
            insert_cod(&$$.code, $3.code);
		$$.tipo = INT;
		Bgt(&$$, $1, $3, "blt");
		} /* S tipo, cod (blt) */
	| Exp GE Exp  {
        create_cod(&$$.code);
        if($1.code != NULL)
            insert_cod(&$$.code, $1.code);
        if($3.code != NULL)
            insert_cod(&$$.code, $3.code);
		$$.tipo = INT;
		Bgt(&$$, $1, $3, "blt");
		} /*  S tipo. Não precisa implementar código*/
	| Exp LE Exp  {
        create_cod(&$$.code);
        if($1.code != NULL)
            insert_cod(&$$.code, $1.code);
        if($3.code != NULL)
            insert_cod(&$$.code, $3.code);
		$$.tipo = INT;
		Bgt(&$$, $1, $3, "bgt");
		} /*  S tipo. Não precisa implementar código*/
	| Exp EQ Exp  {
        create_cod(&$$.code);
        if($1.code != NULL)
            insert_cod(&$$.code, $1.code);
        if($3.code != NULL)
            insert_cod(&$$.code, $3.code);
		$$.tipo = INT;
		Bgt(&$$, $1, $3, "beq");
		} /*  S tipo. Não precisa implementar código*/
	| Exp NEQ Exp {
        create_cod(&$$.code);
        if($1.code != NULL)
            insert_cod(&$$.code, $1.code);
        if($3.code != NULL)
            insert_cod(&$$.code, $3.code);
		$$.tipo = INT;
		Bgt(&$$, $1, $3, "bnq");
	} /*  S tipo. Não precisa implementar código*/
	| Exp OR Exp {
        create_cod(&$$.code);
        if($1.code != NULL)
            insert_cod(&$$.code, $1.code);
        if($3.code != NULL)
            insert_cod(&$$.code, $3.code);
		$$.tipo = INT;
		Explog(&$$, $1, $3, "or");
	} /* S tipo, cod */
	| Exp AND Exp {
        create_cod(&$$.code);
        if($1.code != NULL)
            insert_cod(&$$.code, $1.code);
        if($3.code != NULL)
            insert_cod(&$$.code, $3.code);
		$$.tipo = INT;
		Explog(&$$, $1, $3, "and");
	} /* S tipo, cod */
	| NOT Exp {
        create_cod(&$$.code);
        if($2.code != NULL)
            insert_cod(&$$.code, $2.code);
		$$.tipo = INT;
	} /*  S tipo. Não precisa implementar código*/
	| '(' Exp ')' {
        create_cod(&$$.code);
        if($2.code != NULL)
            insert_cod(&$$.code, $2.code);
		$$.tipo = $2.tipo;
	} /*  S tipo, cod*/
	| NUM {
        if (strchr(yytext, '.') != NULL) 
        {
            $$.tipo = FLOAT;
        } else {
            $$.tipo = INT;
        }
        create_cod(&$$.code);
        if($1.code != NULL)
            insert_cod(&$$.code, $1.code);
        Li(&$$, yylval.ival);
	} /* S tipo, código */
	| ID '[' NUM ']' {
        $$.tipo = getTipo($1);
        if($$.tipo == -1)
        {
            yyerror("Erro Semântico, var não declarada");
        }
        if($3.tipo != INT)
        {
            yyerror("Erro Semântico, índice não é inteiro");
        }
        create_cod(&$$.code);
        if($3.code != NULL)
            insert_cod(&$$.code, $3.code);
        Li(&$$, $1);
        
    }  /* V declaracao, indice. S tipo, codigo  */
	| ID  {
        $$.tipo = getTipo($1);
        if($$.tipo == -1)
        {
            yyerror("Erro Semântico, var não declarada");
        }

    } /* V declaracao. S tipo, codigo  */
	| STRING {} /* Ignore, não precisa implementar  */
	;   
	
	
%%  
int main(int argc, char **argv) {     
    yydebug = 1;
    yyin = fopen(argv[1],"r");
    yyparse();      
} 

/* Funcoes auxiliares podem ser implementadas aqui */
