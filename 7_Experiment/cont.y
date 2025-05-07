%{
#include <stdio.h>
#include <stdlib.h>

extern FILE *yyin;
int yylex(void);
void yyerror(const char *s);
%}

%token FOR WHILE IF ELSE SWITCH CASE DEFAULT
%token LBRACE RBRACE LPAREN RPAREN SEMICOLON COLON COMMA
%token ID NUMBER RELOP ASSIGNOP

%%

program:
    statements
    ;

statements:
    statement
    | statements statement
    ;

statement:
    for_loop
    | while_loop
    | if_else
    | if_elseif_else
    | switch_case
    ;

for_loop:
    FOR LPAREN ID ASSIGNOP NUMBER SEMICOLON ID RELOP NUMBER SEMICOLON ID ASSIGNOP ID RPAREN LBRACE RBRACE
    {
        printf("Valid For loop syntax\n");
    }
    ;

while_loop:
    WHILE LPAREN ID RELOP NUMBER RPAREN LBRACE RBRACE
    {
        printf("Valid While loop syntax\n");
    }
    ;

if_else:
    IF LPAREN ID RELOP NUMBER RPAREN LBRACE RBRACE ELSE LBRACE RBRACE
    {
        printf("Valid If-Else syntax\n");
    }
    ;

if_elseif_else:
    IF LPAREN ID RELOP NUMBER RPAREN LBRACE RBRACE
    ELSE IF LPAREN ID RELOP NUMBER RPAREN LBRACE RBRACE
    ELSE LBRACE RBRACE
    {
        printf("Valid If-Else-If syntax\n");
    }
    ;

switch_case:
    SWITCH LPAREN ID RPAREN LBRACE CASE NUMBER COLON RBRACE DEFAULT COLON RBRACE
    {
        printf("Valid Switch-Case syntax\n");
    }
    ;

%%

void yyerror(const char *s) {
    printf("Syntax Error: %s\n", s);
}

int main(int argc, char *argv[]) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("File open failed");
            return 1;
        }
        yyin = file;
    }
    yyparse();
    return 0;
}
