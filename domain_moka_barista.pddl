(define (domain moka_robo_barista)

(:requirements :strips )

(:predicates
    ; predicates that define types
    (ROBOT ?r)
    (POT ?p)
    (BEANS ?b)
    (LOCATION ?l)   ; place where types are put

    
    (free ?r)   ;if robot is free

    (at-robot ?p)  ; pot is in robot's hands
    (is-screwed ?p) ;pot is screwed
    (has-filter ?p) ;filter is inside filter
    (has-water ?p)  ;water is in pot
    (has-coffee ?p) ;coffee is inside pot
    (coffee-is-ready ?p)    ;coffe is ready to serve
    (beverage-is-served ?p)   ;coffee is poured into cups

    (is-grinded ?b) ;coffee is in form of dust
    (at-grinder ?b) ;coffee is in grinder

    (at ?l ?o) ;?where ?what object is at location
    ; (is-stove ?l) ;location which is identified as stove

)

(:action robot-take-pot
    ; Take pot from the location
    :parameters (?r ?p ?l)
    :precondition (and  (ROBOT ?r) (free ?r) (POT ?p) (not (at-robot ?p)) (LOCATION ?l) (at ?l ?p))
    :effect (and (not (free ?r)) (at-robot ?p) (not (at ?l ?p)))
)

(:action robot-put-pot-down
    ; put the pot down to the location
    :parameters (?r ?p ?l)
    :precondition (and  (ROBOT ?r) (not (free ?r)) (POT ?p) (at-robot ?p) (LOCATION ?l) (not (at ?l ?p)))
    :effect (and (free ?r) (not (at-robot ?p)) (at ?l ?p))
)

(:action unscrew-pot
    ; open the pot
    :parameters (?r ?p)
    :precondition (and  (ROBOT ?r) (not (free ?r)) (POT ?p) (at-robot ?p) (is-screwed ?p))
    :effect (and (not (is-screwed ?p)))
)

(:action screw-pot
    ; set the pot back again
    :parameters (?r ?p)
    :precondition (and  (ROBOT ?r) (not (free ?r)) (POT ?p) (at-robot ?p) (not (is-screwed ?p)))
    :effect (and (is-screwed ?p))
)

(:action remove-filter
    ; take the filter out and put in on the table
    :parameters (?r ?p)
    :precondition (and  (ROBOT ?r) (not (free ?r)) (POT ?p) (at-robot ?p) (not (is-screwed ?p)) (has-filter ?p))
    :effect (and (not (has-filter ?p)))
)

(:action pour-water
    ; pour water to the pot, but cmon, not through filter
    :parameters (?r ?p)
    :precondition (and (ROBOT ?r) (not (free ?r)) 
                    (POT ?p) (at-robot ?p) (not (is-screwed ?p)) (not (has-filter ?p)))
    :effect (and (has-water ?p))
)

(:action put-filter-back
    ; put filter back to the pot
    :parameters (?r ?p)
    :precondition (and (ROBOT ?r) (not (free ?r))
                    (POT ?p) (at-robot ?p) (not (is-screwed ?p)) (not (has-filter ?p)))
    :effect (and (has-filter ?p))
)

(:action robot-take-coffee
    ; robot takes coffee from the table, and opens it up
    :parameters (?r ?b)
    :precondition (and  (ROBOT ?r) (free ?r) (BEANS ?b) (not (at-robot ?b)) )
    :effect (and (not (free ?r)) (at-robot ?b))
)

(:action robot-put-coffee-down
    ; robot puts closes coffee and puts it down
    :parameters (?r ?b)
    :precondition (and  (ROBOT ?r) (not (free ?r)) (BEANS ?b) (at-robot ?b) )
    :effect (and (free ?r) (not (at-robot ?b)))
)

(:action put-beans-in-grinder
    :parameters (?r ?b)
    :precondition (and  (ROBOT ?r) (not (free ?r)) (BEANS ?b) (at-robot ?b))
    :effect (and (free ?r) (at-grinder ?b) (not (at-robot ?b)))
)

(:action grind-coffee
    :parameters (?r ?b)
    :precondition (and  (ROBOT ?r) (free ?r) (BEANS ?b) (at-grinder ?b))
    :effect (and (is-grinded ?b) (not (free ?r)) (not (at-grinder ?b)) (at-robot ?b))
)

(:action take-coffee-from-grinder
    :parameters (?r ?b)
    :precondition (and  (ROBOT ?r) (not (free ?r)) (BEANS ?b) (not (at-robot ?b)) (at-grinder ?b))
    :effect (and (free ?r) (not (at-grinder ?b)) (at-robot ?b))
)

(:action pour-coffee-to-the-pot
    ; pour coffee to the pot (with filter
    :parameters (?r ?b ?p)
    :precondition (and (ROBOT ?r) (not (free ?r)) (BEANS ?b) (at-robot ?b) 
        (POT ?p) (not (at-robot ?p)) (not (is-screwed ?p)) (has-filter ?p) (not (has-coffee ?p)) (is-grinded ?b))
    :effect (and (has-coffee ?p) (not (at-robot ?b)) (free ?r))
)

(:action moka-make
    ; put pot on the stove, fire it up, wait for coffee to be ready, and take it again
    :parameters (?r ?p)
    :precondition (and (ROBOT ?r) (not (free ?r))
                       (POT ?p) (at-robot ?p) (is-screwed ?p) (has-water ?p) (has-coffee ?p))
    :effect (and (coffee-is-ready ?p))
)

(:action serve-coffee
    ; pour coffee to the cups
    :parameters (?r ?p)
    :precondition (and (ROBOT ?r) (not (free ?r)) (POT ?p) (at-robot ?p) (coffee-is-ready ?p)
    )
    :effect (and (beverage-is-served ?p))
)

)