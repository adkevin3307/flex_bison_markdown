bison -d parser.y
flex scanner.l
gcc parser.tab.c lex.yy.c -lfl -o token.out

