#include <stdio.h>
#include <string.h>
#include "header.h"

int verbosidad = FALSE;                  
int numErrores = 0;                 

void yyerror(const char * msg)
                                               */
{
  numErrores++;  fflush(stdout);
  fprintf(stdout, "\nError en %d: %s\n", yylineno, msg);
}
/*****************************************************************************/
int main (int argc, char **argv) 
/* Gestiona la linea de comandos e invoca al analizador sintactico-semantico.*/
{ int i, n = 1;

    for (i=1; i<argc; ++i)
        if (strcmp(argv[i], "-v")==0) { verbosidad = TRUE; n++; }
    if (argc == n+1)
        if ((yyin = fopen (argv[n], "r")) == NULL)
            fprintf (stderr, "El fichero '%s' no es valido\n", argv[n]) ;
        else yyparse ();
    else fprintf (stderr, "Uso: cmc [-v] fichero\n");
    return (0);
} 
/*****************************************************************************/
