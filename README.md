# Markdown Parser

## Environment
* Ubuntu 16.04
* flex 2.6.4
* bison 3.0.4
* gcc 7.4.0

## How to Use
1. `bash run.sh`
2. `./token.out < {filename}.md`

## File Explain
* `scanner.l` scan markdown with regular expression
* `parser.y` construct CFG
* `run.sh` command need to run
* `test.md` markdown test file
* `test.html` default output file

## Parser Can Do
1. `# str -> <h1>str</h1>`
2. `## str -> <h2>str</h2>`
3. `### str -> <h3>str</h3>`
4. `#### str -> <h4>str</h4>`
5. `##### str -> <h5>str</h5>`
6. `###### str -> <h6>str</h6>`
7. `* str -> <ul><li>str</li></ul>`
8. `– str -> <ul><li>str</li></ul>`
9. `+ str -> <ul><li>str</li></ul>`
10. `**str** -> <strong>str</strong>`
11. `++str++ -> <ins>str</ins>`
12. `~~str~~ -> <s>str</s>`
13. `==str== -> <mark>str</mark>`
14. `*str* -> <em>str</em>`

## Context Free Grammar
```cpp
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
```
```
start -> epsilon | start content
content -> title | list | text | font
title -> H1 | H2 | H3 | H4 | H5 | H6
list -> UL
text -> TEXT
font -> STRONG | S | EM | INS | MARK
```