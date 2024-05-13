(define (domain moka_robo_barista)

(:requirements :strips )

(:predicates
    ; predicates that define types
    (ROBOT ?r)
    (POT ?p)
    (CAFE ?c)

    (free ?r)   ;if robot is free

    (at-robot ?p)  ; pot is in robot's hands
    (is-screwed ?p) ;pot is screwed
    (has-filter ?p) ;filter is inside filter
    (has-water ?p)  ;water is in pot
    (has-coffee ?p) ;coffee is inside pot
    (coffee-is-ready ?p)    ;coffe is ready to serve
    (coffee-is-served ?p)   ;coffee is poured into cups

)

(:action robot-take-pot
    ; Take pot from the table
    :parameters (?r ?p)
    :precondition (and  (ROBOT ?r) (free ?r) (POT ?p) (not (at-robot ?p)) )
    :effect (and (not (free ?r)) (at-robot ?p))
)

(:action robot-put-pot-down
    ; put the pot down to the table
    :parameters (?r ?p)
    :precondition (and  (ROBOT ?r) (not (free ?r)) (POT ?p) (at-robot ?p) )
    :effect (and (free ?r) (not (at-robot ?p)))
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
    :parameters (?r ?c)
    :precondition (and  (ROBOT ?r) (free ?r) (CAFE ?c) (not (at-robot ?c)) )
    :effect (and (not (free ?r)) (at-robot ?c))
)

(:action robot-put-coffee-down
    ; robot puts closes coffee and puts it down
    :parameters (?r ?c)
    :precondition (and  (ROBOT ?r) (not (free ?r)) (CAFE ?c) (at-robot ?c) )
    :effect (and (free ?r) (not (at-robot ?c)))
)

(:action pour-coffee-to-the-pot
    ; pour coffee to the pot (with filter
    :parameters (?r ?c ?p)
    :precondition (and (ROBOT ?r) (not (free ?r)) (CAFE ?c) (at-robot ?c)
        (POT ?p) (not (at-robot ?p)) (not (is-screwed ?p)) (has-filter ?p) (not (has-coffee ?p))
    )
    :effect (and (has-coffee ?p))
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
    :effect (and (coffee-is-served ?p))
)



)