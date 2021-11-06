(define (domain delivery-domain)
    (:predicates 
        (state ?s)              ;;object
        (package ?p)
        (gripper ?g)
        (robot ?r)
        (car ?c)
        (keys ?k)
        
        (at-robby ?s)           ;;states = where things are
        (at-package ?s)  
        (at-car ?s)
        (at-keys ?s)
        
        (free-gripper ?g)       ;;free gripper/car
        (free-car ?c)
        
        (carry-keys ?k ?g)      ;;carry keys with gripper
        (carry-package ?p ?c)   ;;carry package with car
        (in-car ?r ?c)          ;;rob in car
        
        (neighbour ?s1 ?s2)     ;;neighbour
    )
    
    (:action walk
        :parameters (?from ?to)                 ;;walking requires just rob
        :precondition (and 
                    (state ?from)
                    (state ?to)
                    (at-robby ?from)
                    (neighbour ?from ?to)
        )
        :effect (and (at-robby ?to) (not (at-robby ?from))
        )
    )
    
    (:action pick-keys-with-gripper             ;;pick up keys with gripper
        :parameters (?k ?s ?g)
        :precondition (and 
                        (keys ?k)
                        (state ?s)
                        (gripper ?g)
                        (free-gripper ?g)
                        (at-robby ?s)
                        (at-keys ?s)
        )
        :effect (and (carry-keys ?k ?g) (not (at-keys ?s)) (not(free-gripper ?g)))
    )
    (:action drop-keys-with-gripper             ;;or drop the keys
        :parameters (?k ?s ?g)
        :precondition (and 
                        (keys ?k)
                        (state ?s)
                        (gripper ?g)
                        (carry-keys ?k ?g)
                        (at-robby ?s)
                        (not(free-gripper ?g))
        )
        :effect (and (not(carry-keys ?k ?g)) (free-gripper ?g) (at-keys ?s))
    )
    
    (:action walk-with-keys
        :parameters (?from ?to ?k ?g)                 ;;walking requires just rob
        :precondition (and 
                    (keys ?k)
                    (gripper ?g)
                    (state ?from)
                    (state ?to)
                    (carry-keys ?k ?g)
                    (at-robby ?from)
                    (neighbour ?from ?to)
        )
        :effect (and (at-robby ?to) (not (at-robby ?from))
        )
    )
    
    (:action get-in-car                         ;;with the keys, the rob can get in the car
        :parameters (?k ?s ?c ?r ?g)
        :precondition (and 
                    (keys ?k)
                    (state ?s)
                    (car ?c)
                    (robot ?r)
                    (gripper ?g)
                    (not(free-gripper ?g))
                    (carry-keys ?k ?g)
                    (at-robby ?s)          
                    (at-car ?s)
                    )
        :effect (and (in-car ?r ?c) (not (at-robby ?s)))
    )
    
     (:action get-out-car                   ;;or the rob can get out of the car
        :parameters (?k ?s ?c ?r ?g)
        :precondition (and 
                    (keys ?k)
                    (state ?s)
                    (robot ?r)
                    (car ?c)
                    (gripper ?g)
                    (in-car ?r ?c)
                    (at-car ?s)
                    )
        :effect (and (at-robby ?s) (not (in-car ?r ?c)) (carry-keys ?k ?g) (not(free-gripper ?g)))
    )
    
    (:action drive                          ;;when inside the car (with the keys), the rob can drive to neighbouring states
        :parameters (?from ?to ?r ?c)
        :precondition (and 
                    (robot ?r)
                    (car ?c)
                    (state ?from)
                    (state ?to)
                
                    (in-car ?r ?c)
                    
                    (at-car ?from)
                    (neighbour ?from ?to)
        )
        
        :effect (and (at-car ?to) (not (at-car ?from)))
    )
    
    (:action pick-package-with-car                  ;;the rob can put the package into the car
        :parameters (?p ?s ?c ?k ?g ?r)
        :precondition (and 
                        (package ?p)
                        (state ?s)
                        (car ?c)
                        (robot ?r)
                        (free-car ?c)
                        (at-robby ?s)
                        (at-package ?s)
                        (at-car ?s)
                        (carry-keys ?k ?g)
                        (not (in-car ?r ?c))
        )
        :effect (and (carry-package ?p ?c) (not (at-package ?s)) (not (free-car ?c)))
    )
    (:action drop-package-with-car                  ;;and the rob can take the package out of the car
        :parameters (?p ?s ?c ?k ?g ?r)
        :precondition (and 
                        (package ?p)
                        (state ?s)
                        (car ?c)
                        (robot ?r)
                        (carry-package ?p ?c)
                        (at-robby ?s)
                        (at-car ?s)
                        (carry-keys ?k ?g)
                        (not (in-car ?r ?c))
        )
        :effect (and (at-package ?s) (free-car ?c) (not(carry-package ?p ?c)))
    )
    
    (:action drive-package                          ;;the rob can drive the package in the car
        :parameters (?from ?to ?r ?p ?c)
        :precondition (and 
                    (robot ?r)
                    (car ?c)
                    (package ?p)
                    
                    (state ?from)
                    (state ?to)
                    (neighbour ?from ?to)
                
                    (in-car ?r ?c)
                    (at-car ?from)
                    (carry-package ?p ?c)
                    
        )
        :effect (and (at-car ?to)
                    (not (at-car ?from))
        )
    )
)
