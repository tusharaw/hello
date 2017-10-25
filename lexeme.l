%{
#include <stdio.h>
#include <string.h>
int lno=1;
FILE* opfile;
char name[20][20];
int cnt=0;

int elno[20];
char edesc[20][100];
int ecnt=0;
%}

%%

[0-9]+   {printf("%d   %sNUMBER\n",lno,yytext);}
[-+*/]   {printf("%d   %sOPERATOR\n",lno,yytext);}
=        {printf("%d   %sASSIGNMENT\n",lno,yytext); }
include|main|return   {printf("%d   %sKEYWORD\n",lno,yytext); }
int|float|char|double   {printf("%d   %sDATATYPE\n",lno,yytext);}

[\t ]      ;
\n      {lno++;}
(\/\/.*)       ;
(\/\*[^*/]*\*\/) ;
(\/\*[^*/]*)     {elno[ecnt]=lno;  char str[100]="Unterminated comment  ";ecnt++;}
#       {printf("%d   %s PREPROCESSOR\n",lno,yytext);}
;       {printf("%d   %s TERMINATOR\n",lno,yytext); }
\<       {printf("%d   %s       LESS THAN\n",lno,yytext); }
\>       {printf("%d   %s              GREATER THAN\n",lno,yytext);}
\{       {printf("%d   %s              START OF BLOCK\n",lno,yytext);}
\}       {printf("%d   %s              END OF BLOCK\n",lno,yytext);}
\(       {printf("%d   %s              OPEN\n",lno,yytext);}
\)       {printf("%d   %s              CLOSE\n",lno,yytext);}
\[       {printf("%d   %s              OPEN\n",lno,yytext);}
\]       {printf("%d   %s              CLOSE\n",lno,yytext);}
,        {printf("%d   %s              SEPARATOR\n",lno,yytext);}
printf|scanf   {printf("%d   %s             LIBRARY FUNCTION\n",lno,yytext);}
(\"[^\"]*\")   {printf("%d   %s              STRING CONSTANT\n",lno,yytext);}
(\"[^\"\n]*\n)     {elno[ecnt]=lno;   char str[100]="Unterminated quotes ";lno++;}
([a-zA-Z0-9]+\.h) {printf("%d   %s                HEADER FILE\n",lno,yytext);}
[a-zA-Z][a-zA-Z0-9]* {printf("%d   %s                  IDENTIFIER\n",lno,yytext);fprintf(opfile,"%s ",yytext);}

%%
void st_add(char s[20])
{
int i;
 for(i=0;i<cnt;i++)
  {if(strcmp(name[i],s)==0) return;}
 strcpy(name[cnt],s);
 cnt++;
}

main()
{
char ifile[100],ofile[100];
printf("\nEnter input file name:     ");
scanf("%s",ifile);
yyin=fopen(ifile,"r");

int i;
printf("Line No     LEXEME                       Token\n");
yylex();


printf("\nLexical Errors:  Found  %d\n",ecnt);
for(i=0;i<ecnt;i++)
{printf("\nLine no.  %2d  \t   %s",elno[i],edesc[i]);}
return 0;
}

int yywrap()
{
return 1;
}

/*


root@mayur-Lenovo-G50-70:/home/mayur# lex lexeme.l
root@mayur-Lenovo-G50-70:/home/mayur# ./a.out

Enter input file name:     input.txt

Enter output file name:     a3op1.txt
Line No     LEXEME                       Token
1   main              KEYWORD
1   (              OPEN
1   )              CLOSE
1   {              START OF BLOCK
2   int               DATATYPE
2   a                  IDENTIFIER
2   =                 ASSIGNMENT
2   10                 NUMBER
2   ,              SEPARATOR
2   b                  IDENTIFIER
2   ,              SEPARATOR
2   c                  IDENTIFIER
2   ;               TERMINATOR
3   float               DATATYPE
3   e                  IDENTIFIER
3   =                 ASSIGNMENT
3   10                 NUMBER
.3   90                 NUMBER
3   ,              SEPARATOR
3   f                  IDENTIFIER
3   ,              SEPARATOR
3   i                  IDENTIFIER
3   ;               TERMINATOR
4   a                  IDENTIFIER
4   =                 ASSIGNMENT
4   10                 NUMBER
4   ;               TERMINATOR
5   b                  IDENTIFIER
5   =                 ASSIGNMENT
5   a                  IDENTIFIER
5   ;               TERMINATOR
6   c                  IDENTIFIER
6   =                 ASSIGNMENT
6   a                  IDENTIFIER
6   +                 OPERATOR
6   10                 NUMBER
6   ;               TERMINATOR
7   c                  IDENTIFIER
7   =                 ASSIGNMENT
7   a                  IDENTIFIER
7   +                 OPERATOR
7   b                  IDENTIFIER
7   *                 OPERATOR
7   a                  IDENTIFIER
7   ;               TERMINATOR
8   c                  IDENTIFIER
8   =                 ASSIGNMENT
8   c                  IDENTIFIER
8   +                 OPERATOR
8   a                  IDENTIFIER
8   -                 OPERATOR
8   b                  IDENTIFIER
8   +                 OPERATOR
8   a                  IDENTIFIER
8   ;               TERMINATOR
9   }              END OF BLOCK

Lexical Errors:  Found  0

----------------------------------------------------
input.txt

main{
int a=10,b,c;
float e=10.90,f,i;
a=10;
b=a;
c=a+10;
c=a+b*a;
c=c+a-b+a;
}



a3op1.txt

main ( ) { 
int a = 10 , b , c ; 
float e = 10 90 , f , i ; 
a = 10 ; 
b = a ; 
c = a + 10 ; 
c = a + b * a ; 
c = c + a - b + a ; 
} 

*/
