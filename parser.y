%{
    #include <stdio.h>
    #include <string.h>

    extern int yylex();
    extern int yyparse();
    void yyerror(const char *);

    FILE *file;
%}

%union {
    char *sval;
}

%token <sval> H1 H2 H3 H4 H5 H6
%token <sval> UL
%token <sval> STRONG S EM INS MARK
%token <sval> TEXT

%type <sval> content
%type <sval> title
%type <sval> list
%type <sval> text
%type <sval> font

%%
start:
    | start content {
        printf("match: %s\n", $2);
        fprintf(file, "%s\n", $2);
        free($2);
    }
;
content:
    title {
        $$ = $1;
    }
    | list {
        $$ = $1;
    }
    | text {
        $$ = $1;
    }
    | font {
        $$ = $1;
    }
;
title:
    H1 {
        $$ = $1;
    }
    | H2 {
        $$ = $1;
    }
    | H3 {
        $$ = $1;
    }
    | H4 {
        $$ = $1;
    }
    | H5 {
        $$ = $1;
    }
    | H6 {
        $$ = $1;
    }
;
list:
    UL {
        $$ = $1;
    }
;
text:
    TEXT {
        $$ = $1;
    }
;
font:
    STRONG {
        $$ = $1;
    }
    | S {
        $$ = $1;
    }
    | EM {
        $$ = $1;
    }
    | INS {
        $$ = $1;
    }
    | MARK {
        $$ = $1;
    }
;
%%

void yyerror(const char *s)
{
    printf("error: %s\n", s);
}

int main()
{
    file = fopen("test.html", "w");
    yyparse();
    fclose(file);
}