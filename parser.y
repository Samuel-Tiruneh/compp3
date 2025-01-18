%{
    #include <cstdio>
    #include <cstdlib>
    #include "globals.h"
    extern int yylineno;
    int yylex();
    void yyerror(const char *s);
%}

%token INT FLOAT CHAR ID NUMBER RETURN
%start program

%left '+'
%left '='

%%

program: declarations
       | function
       ;

declarations: declaration
            | declarations declaration
            ;

declaration: type ID ';'
           | type ID '=' expression ';'
           | type ID '=' expression error {
               yyerror("Syntax error");
               yyclearin;
               yyerrok;
           }
           | type ID error {
               yyerror("Syntax error");
               yyclearin;
               yyerrok;
           }
           ;

function: type ID '(' ')' '{' declarations 'return' expression ';' '}'
         | type ID '(' ')' '{' error '}' {
               yyerror("Syntax error");
               yyclearin;
               yyerrok;
           }
         ;

type: INT
    | FLOAT
    | CHAR
    ;

expression: NUMBER
          | ID
          | expression '+' expression
          ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}
