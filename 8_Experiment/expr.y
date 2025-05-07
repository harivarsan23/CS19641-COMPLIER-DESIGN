%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int temp_id = 0;
char* new_temp();
void yyerror(const char *s);
int yylex(void);
%}

// Define precedence and associativity to resolve shift/reduce conflicts
%left '+' '-'
%left '*' '/'

%union {
    char* str;
    struct {
        char* place;
    } val;
    char op;
}

%token <str> ID NUMBER
%token <op> OPERATOR
%token ASSIGN LPAREN RPAREN SEMI
%type <val> expr statement

%%

program:
    statement SEMI { printf("\n"); }
    ;

statement:
    ID ASSIGN expr {
        printf("%s = %s\n", $1, $3.place);
    }
    ;

expr:
    expr OPERATOR expr {
        char* temp = new_temp();
        printf("%s = %s %c %s\n", temp, $1.place, $2, $3.place);
        $$ = (typeof($$)){ strdup(temp) };
    }
    | LPAREN expr RPAREN {
        $$ = $2;
    }
    | NUMBER {
        $$ = (typeof($$)){ strdup($1) };
    }
    | ID {
        $$ = (typeof($$)){ strdup($1) };
    }
    ;

%%

char* new_temp() {
    char temp[10];
    sprintf(temp, "t%d", temp_id++);
    return strdup(temp);
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter the expression followed by ';':\n");
    return yyparse();
}
