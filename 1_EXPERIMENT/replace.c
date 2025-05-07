#include <stdio.h>
int main() {
    char str[100];
    char oldChar, newChar;
    int i;
    printf("Enter a string: ");
    fgets(str, sizeof(str), stdin);
    printf("Enter the character to replace: ");
    scanf(" %c", &oldChar);
    printf("Enter the new character: ");
    scanf(" %c", &newChar);
    for(i=0; str[i]!='\0'; i++) {
        if(str[i] == oldChar) {
            str[i] = newChar;
        }
    }
    printf("Modified string: %s\n", str);
    return 0;
}
