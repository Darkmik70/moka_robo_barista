(define (problem moka_maker) (:domain moka_robo_barista)
(:objects 
    robert
    bialetti
    honduras
    counter
)

(:init
    (ROBOT robert)
    (POT bialetti)
    (BEANS honduras)
    (LOCATION counter) ;(LOCATION stove)

    (free robert)
    (is-screwed bialetti)
    (has-filter bialetti)
    
    (at counter bialetti)

    (is-grinded honduras) ; coffee is already grinded

    ; (is-stove stove)
)

(:goal (and (beverage-is-served bialetti))
)
)