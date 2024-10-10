air_ball main(leint argc, lechar **argv) {
leint token,i=1;	
	yyin = fopen(argv[1],"r");
	token = yylex();
	call_pr(token) {
		printf("%d) %d %s\n", i++, token, yytext);
		token = yylex();
	}
	imprime();
}
