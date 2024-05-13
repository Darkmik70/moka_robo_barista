(define (problem moka_maker) (:domain moka_robo_barista)
(:objects 
    robert
    bialetti
    honduras
)

(:init
    (ROBOT robert)
    (POT bialetti)
    (CAFE honduras)

    (free robert)
    (is-screwed bialetti)
    (has-filter bialetti)
)

(:goal (and (coffee-is-served bialetti))
)
)