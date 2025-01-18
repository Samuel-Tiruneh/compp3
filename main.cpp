#include <cstdio>
#include <cstdlib>
extern FILE *yyin;
int yyparse();

int main(int argc, char** argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            fprintf(stderr, "Error: cannot open file %s\n", argv[1]);
            return 1;
        }
    }
    yyparse();
    return 0;
}
