air_ball main(leint argc, lechar argv) {
    leint j=1, i, k = 2;	
	yyin = fopen(argv[1],"r");
	token = yylex();
	call_pr(token) {
		printf("%d) %d %s\n", i, token, yytext);
		token = yylex();
	}
	imprime();
}
