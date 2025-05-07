%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

int is_valid = 1; 
int has_valid_token = 0; 


int yywrap(void) { return 1; }  
%}

%%
"end"[ \t\n]* { exit(0); }  
[0-9]+(\.[0-9]+)? { printf("NUMBER: %s\n", yytext); has_valid_token = 1; } 
[\+\-\*/] { printf("OPERATOR: %s\n", yytext); has_valid_token = 1; } 
[\(\)] { printf("PARENTHESIS: %s\n", yytext); has_valid_token = 1; }
[ \t]+  { /* Ignore spaces and tabs */ }
\n { 
    if (has_valid_token && is_valid) {
        printf("VALID arithmetic expression.\n");
    } else {
        printf("INVALID arithmetic expression.\n");
    }
    has_valid_token = 0; 
    is_valid = 1; 
    return 0; 
}  // Go to the next line when Enter is pressed
. { printf("ERROR: Invalid character '%c'\n", yytext[0]); is_valid = 0; } 
%%

int main() {
    printf("Enter arithmetic expressions (type 'end' to quit):\n");

    while (1) {
        printf("\n> ");  // Display prompt on each new line
        is_valid = 1;
        has_valid_token = 0;
        yylex();  // Process input
    }
    return 0;
}
