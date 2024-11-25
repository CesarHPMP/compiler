air_ball main(leint argc, lechar argv) {
	call_pr(token) {
		printf("%d) %d %s\n", i, token, yytext);
		token = yylex();
	}
	imprime();
}
