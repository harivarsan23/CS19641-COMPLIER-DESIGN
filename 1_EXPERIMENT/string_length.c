#include <stdio.h>
#include <string.h>

int main() {
    char str[100], substr[100];
    int i, j, found;
    printf("Enter the main string: ");
    fgets(str, sizeof(str), stdin);

    str[strcspn(str, "\n")] = '\0';
    printf("Enter the substring to search: ");
    fgets(substr, sizeof(substr), stdin);
    
    substr[strcspn(substr, "\n")] = '\0'; 
    int len_str = strlen(str);
    int len_substr = strlen(substr);
    found = 0;
    for (i = 0; i <= len_str - len_substr; i++) {
        for (j = 0; j < len_substr; j++) {
            if (str[i + j] != substr[j]) {
                break;
            }
        }
        if (j == len_substr) {
            found = 1;
            printf("Substring found at index: %d\n", i);
            break;
        }
    }
    if (!found) {
        printf("Substring not found.\n");
    }
    return 0;
}
