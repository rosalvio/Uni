(deffunction fuzzify (?fztemplate ?value ?delta)

        (bind ?low (get-u-from ?fztemplate))
        (bind ?hi  (get-u-to   ?fztemplate))

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
                               ?value (min ?hi (+ ?value ?delta)) )))))

(deftemplate categoria
0 150 puntos
((economica (40 1) (70 0))
(estandar (40 0) (70 1) (100 0))
(intermedia (70 0) (100 1) (130 0))
(alta (100 0) (130 1))))

(deftemplate edad-aparente
0 100 puntos
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

(defrule altisimo
	(categoria alta)
	(edad reciente)
	=>
	(assert(vue-dif altisimo)))

(defrule alto
	(categoria alta)
	(edad not medio)
	(edad not viejo)
	=>
	(assert(vue-dif alto)))

(defrule medio1
	(categoria alta)
	(edad not reciente)
	(edad not nuevo)
	=>
	(assert(vue-dif medio)))

(defrule nimedio-nialto
	(categoria intermedia)
	(edad nuevo)
	=>
	(assert(vue-dif not alto))
	(assert(vue-dif not medio))
)

(defrule bajo
	(categoria intermedia)
	(edad not medio)
	(edad not viejo)
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
	(assert(vue-dif not bajo))
	(assert(vue-dif not medio)))

(defrule bajisimo2
	(categoria economica)
	(edad not reciente)
	(edad not nuevo)
	=>
	(assert(vue-dif bajisimo)))

(deffunction inicio()
	(reset)
	(printout t"Introduzca la categoria de la vivienda " crlf))
	(bind ?categoria (read))
	(fuzzify categoria ?categoria 0.1)
	(printout t"Introduzca la edad de la vivienda " crlf))
	(bind ?edad (read))
	(fuzzify edad ?edad 0.1)
)


(defrule defuzzificar
	(vue-dif ?vue)
	=>
	(printout t"VUE de la vivienda por moment: " (moment-defuzzify ?vue)crlf)
	(printout t"VUE de la vivienda por maximum: " (maximum-defuzzify ?vue)crlf))