#include <stdio.h>
#include <string.h>
int main()
{
    char a[25];
    char b[25];
    printf("Enter first string: ");
    scanf("%s", a);
    printf("Enter second string:");
    scanf("%s", b);
    if(strcmp(a, b) != 0)
    {
        printf("Strings are not equal\n");
    }
    else
    {
        printf("Strings are equal\n");
    }
}