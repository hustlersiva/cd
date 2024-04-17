#include <stdio.h>
#include <ctype.h>
#include <string.h>

void checkKeyword(char str[10]) {
    char *keywords[] = {"for", "while", "do", "int", "float", "char", "double", "static", "switch", "case", "void", "printf"};
    for (int i = 0; i < sizeof(keywords) / sizeof(keywords[0]); i++) {
        if (strcmp(keywords[i], str) == 0) {
            printf("\n%s is a keyword", str);
            return;
        }
    }
    printf("\n%s is an identifier", str);
}

int main() {
    FILE *input_file;
    char c, str[10];
    int num;
    input_file = fopen("input.txt", "r");
    if (input_file == NULL) {
        perror("Error opening file");
        return -1;
    }

    printf("Keywords and Identifiers:\n");

    while ((c = fgetc(input_file)) != EOF) {
        if (isdigit(c)) {
            ungetc(c, input_file);
            fscanf(input_file, "%d", &num);
            printf("\n%d is a number", num);
        } else if (isalpha(c) || c == '_') {
            int i = 0;
            str[i++] = c;
            while ((c = fgetc(input_file)) != EOF && (isalnum(c) || c == '_')) {
                str[i++] = c;
            }
            str[i] = '\0';
            ungetc(c, input_file);
            checkKeyword(str);
        } else if (c == ' ' || c == '\t' || c == '\n') {
            continue;
        } else {
            printf("\n%c is a special character", c);
        }
    }

    fclose(input_file);
    return 0;
}
