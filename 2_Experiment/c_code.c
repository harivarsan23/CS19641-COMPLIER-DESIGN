#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define MAX_TOKENS 100

const char *keywords[] = {"int", "char", "float", "double", "if", "else", "while", "for", "return", "void", "switch", "case"};
const char operators[] = "+-*/=<>!&|";
const char delimiters[] = ",;";   
const char specialSymbols[] = "{}()[]";

int isKeyword(char *word) {
    for (int i = 0; i < sizeof(keywords) / sizeof(keywords[0]); i++) {
        if (strcmp(word, keywords[i]) == 0) {
            return 1;
        }
    }
    return 0;
}

int isOperator(char ch) {
    return strchr(operators, ch) != NULL;
}

int isDelimiter(char ch) {
    return strchr(delimiters, ch) != NULL;
}

int isSpecialSymbol(char ch) {
    return strchr(specialSymbols, ch) != NULL;
}

void analyzeTokens(char *code) {
    int i = 0;
    char token[100];
    int tokenIndex = 0;
    
    printf("Token Analysis:\n");
    while (code[i] != '\0') {
        if (isspace(code[i])) {
            i++;
            continue;
        }
        
        if (isalpha(code[i])) {
            tokenIndex = 0;
            while (isalnum(code[i])) {
                token[tokenIndex++] = code[i++];
            }
            token[tokenIndex] = '\0';
            
            if (isKeyword(token)) {
                printf("Keyword: %s\n", token);
            } else {
                printf("Identifier: %s\n", token);
            }
        } else if (isdigit(code[i])) {
            tokenIndex = 0;
            while (isdigit(code[i])) {
                token[tokenIndex++] = code[i++];
            }
            token[tokenIndex] = '\0';
            printf("Number: %s\n", token);
        } else if (isOperator(code[i])) {
            printf("Operator: %c\n", code[i]);
            i++;
        } else if (isDelimiter(code[i])) {
            printf("Delimiter: %c\n", code[i]);
            i++;
        } else if (isSpecialSymbol(code[i])) {
            printf("Special Symbol: %c\n", code[i]);
            i++;
        } else {
            i++;
        }
    }
}

int main() {
    char code[500] = "";
    char line[100];
    printf("Enter the C code snippet (type END to finish):\n");
    while (fgets(line, sizeof(line), stdin)) {
        if (strcmp(line, "END\n") == 0) break;
        strcat(code, line); 
    }
    analyzeTokens(code);
    return 0;
}
