%{
#include <stdio.h>
#include <string.h>
#include "header.h"

%}

%union{
       char* ident;
       int cent;
}

%token TRUE_ FALSE_ INT_ BOOL_ READ_ PRINT_ FOR_ IF_ ELSE_ RETURN_
%token OPMAS_ OPIGU_ OPMASIGU_ OPMENOSIGU_ OPPORIGU_ OPDIVIGU_
%token OPAND_ OPOR_ OPIGUALDAD_ OPDESIGUAL_ OPMENOS_ OPPOR_ OPMODULO_ OPDIV_
%token PARA_ PARC_ OPMAYOR_ OPMAYORIGU_ OPMENOR_ OPMENORIGU_ OPNEGAR_
%token OPINCREMENTO_ OPDECREMENTO_ COMA_ PUNTOCOMA_ LLAVEA_ LLAVEC_ CORCHC_ CORCHA_
%token<ident> ID_
%token<cent> CTE_

%%

programa: listaDeclaraciones
       ;
listaDeclaraciones: declaracion
       | listaDeclaraciones declaracion
       ;
declaracion:      declaracionVariable
       | declaracionFuncion
       ;
declaracionVariable:      tipoSimple ID_ PUNTOCOMA_
       | tipoSimple ID_ CORCHA_ CTE_ CORCHC_ PUNTOCOMA_
       ;
tipoSimple:      INT_
       | BOOL_
       ;
declaracionFuncion:      cabeceraFuncion bloque
       ;
cabeceraFuncion:      tipoSimple ID_ PARA_ parametrosFormales PARC_
       ;
parametrosFormales:      
       | listaParametrosFormales
       ;
listaParametrosFormales:      tipoSimple ID_
       | tipoSimple ID_ COMA_ listaParametrosFormales
       ;
bloque: LLAVEA_ declaracionVariableLocal listaInstrucciones RETURN_ expresion PUNTOCOMA_ LLAVEC_
       ;
declaracionVariableLocal:
       | declaracionVariableLocal declaracionVariable
       ;
listaInstrucciones:
       | listaInstrucciones instruccion
       ;
instruccion: LLAVEA_ listaInstrucciones LLAVEC_
       | instruccionAsignacion
       | instruccionSeleccion
       | instruccionEntradaSalida
       | instruccionIteracion
       ;
instruccionAsignacion: ID_ OPIGU_ expresion PUNTOCOMA_
       | ID_ CORCHA_ expresion CORCHC_ OPIGU_ expresion PUNTOCOMA_
       ;
instruccionEntradaSalida: READ_ PARA_ ID_ PARC_ PUNTOCOMA_
       | PRINT_ PARA_ expresion PARC_ PUNTOCOMA_
       ;
instruccionSeleccion: IF_ PARA_ expresion PARC_ instruccion ELSE_ instruccion
       ;
instruccionIteracion: FOR_ PARA_ expresionOpcional PUNTOCOMA_ expresion PUNTOCOMA_ expresionOpcional PARC_ instruccion
       ;
expresionOpcional:
       | expresion
       | ID_ OPIGU_ expresion
       ;
expresion: expresionIgualdad
       | expresion operadorLogico expresionIgualdad
       ;
expresionIgualdad: expresionRelacional
       | expresionIgualdad operadorIgualdad expresionRelacional
       ;
expresionRelacional: expresionAditiva
       | expresionRelacional operadorRelacional expresionAditiva
       ;
expresionAditiva: expresionMultiplicativa
       | expresionAditiva operadorAditivo expresionMultiplicativa
       ;
expresionMultiplicativa: expresionUnaria
       | expresionMultiplicativa operadorMultiplicativo expresionUnaria
       ;
expresionUnaria: expresionSufija
       | operadorUnario expresionUnaria
       | operadorIncremento ID_
       ;
expresionSufija: PARA_ expresion PARC_
       | ID_ operadorIncremento
       | ID_ CORCHA_ expresion CORCHC_
       | ID_ PARA_ parametrosActuales PARC_
       | ID_
       | constante
       ;
parametrosActuales:
       | listaParametrosActuales
       ;
listaParametrosActuales: expresion
       | expresion COMA_ listaParametrosActuales
       ;
constante: CTE_
       | TRUE_
       | FALSE_
       ;
operadorLogico: OPAND_
       | OPOR_
       ;
operadorIgualdad: OPIGUALDAD_
       | OPDESIGUAL_
       ;
operadorRelacional: OPMAYOR_
       | OPMENOR_
       | OPMAYORIGU_
       | OPMENORIGU_
       ;
operadorAditivo: OPMAS_
       | OPMENOS_
       ;
operadorMultiplicativo: OPPOR_
       | OPDIV_
       ;
operadorUnario: OPMAS_
       | OPMENOS_
       | OPNEGAR_
       ;
operadorIncremento: OPINCREMENTO_
       | OPDECREMENTO_
       ;
%%