%{
#include <stdio.h>
#include <string.h>
#include "header.h"
#include "asin.h"

#define  retornar(x) {if (verbosidad) ECHO; return x;}
%}

%option yylineno  

delimitador    [ \t\n]+
digito         [0-9]
entero         {digito}+
letra          [a-zA-Z]
constante      {entero}|("."){entero}|{entero}(".")|{entero}("."){entero}
identificador {letra}({letra}|{digito}|_)*
comentario     \/\/.* 

%%
{comentario}    { if (verbosidad) ECHO; }
{delimitador}   { if (verbosidad) ECHO; }
"true"          { retornar(TRUE_); }
"false"         { retornar(FALSE_); }
"int"           { retornar(INT_); }
"bool"          { retornar(BOOL_); }
"read"          { retornar(READ_); }
"print"         { retornar(PRINT_); }
"for"           { retornar(FOR_); }
"if"            { retornar(IF_); }
"else"          { retornar(ELSE_); }
"return"        { retornar(RETURN_); }


"+"             { retornar(OPMAS_); }
"="             { retornar(OPIGU_);  }
"+="            { retornar(OPMASIGU_); }
"-="            { retornar(OPMENOSIGU_); }
"*="            { retornar(OPPORIGU_); }
"/="            { retornar(OPDIVIGU_); }

"&&"            { retornar(OPAND_); }
"||"            { retornar(OPOR_); }
"=="            { retornar(OPIGUALDAD_); }
"!="            { retornar(OPDESIGUAL_); }
"-"             { retornar(OPMENOS_); }
"*"             { retornar(OPPOR_); }
"%"             { retornar(OPMODULO_); }
"/"             { retornar(OPDIV_); }
"("             { retornar(PARA_); }
")"             { retornar(PARC_); }
">"             { retornar(OPMAYOR_); }
">="            { retornar(OPMAYORIGU_); }
"<"             { retornar(OPMENOR_); }
"<="            { retornar(OPMENORIGU_);  }
"!"             { retornar(OPNEGAR_);  }
"++"            { retornar(OPINCREMENTO_);  }
"--"            { retornar(OPDECREMENTO_);  }
","             { retornar(COMA_);  }
";"             { retornar(PUNTOCOMA_); }
"{"             { retornar(LLAVEA_); }
"}"             { retornar(LLAVEC_); }
"]"             { retornar(CORCHC_); }
"["             { retornar(CORCHA_); }
{identificador} { yylval.ident = strdup(yytext); retornar(ID_); }
{constante}     { yylval.cent = atoi(yytext); retornar(CTE_); }
.               {yyerror("Caracter desconocido");}
%%
/*****************************************************************************/
