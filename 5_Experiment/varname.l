%{
#include <stdio.h>
#include "varname.tab.h"
%}

%%

[a-zA-Z][a-zA-Z0-9_]*   { return VALID_VAR; }    // Starts with letter, followed by letters/digits/underscores
[^a-zA-Z\n]+            { return INVALID_VAR; }  // Invalid if it doesn't start with a letter
\n                     { /* End of input line */ return 0; }

%%
int yywrap() {
    return 1;
}
 