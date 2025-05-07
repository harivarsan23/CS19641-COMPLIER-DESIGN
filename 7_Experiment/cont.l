%{
#include "cont.tab.h"
%}

%%

"for"           { return FOR; }
"while"         { return WHILE; }
"if"            { return IF; }
"else"          { return ELSE; }
"switch"        { return SWITCH; }
"case"          { return CASE; }
"default"       { return DEFAULT; }

"{"             { return LBRACE; }
"}"             { return RBRACE; }
"("             { return LPAREN; }
")"             { return RPAREN; }
";"             { return SEMICOLON; }
":"             { return COLON; }
","             { return COMMA; }

"<="|">="|"=="|"!="|"<"|">"   { return RELOP; }
"="|"+"|"-"|"*"|"/"           { return ASSIGNOP; }

[0-9]+                        { return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]*        { return ID; }

[ \t\r\n]+                    ;   // skip whitespace

.                             { return yytext[0]; }

%%
int yywrap(void) { return 1; }
