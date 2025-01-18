%{
    #include <cstdio>
    #include <cstdlib>
    extern int yylineno;  // Declare yylineno
    int yylex();          // Declare yylex
    void yyerror(const char *s);
%}
%token INT FLOAT CHAR ID NUMBER
%%
program: declarations
       ;
declarations: declaration
            | declarations declaration
            ;
declaration: type ID ';'
           | type ID '=' expression ';'
           ;
type: INT
    | FLOAT
    | CHAR
    ;
expression: NUMBER
          | ID
          ;
%%
void yyerror(const char *s) {
    fprintf(stderr, "Syntax error at line %d: %s\n", yylineno, s);
}
