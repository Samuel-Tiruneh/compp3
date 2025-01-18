%{
    #include "parser.tab.h"
    extern int yylineno;  // Ensure yylineno is declared
%}

%option yylineno

alpha [a-zA-Z]
digit [0-9]

%%
"int"                       { return INT; }
"float"                     { return FLOAT; }
"char"                      { return CHAR; }
{alpha}({alpha}|{digit})*   { return ID; }
{digit}+                    { return NUMBER; }
[\n]                        { yylineno++; } // Increment line number for newline
[ \t\r]+                    { /* ignore whitespace */ }
.                           { return yytext[0]; }
%%

int yywrap() {
    return 1;
}
