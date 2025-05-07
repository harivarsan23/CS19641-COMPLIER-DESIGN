%{
#include <stdio.h>
#include "sum.tab.h"

extern int yylval;
%}

%%

[0-9]+       { yylval = atoi(yytext); return NUMBER; }
[ \t]        { /* ignore whitespace */ }
\n           { return '\n'; }
"+"          { return '+'; }
"-"          { return '-'; }
"*"          { return '*'; }
"/"          { return '/'; }
"("          { return '('; }
")"          { return ')'; }

.            { printf("Invalid character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
