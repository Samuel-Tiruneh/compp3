%{
    #include "parser.tab.h"
    #include "globals.h"
    extern int yylineno;
%}

%option yylineno
%option noyywrap

alpha [a-zA-Z]
digit [0-9]

%%

"int"                       { return INT; }
"float"                     { return FLOAT; }
"char"                      { return CHAR; }
"return"                    { return RETURN; }
{alpha}({alpha}|{digit})*   { return ID; }
{digit}+                    { return NUMBER; }
";"                         { return ';'; }
"="                         { return '='; }
"("                         { return '('; }
")"                         { return ')'; }
"+"                         { return '+'; }
"{"                         { return '{'; }
"}"                         { return '}'; }
\n                          { yylineno++; current_column = 0; return '\n'; }  // Increment line number
[ \t\r]+                    { current_column += yyleng; }
.                           { current_column++; return yytext[0]; }
%%

int custom_yywrap() {
    return 1;
}
