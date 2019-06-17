%{
    #include <stdio.h>
    #include <string.h>
    #include <ctype.h>
    #include "parser.tab.h"

    char* chomp(char *s)
    {
        for (int i = strlen(s) - 1; i >= 0; i--) {
            if (isspace(s[i])) s[i] = '\0';
        }
        return s;
    }

    char* erase_tag(char *s, int front, int end)
    {
        char *temp = (char*)calloc(strlen(s) - front - end + 1, sizeof(char));
        strncpy(temp, s + front, strlen(s) - front - end);
        strcpy(s, temp);
        free(temp);
        return s;
    }

    char* concat(int length, char stag[], const char *middle, char etag[])
    {
        char *s = (char*)calloc(length, sizeof(char));
        strncpy(s, stag, strlen(stag));
        strncat(s, middle, strlen(middle));
        strcat(s, etag);
        return s;
    }
%}

strong "**"
s "~~"
em "*"
ins "++"
mark "=="

%%
^"# ".+ {
    int length = strlen(yytext) - 2 + 10;
    yylval.sval = concat(length, "<h1>", chomp(erase_tag(yytext, 2, 0)), "</h1>");
    return H1;
}
^"## ".+ {
    int length = strlen(yytext) - 3 + 10;
    yylval.sval = concat(length, "<h2>", chomp(erase_tag(yytext, 3, 0)), "</h2>");
    return H2;
}
^"### ".+ {
    int length = strlen(yytext) - 4 + 10;
    yylval.sval = concat(length, "<h3>", chomp(erase_tag(yytext, 4, 0)), "</h3>");
    return H3;
}
^"#### ".+ {
    int length = strlen(yytext) - 5 + 10;
    yylval.sval = concat(length, "<h4>", chomp(erase_tag(yytext, 5, 0)), "</h4>");
    return H4;
}
^"##### ".+ {
    int length = strlen(yytext) - 6 + 10;
    yylval.sval = concat(length, "<h5>", chomp(erase_tag(yytext, 6, 0)), "</h5>");
    return H5;
}
^"###### ".+ {
    int length = strlen(yytext) - 7 + 10;
    yylval.sval = concat(length, "<h6>", chomp(erase_tag(yytext, 7, 0)), "</h6>");
    return H6;
}
^[-*+]" ".+ {
    int length = strlen(yytext) - 2 + 18;
    yylval.sval = concat(length, "<ul><li>", chomp(erase_tag(yytext, 2, 0)), "</li></ul>");
    return UL;
}
{strong}.+{strong} {
    int length = strlen(yytext) - 4 + 17;
    yylval.sval = concat(length, "<strong>", erase_tag(yytext, 2, 2), "</strong>");
    return STRONG;
}
{s}.+{s} {
    int length = strlen(yytext) - 4 + 7;
    yylval.sval = concat(length, "<s>", erase_tag(yytext, 2, 2), "</s>");
    return S;
}
{em}.+{em} {
    int length = strlen(yytext) - 2 + 9;
    yylval.sval = concat(length, "<em>", erase_tag(yytext, 1, 1), "</em>");
    return EM;
}
{ins}.+{ins} {
    int length = strlen(yytext) - 4 + 11;
    yylval.sval = concat(length, "<ins>", erase_tag(yytext, 2, 2), "</ins>");
    return INS;
}
{mark}.+{mark} {
    int length = strlen(yytext) - 4 + 13;
    yylval.sval = concat(length, "<mark>", erase_tag(yytext, 2, 2), "</mark>");
    return MARK;
}
%%