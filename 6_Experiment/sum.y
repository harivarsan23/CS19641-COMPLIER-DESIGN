%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
%}

%token NUMBER
%left '+' '-'
%left '*' '/'
%left UMINUS

%%

input:
    expr '\n' { printf("Result = %d\n", $1); return 0; }
  ;

expr:
    expr '+' expr    { $$ = $1 + $3; }
  | expr '-' expr    { $$ = $1 - $3; }
  | expr '*' expr    { $$ = $1 * $3; }
  | expr '/' expr    {
                        if ($3 == 0) {
                            yyerror("Division by zero!");
                            exit(1);
                        }
                        $$ = $1 / $3;
                    }
  | '-' expr %prec UMINUS { $$ = -$2; }
  | '(' expr ')'     { $$ = $2; }
  | NUMBER           { $$ = $1; }
  ;

%%

void yyerror(const char *s) {
    printf("Syntax Error: %s\n", s);
}

int main() {
    printf("Enter an arithmetic expression:\n");
    yyparse();
    return 0;
}
