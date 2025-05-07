%{
#include <stdio.h>
#include <string.h>
%}

%%
"int"|"float"|"if"|"else"|"return" { printf("Keyword: %s\n", yytext); }

[a-zA-Z_][a-zA-Z0-9_]* { printf("Identifier: %s\n", yytext); }

[0-9]+ { printf("Constant (Integer): %s\n", yytext); }
[0-9]+"."[0-9]+ { printf("Constant (Float): %s\n", yytext); }

"+"|"-"|"*"|"/"|"="|"=="|"!=" { printf("Operator: %s\n", yytext); }

"//".* { printf("Comment: %s\n", yytext); }
"/"([^]|\[^/])\*"/" { printf("Comment (Multiline)\n"); }

"{"|"}"|"("|")"|";"|"," { printf("Special Symbol: %s\n", yytext); }

[ \t\n]  ;  /* Ignore whitespace */
%%

int yywrap() { return 1; }

int main() {
    printf("Enter C code snippet (Ctrl+D to end input):\n");
    yylex();
    return 0;
}