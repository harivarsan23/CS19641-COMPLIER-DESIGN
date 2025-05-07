#include <stdio.h>
#include <string.h>
#include <ctype.h>
const char *keywords[] = {"int", "float", "char", "if", "else", "for", "while", "return", "void", "switch", "case", "break", "continue", "struct", "typedef", "include"};
const int keyword_count = sizeof(keywords) / sizeof(keywords[0]);
int isKeyword(char *word) {
    for (int i = 0; i < keyword_count; i++) {
        if (strcmp(word, keywords[i]) == 0) {
            return 1;
        }
    }
    return 0;
}
int isOperator(char ch) {
    char operators[] = "+-*/%=!<>&|^";
    return strchr(operators, ch) != NULL;
}
int isSpecialSymbol(char ch) {
    char special_symbols[] = "{}()[],;";
    return strchr(special_symbols, ch) != NULL;
}
int main() {
    char code[500];
    printf("Enter the C code snippet: \n");
    fgets(code, sizeof(code), stdin);  
    char token[50];
    int index = 0;
    printf("\nTokens:\n");   
    for (int i = 0; code[i] != '\0'; i++) {
        char ch = code[i];
        if (isspace(ch) || isSpecialSymbol(ch) || isOperator(ch)) {
            if (index > 0) {
                token[index] = '\0';
                if (isKeyword(token)) {
                    printf("Keyword: %s\n", token);
                } else if (isalpha(token[0]) || token[0] == '_') {
                    printf("Identifier: %s\n", token);
                }
                index = 0;
            }
            if (isSpecialSymbol(ch)) {
                printf("Special Symbol: %c\n", ch);
            } else if (isOperator(ch)) {
                printf("Operator: %c\n", ch);
            }
        } else {
            token[index++] = ch;
        }
    }
    return 0;
}
