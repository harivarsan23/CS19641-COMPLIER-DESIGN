%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
%}

%token VALID_VAR INVALID_VAR

%%
input:
    VALID_VAR     { printf("VALID VARIABLE NAME\n"); }
  | INVALID_VAR   { printf("INVALID VARIABLE NAME\n"); }
;
%%

void yyerror(const char *s) {
    // Do nothing to suppress extra syntax errors
}

int main() {
    printf("Enter a variable name: ");
    yyparse();
    return 0;
}
