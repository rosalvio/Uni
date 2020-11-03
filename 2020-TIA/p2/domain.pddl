;Header and description

(define (domain transporte-multimodal)

;remove requirements that are not needed
(:requirements :fluents :durative-actions :typing)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    persona
    ciudad
    - object
)


(:predicates ;todo: define predicates here
    (at ?p - persona ?c - ciudad)
    (residente ?p - persona)
    (tiene-ticket ?p - persona)
    (conexion-bus ?c1 - ciudad ?c2 - ciudad)
    (conexion-metro ?c1 - ciudad ?c2 - ciudad)
    (conexion-tren ?c1 - ciudad ?c2 - ciudad)

)


(:functions ;todo: define numeric functions here
    (distancia-ciudades ?c1 - ciudad ?c2 - ciudad)
    (velocidad-metro)
    (velocidad-tren)
    (velocidad-bus)
    (precio-bonometro)
    (precio-tren)
    (viajes-bono ?p - persona)
    (dinero-persona ?p - persona)
    (coste-total)
)

;define actions here
(:durative-action viajar-bus
    :parameters (?p - persona ?c1 - ciudad ?c2 - ciudad)
    :duration (= ?duration (/ (distancia-ciudades ?c1 ?c2) (velocidad-bus)))
    :condition (and 
        (at start (residente ?p))
        (at start (at ?p ?c1))
        (over all (conexion-bus ?c1 ?c2)) 
    )
    :effect (and 
        (at end (at ?p ?c2))
        (at start (not (at ?p ?c1)))
    )
)

(:durative-action viajar-metro
    :parameters (?p - persona ?c1 - ciudad ?c2 - ciudad)
    :duration (= ?duration (/ (distancia-ciudades ?c1 ?c2) (velocidad-metro)))
    :condition (and 
        (at start (at ?p ?c1))
        (over all (conexion-metro ?c1 ?c2)) 
        (at start (>= (viajes-bono ?p) 1))
    )
    :effect (and 
        (at end (at ?p ?c2))
        (at start (not (at ?p ?c1)))
        (at end (decrease(viajes-bono ?p) 1))
    )
)


(:durative-action viajar-tren
    :parameters (?p - persona ?c1 - ciudad ?c2 - ciudad)
    :duration (= ?duration (/ (distancia-ciudades ?c1 ?c2) (velocidad-tren)))
    :condition (and 
        (at start (at ?p ?c1))
        (over all (conexion-tren ?c1 ?c2)) 
        (at start (tiene-ticket ?p))
        
    )
    :effect (and 
        (at end (at ?p ?c2))
        (at start (not (at ?p ?c1)))
        (at end (not (tiene-ticket ?p)))
        
    )
)

(:durative-action recargar-bono
    :parameters (?p - persona)
    :duration (= ?duration 1) ;
    :condition (and 
        (at start (>=(dinero-persona ?p) (precio-bonometro)))
        (at start (<(viajes-bono ?p) 1)) 
    )
    :effect (and 
        (at end (decrease (dinero-persona ?p) (precio-bonometro)))
        (at end (increase (viajes-bono ?p) 10))
        (at start (increase (coste-total) (precio-bonometro)))
    )
)


(:durative-action comprar-ticket-tren
    :parameters (?p - persona)
    :duration (= ?duration 2) ;
    :condition (and 
        (at start (>=(dinero-persona ?p) (precio-tren)))
    )
    :effect (and 
        (at end (decrease(dinero-persona ?p) (precio-tren)))
        (at end (increase (coste-total) (precio-tren)))
        (at end (tiene-ticket ?p))
        
    )
)


)