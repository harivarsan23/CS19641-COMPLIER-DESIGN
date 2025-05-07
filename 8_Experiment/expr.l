%{
#include "expr.tab.h"
#include <string.h>
%}

%%

[ \t\n]                  ; // Skip whitespace

[a-zA-Z_][a-zA-Z0-9_]*   { yylval.str = strdup(yytext); return ID; }
[0-9]+                   { yylval.str = strdup(yytext); return NUMBER; }
"="                      { return ASSIGN; }
[\+\-\*/]                { yylval.op = yytext[0]; return OPERATOR; }
"("                      { return LPAREN; }
")"                      { return RPAREN; }
";"                      { return SEMI; }

.                        { return yytext[0]; }

%%

int yywrap(void) {
    return 1;
}
