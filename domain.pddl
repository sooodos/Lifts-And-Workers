(define (domain lifts)
	(:requirements :strips)
	(:predicates
        (wAt ?x ?y)
        (wAfast ?x ?y)
        (wAslow ?y ?y)
        (fastOf ?x ?y)
        (slowOf ?x ?y)
        (wAgoal ?x ?y)
        (isNext ?x ?y) 
        (isNext10 ?x ?y)
        
	)
    (:action move_up_slow
		:parameters (?slowLift ?from ?to)
            
		:precondition (and  (slowOf ?slowLift ?from) 
                   			(isNext ?from ?to)
                      )
		:effect  (and (not(slowOf ?slowLift ?from))
                         (slowOf ?slowLift ?to)   
              	 )
	)

    (:action move_down_slow
		:parameters (?slowLift ?from ?to)
            
		:precondition (and  (slowOf ?slowLift ?from) 
                   			(isNext ?to ?from)
                      )
		:effect  (and (not(slowOf ?slowLift ?from))
                         (slowOf ?slowLift ?to)   
              	 )
	)
	
    (:action move_up_fast
		:parameters (?fastLift ?from ?to)
            
		:precondition (and  (fastOf ?fastLift ?from)
                   		    (isNext10 ?from ?to)
                      )
		:effect   (and (not(fastOf ?fastLift ?from))
		                   (fastOf ?fastLift ?to)
              	 )
	)
	
	(:action move_down_fast
		:parameters (?fastLift ?from ?to)
            
		:precondition (and  (fastOf ?fastLift ?from)
                   		    (isNext10 ?to ?from)
                      )
		:effect   (and (not(fastOf ?fastLift ?from))
		                (fastOf ?fastLift ?to)
              	 )
	)
	
        
    (:action put_worker_in_fast
        :parameters (?fastLift ?worker ?floor)
        
        :precondition (and(fastOf ?fastLift ?floor)
                          (wAt ?worker ?floor)
                      )
        
        :effect       (and(wAfast ?worker ?fastLift)
                       (not(wAt ?worker ?floor))
                      )
    )
    
    (:action put_worker_in_slow
        :parameters (?slowLift ?worker ?floor)
        
        :precondition (and(slowOf ?slowLift ?floor)
                          (wAt ?worker ?floor)
                      )
        
        :effect       (and(wAslow ?worker ?slowLift)
                       (not(wAt ?worker ?floor))
                      )
    )
    
    (:action put_worker_from_fast_in_floor
        :parameters (?fastLift ?worker ?floor)
        
        :precondition (and (wAfast ?worker ?fastLift)
                           (fastOf ?fastLift ?floor)
                      )
        
        :effect       (and (wAgoal ?worker ?floor)
                           (not(wAfast ?worker ?fastLift))
                      )
    )
    
    (:action put_worker_from_slow_in_floor
        :parameters (?slowLift ?worker ?floor)
        
        :precondition (and (wAslow ?worker ?slowLift)
                          (slowOf ?slowLift ?floor)
                      )
        
        :effect       (and  (wAgoal ?worker ?floor)
                            (not(wAslow ?worker ?slowLift))
                       )
        
    )
)
