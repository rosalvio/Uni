(define (problem simple) (:domain transporte-multimodal)
(:objects 
A - ciudad
B - ciudad
C - ciudad
D - ciudad
E - ciudad
juan - persona
maria - persona
eva - persona
ana - persona
pedro - persona
bPedro - bicicleta
bJuan - bicicleta
)

(:init
    (at juan A)
    (at maria C)
    (at eva C)
    (at ana D)
    (at pedro E)

    (residente juan)
    (residente maria)
    (residente ana)

    (=(velocidad-metro) 2)
    (=(velocidad-tren) 4)
    (=(velocidad-bus) 1)

    (=(precio-bonometro) 12)
    (=(precio-tren) 6)

    (=(viajes-bono juan) 0)
    (=(viajes-bono maria) 0)
    (=(viajes-bono eva) 0)
    (=(viajes-bono ana) 0)
    (=(viajes-bono pedro) 0)

    (=(dinero-persona juan) 50)
    (=(dinero-persona maria) 15)
    (=(dinero-persona eva) 13)
    (=(dinero-persona ana) 18)
    (=(dinero-persona pedro) 14)

    (=(coste-total) 0)


    (conexion-bus A B)
    (conexion-metro A B)
    (conexion-tren A B)
    (=(distancia-ciudades A B) 40)

    (conexion-bus A C)
    (conexion-metro A C)
    (conexion-tren A C)
    (=(distancia-ciudades A C) 80)

    (conexion-metro A D)
    (conexion-tren A D)
    (=(distancia-ciudades A D) 120)

    (conexion-tren A E)
    (=(distancia-ciudades A E) 200)


    (conexion-bus B A)
    (conexion-metro B A)
    (conexion-tren B A)
    (=(distancia-ciudades B A) 40)

    (conexion-bus B C)
    (conexion-metro B C)
    (conexion-tren B C)
    (=(distancia-ciudades B C) 40)

    (conexion-bus B D)
    (conexion-metro B D)
    (=(distancia-ciudades B D) 80)

    (conexion-tren B E)
    (=(distancia-ciudades B E) 80)


    (conexion-bus C A)
    (conexion-metro C A)
    (conexion-tren C A)
    (=(distancia-ciudades C A) 80)

    (conexion-bus C B)
    (conexion-metro C B)
    (conexion-tren C B)
    (=(distancia-ciudades C B) 40)

    (conexion-bus C D)
    (=(distancia-ciudades C D) 80)

    (=(distancia-ciudades C E) 200)

    (conexion-bus D A)
    (conexion-metro D A)
    (=(distancia-ciudades D A) 120)

    (conexion-bus D B)
    (conexion-metro D B)
    (=(distancia-ciudades D B) 80)

    (conexion-bus D C)
    (=(distancia-ciudades D C) 40)

    (=(distancia-ciudades D E) 120)

    (conexion-tren E A)
    (=(distancia-ciudades E A) 200)

    (conexion-tren E B)
    (=(distancia-ciudades E B) 120)

    (=(distancia-ciudades E C) 240)

    (=(distancia-ciudades E D) 160)


    (at bPedro E)
    (at bJuan A)
    (bici pedro)
    (bici juan)


    

)

(:goal (and
    (at juan E)
    (at maria E)
    (at eva D)
    (at ana A)
    (at pedro B)
))

;un-comment the following line if metric is needed
(:metric minimize (total-time))
)
