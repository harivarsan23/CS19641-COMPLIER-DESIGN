#include <stdio.h>
int main() {
    char a[100],b[100];
    int i,j=0;
    printf("Enter a string: ");
    fgets(a,sizeof(a),stdin);
    for(i=0;a[i]!='\0';i++) {
        if(a[i]!=' ') {
            b[j++]=a[i];
        }
    }
    b[j]='\0'; 
    printf("String without spaces: %s\n",b);
    return 0;
}
