(deffunction fuzzify (?fztemplate ?value ?delta)
 (bind ?low (get-u-from ?fztemplate))
 (bind ?hi (get-u-to ?fztemplate))
 (if (<= ?value ?low)
 then
 (assert-string
 (format nil "(%s (%g 1.0) (%g 0.0))" ?fztemplate ?low ?delta))
 else
 (if (>= ?value ?hi)
 then
 (assert-string
 (format nil "(%s (%g 0.0) (%g 1.0))"
 ?fztemplate (- ?hi ?delta) ?hi))
 else
 (assert-string
 (format nil "(%s (%g 0.0) (%g 1.0) (%g 0.0))"
 ?fztemplate (max ?low (- ?value ?delta))
 ?value (min ?hi (+ ?value ?delta)) ))
 ))) 


(deftemplate categoria
0 150 puntos
((economica (40 1) (70 0))
(estandar (40 0) (70 1) (100 0))
(intermedia (70 0) (100 1) (130 0))
(alta (100 0) (130 1))))

(deftemplate edad
0 100 anyos
((reciente (0 1) (12 0))
(nuevo (0 0) (12 1) (24 0))
(medio (24 0) (36 1) (48 0))
(viejo (48 0) (60 1))))

(deftemplate vue-dif
0 10000 puntos
((bajisimo (500 1) (1500 0))
(bajo (500 0) (1500 1) (2500 0))
(medio (2500 0) (3500 1) (4500 0))
(alto (4500 0) (5500 1) (6500 0))
(altisimo (5500 0) (6500 1))))

(
	deftemplate vivienda
	(slot categoria (type INTEGER))
	(slot edad (type INTEGER))
	(slot ventanas (type INTEGER))
	(slot vue-max (type INTEGER))
	(slot vue-mom (type INTEGER))
)


(defrule altisimo
	(categoria alta)
	(edad reciente)
	=>
	(assert(vue-dif altisimo)))

(defrule alto
	(categoria alta)
	(edad not [ medio or viejo ])
	(categoria ?c)
	=>
	(assert(vue-dif alto)))

(defrule medio1
	(categoria alta)
	(edad not [ reciente or nuevo ])
	=>
	(assert(vue-dif medio)))

(defrule nimedio-nialto
	(categoria intermedia)
	(edad nuevo)
	=>
	(assert(vue-dif not [ medio or alto ]))
)

(defrule bajo
	(categoria intermedia)
	(edad not [ medio or viejo ])
	=>
	(assert(vue-dif bajo)))

(defrule medio2
	(categoria estandar)
	(edad nuevo)
	=>
	(assert(vue-dif medio)))

(defrule bajisimo1
	(categoria estandar)
	(edad viejo)
	=>
	(assert(vue-dif bajisimo)))

(defrule nibajo-nimedio
	(categoria economica)
	(edad nuevo)
	=>
	(assert(vue-dif not [ bajo or medio ])))



(
	defrule vues
		(declare (salience -2))
		(vue-dif ?vue)
		=>
		(assert (vue-max (maximum-defuzzify ?vue)))
		(assert (vue-mom (moment-defuzzify ?vue)))
)

(defrule ventanas
(declare (salience 2))
	(ventanas ?vent)
	=>
	(if (< ?vent 3)
	then
	(assert (vue-dif more-or-less bajo)))
	(if (> ?vent 5)
	then
	(assert (vue-dif very alto)))
)


(deffunction inicio()
	(reset)
	(printout t"Introduzca la categoria de la vivienda " crlf)
	(bind ?Ccategoria (read))
	(fuzzify categoria ?Ccategoria 0.1)
	(printout t"Introduzca la edad de la vivienda " crlf)
	(bind ?Cedad (read))
	(fuzzify edad ?Cedad 0.1)
	(printout t"Introduzca el numero de ventanas en la vivienda " crlf)
	(bind ?Cventanas (read))
	(assert (vivienda (categoria ?Ccategoria) (edad ?Cedad) (ventanas ?Cventanas) ))
	(run)
)


(defrule defuzzificar
	(declare (salience -3))
	(vue-dif ?vue)
	(vue-max ?vueMax)
	(vue-mom ?vueMom)
	=>
	
	(printout t"VUE de la vivienda por moment: " ?vueMom crlf)
	(printout t"VUE de la vivienda por maximum: " ?vueMax crlf))