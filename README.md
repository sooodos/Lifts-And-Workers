# Lifts-And-Workers

## Table of contents
* [Description](#description)
* [Concept](#concept)
* [Domain](#domain)
* [Problem-1](#problem-1)
* [Problem-2](#problem-2)
* [Execution](#execution)

## Description
Planning Domain Definition Language solution for a fun problem about workers using elevators

## Concept
https://en.wikipedia.org/wiki/Planning_Domain_Definition_Language

## Domain
### Predicates. 
- (wAt ?x ?y) : This predicate shows the state of a worker being At a floor. ?x is the worker and ?y the floor. 
 
- (wAfast ?x ?y): This predicate shows the state of a worker being At a fast elevator. ?x is the worker and ?y the fast elevator which the worker is in. 
 
- (wAslow ?y ?y): This predicate shows the state of a worker being At a slow elevator. ?x is the worker and ?y the slow elevator which the worker is in. 
 
- (fastOf ?x ?y): This predicate shows the state of a fast elevator being At a floor. ?x is the fast elevator and ?y is the floor which the fast elevator is in. 
 
- (slowOf ?x ?y): This predicate shows the state of a slow elevator being At a floor. ?x is the slow elevator and ?y is the floor which the fast elevator is in. 
 
- (wAgoal ?x ?y): This predicate is the state where if true means that the worker has reached a floor which is his goal. ?x is the worker and ?y is his goal floor. 
 
- (isNext ?x ?y): This predicate is used in order to give the problem its sense of order in floors. With this predicate we determine which floor is next after the move of a slow elevator. This can be used both for going up AND for going down since we can just switch the destination floor with the origin floor for going down and we can find out if it is a legal slow move. 
 
- (isNext10 ?x ?y): The same logic is used for the next floor which a fast elevator can reach except we need a separate predicate state in order to define that a fast elevator moves 10 floors at a time. 

### Actions
We have four actions for moving an elevator. move_up_slow, move_up_fast, move_down_slow, move_fown_fast. The names of the actions pretty much tell what we are trying to accomplish. They are very similar. 
Let’s walk through the logic of move_down_slow. The parameters we need to perform this action are a slow elevator, an origin floor, and a goal floor. To be able to move first we check on our preconditions that the slow elevator is indeed in the origin floor given and that the goal floor is indeed the next floor based on our isNext declaration. We can notice that isNext is used differently in the down actions since we give as ?x the ?to floor and as ?y the ?from floor. An example. Let’s say that we declared that the next floor of f0 is f1. That means that if we want to go up from f0 with a slow elevator our goal floor must be f1. Hence when we check with (isNextf0 f1) we get a true value. If we want to go down however, how do we do it without creating another predicate? Let’s say we are floor f1 and want to go to f0 (We have declared (isNext f0 f1)). What we do is used isNext in reverse and basically say that if we were to go from the goal floor to the origin floor would that be a state that is true? That is indeed the case since going from f0 to f1 is a true state so the other way around must be true. That leaves us with the effect of move_down_slow. We remove the slow elevator from its origin floor AND declare its value true to the goal floor. 
 
Then we have the actions that put a worker from a floor to an elevator (fast or slow, they are similar). 
Let’s walk through the logic of putting a worker to a fast elevator (action put_worker_in_fast). The parameters we need is the fast elevator we are trying to put the worker in, the worker, and the floor this event might take place. In our preconditions we must check for 2 things: The elevator given is indeed on the floor given AND the worker given is indeed in the floor given. Then we can proceed to the effects which basically remove the worker from the floor and assigning him to that elevator by making the value of the sate wAfast true.  
 
Lastly, we have the actions responsible for reaching our goal floors, meaning taking the worker out of the elevator when he reaches a floor which is pre-declared as a goal floor. Let’s walk through the logic of putting a worker from a fast elevator to a goal floor (action put_worker_from_fast_in_floor). For parameters we need the fast elevator, the worker and the floor. The preconditions are that the worker is indeed in that elevator and that the elevator is indeed in the potential goal floor. We do not check as a precondition that that floor is goal floor since we give this program to a solver but we could possibly create another predicate identical to wAgoal and pre-declare all goal states so that the elevator will only stop if it is indeed a goal state of a worker but there was no real need to do that. The effect is that we put the worker at a goal state. If that worker is indeed at a goal state, the predicate will be turned to true and have one less worker to worry about AND remove that worker from the elevator. 


## Problem-1
In this problem we have 11 floors, 4 workers 2 fast elevators and 2 slow elevators. We firstly initialize the positions of the elevators. All elevators are initially in floor f0. Then we initialize the positions of the workers. w1 in f0,w2 in f2, w3 in f5, w4 in f7. The isNext predicate is used to let the domain know which floor follows the move of a slow elevator. isNext10 is used to let the domain know which floor follows after the move of a fast elevator. In the case of problem1 the fast elevators can only move in floors f0 and f10. The goal states are as shown: 

- w1 at f10
- w2 at f10
- w3 at f9
- w4 at f9. 
 
Below an example trace of LAMA PLANNER is shown. 

### TRACE 
* (put_worker_in_slow slow2 w1 f0) 
* (move_up_slow slow2 f0 f1) 
* (move_up_slow slow2 f1 f2) 
* (put_worker_in_slow slow2 w2 f2) 
* (move_up_slow slow2 f2 f3) 
* (move_up_slow slow2 f3 f4) 
* (move_up_slow slow2 f4 f5) 
* (put_worker_in_slow slow2 w3 f5) 
* (move_up_slow slow2 f5 f6)
* (move_up_slow slow2 f6 f7) 
* (put_worker_in_slow slow2 w4 f7) 
* (move_up_slow slow2 f7 f8) 
* (move_up_slow slow2 f8 f9) 
* (put_worker_from_slow_in_floor slow2 w4 f9) 		GOAL STATE 	
* (put_worker_from_slow_in_floor slow2 w3 f9) 
* (move_up_slow slow2 f9 f10) 				GOAL STATE 	
* (put_worker_from_slow_in_floor slow2 w1 f10) 	GOAL STATE 	
* (put_worker_from_slow_in_floor slow2 w2 f10) 	GOAL STATE 	


## Problem-2
In this problem we have 21 floors, 8 workers 4 fast elevators and 4 slow elevators. We firstly initialize the positions of the elevators. All elevators are initially in floor f0. Then we initialize the positions of the workers. w1 in f0, w2 in f1, w3 in f2, w4 in f3, w5 in f4, w6 in f5, w7 in f6, w8 in f7.  The isNext predicate is used to let the domain know which floor follows the move of a slow elevator. isNext10 is used to let the domain know which floor follows after the move of a fast elevator. In the case of problem1 the fast elevators can move in floors f0, f10 and f20. The goal states are as shown: 

- w1 in f10
- w2 in f5
- w3 in f5
- w4 in f5
- w5 in f9
- w6 in f19
- w7 in f17
- w8 in f21

Below the trace of LAMA PLANNER is shown. 

### TRACE 
* (move_up_slow slow2 f0 f1) 
* (put_worker_in_slow slow2 w2 f1) 
* (move_up_slow slow2 f1 f2) 
* (put_worker_in_slow slow2 w3 f2) 
* (move_up_slow slow2 f2 f3) 
* (put_worker_in_slow slow2 w4 f3) 
* (move_up_slow slow2 f3 f4) 
* (put_worker_in_slow slow2 w5 f4) 
* (move_up_slow slow2 f4 f5) 
* (put_worker_from_slow_in_floor slow2 w2 f5) 			GOAL STATE 
* (put_worker_from_slow_in_floor slow2 w4 f5) 			GOAL STATE 
* (put_worker_from_slow_in_floor slow2 w3 f5) 
* (put_worker_in_slow slow2 w6 f5) 
* (move_up_slow slow2 f5 f6) 
* (put_worker_in_slow slow2 w7 f6) 
* (move_up_slow slow2 f6 f7) 
* (put_worker_in_slow slow2 w8 f7) 
* (move_up_slow slow2 f7 f8) 
* (move_up_slow slow2 f8 f9) 					GOAL STATE 
* (put_worker_from_slow_in_floor slow2 w5 f9) 			GOAL STATE 
* (move_up_slow slow2 f9 f10) 
* (move_up_slow slow2 f10 f11) 
* (move_up_slow slow2 f11 f12) 
* (move_up_slow slow2 f12 f13) 
* (move_up_slow slow2 f13 f14) 
* (move_up_slow slow2 f14 f15) 
* (move_up_slow slow2 f15 f16) 
* (move_up_slow slow2 f16 f17) 
* (put_worker_from_slow_in_floor slow2 w7 f17) 
* (move_up_slow slow2 f17 f18) 
* (move_up_slow slow2 f18 f19) 					GOAL STATE 
* (put_worker_from_slow_in_floor slow2 w6 f19) 
* (move_up_slow slow2 f19 f20) 
* (move_up_slow slow2 f20 f21) 					GOAL STATE 
* (put_worker_from_slow_in_floor slow2 w8 f21) 
* (put_worker_in_fast fast3 w1 f0) 
* (move_up_fast fast3 f0 f10) 					GOAL STATE 
* (put_worker_from_fast_in_floor fast3 w1 f10) 			GOAL STATE 

## Execution
The easiest way to try this out is from some online pddl editor
You can try this one http://editor.planning.domains/ or one of your choice. You have to give as the domain the domain file and as a proble file one of the problem files give or create your own problem file!
