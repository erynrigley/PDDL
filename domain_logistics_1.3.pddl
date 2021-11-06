(define (domain basic_logistics)
(:requirements :strips :typing :durative-actions :numeric-fluents :timed-initial-literals :duration-inequalities)
    
    (:types
        locatable location - object
        package truck driver plane ship - locatable
    )
    
    (:predicates
        (ground_connected ?from ?to - location)
        (lighthouse_connected ?from ?to - location)
        (sky_connected ?from ?to - location)

        (at ?o - locatable ?l - location)
        
        (in_truck ?p - package ?t - truck)
        (in_ship ?p - package ?s - ship)
        (in_plane ?p - package ?pl - plane)
        
        (driving ?d - driver ?t - truck)
    
        (package-free ?p - package)
 
    )
    
    (:functions
        (distance ?from ?to - location)
        
        (ship_speed ?s - ship)
        (walker_speed ?d - driver)
        (truck_speed ?t - truck)
        (plane_speed ?pl - plane)
    )
    
    ;;================;;
    ;; driver actions ;;
    ;;================;;
    
    (:durative-action walk
      :parameters (?d - driver ?from ?to - location)
      :duration (= ?duration (/(distance ?from ?to) (walker_speed ?d)))
      :condition (and
        (at start (at ?d ?from))
        (over all (ground_connected ?from ?to))
      )
      :effect (and
        (at start (not (at ?d ?from)))
        (at end (at ?d ?to))
      )
    )
    
    (:durative-action board_vehicle
      :parameters (?t - truck ?d - driver ?wp - location)
      :duration (= ?duration 10)
      :condition (and
        (at start (at ?d ?wp))
        (over all (at ?t ?wp))
      )
      :effect (and
        (at start (not (at ?d ?wp)))
        (at end (driving ?d ?t))
      )
    )
    
    (:durative-action disembark_vehicle
      :parameters (?t - truck ?d - driver ?wp - location)
      :duration (= ?duration 10)
      :condition (and
        (at start (driving ?d ?t))
        (over all (at ?t ?wp))
      )
      :effect (and
        (at start (not (driving ?d ?t)))
        (at end (at ?d ?wp))
      )
    )
    
    ;;=================;;
    ;; vehicle actions ;;
    ;;=================;;
    
    (:durative-action drive_truck
      :parameters (?t - truck ?d - driver ?from ?to - location)
      :duration (= ?duration (/(distance ?from ?to) (truck_speed ?t)))
      :condition (and
        (at start (at ?t ?from))
        (over all (ground_connected ?from ?to))
        (over all (driving ?d ?t))
      )
      :effect (and
        (at start (not (at ?t ?from)))
        (at end (at ?t ?to))
      )
    )
    
    (:durative-action fly_plane
      :parameters (?pl - plane ?from ?to - location)
      :duration (= ?duration (/(distance ?from ?to) (plane_speed ?pl)))
      :condition (and
        (at start (at ?pl ?from))
        (over all (sky_connected ?from ?to))
      )
      :effect (and
        (at start (not (at ?pl ?from)))
        (at end (at ?pl ?to))
      )
    )
    
    (:durative-action drive_ship
      :parameters (?s - ship ?from ?to - location)
      :duration (= ?duration (/(distance ?from ?to) (ship_speed ?s)))
      :condition (and
        (at start (at ?s ?from))
        (over all (lighthouse_connected ?from ?to))
      )
      :effect (and
        (at start (not (at ?s ?from)))
        (at end (at ?s ?to))
      )
    )
    
    ;;=================;;
    ;; package actions ;;
    ;;=================;;
    
    (:durative-action load_truck
      :parameters (?t - truck ?p - package ?wp - location)
      :duration (= ?duration 10)
      :condition (and
        (at start (at ?p ?wp))
        (at start (at ?t ?wp))
        (over all (package-free ?p))
      )
      :effect (and
        (at start (not (at ?p ?wp)))
        (at end (in_truck ?p ?t))
      )
    )
    
    (:durative-action unload_truck
      :parameters (?t - truck ?p - package ?wp - location)
      :duration (= ?duration 10)
      :condition (and
        (at start (in_truck ?p ?t))
        (over all (at ?t ?wp))
        (over all (package-free ?p))
      )
      :effect (and
        (at start (not (in_truck ?p ?t)))
        (at end (at ?p ?wp))
      )
    )
    
    (:durative-action load_ship
      :parameters (?s - ship ?p - package ?wp - location)
      :duration (= ?duration 10)
      :condition (and
        (at start (at ?p ?wp))
        (at start (at ?s ?wp))
        (over all (package-free ?p))
      )
      :effect (and
        (at start (not (at ?p ?wp)))
        (at end (in_ship ?p ?s))
      )
    )
    
    (:durative-action unload_ship
      :parameters (?s - ship ?p - package ?wp - location)
      :duration (= ?duration 10)
      :condition (and
        (at start (in_ship ?p ?s))
        (over all (at ?s ?wp))
        (over all (package-free ?p))
      )
      :effect (and
        (at start (not (in_ship ?p ?s)))
        (at end (at ?p ?wp))
      )
    )
    
     (:durative-action load_plane
      :parameters (?pl - plane ?p - package ?wp - location)
      :duration (= ?duration 10)
      :condition (and
        (at start (at ?p ?wp))
        (at start (at ?pl ?wp))
        (over all (package-free ?p))
      )
      :effect (and
        (at start (not (at ?p ?wp)))
        (at end (in_plane ?p ?pl))
      )
    )
    
    (:durative-action unload_plane
      :parameters (?pl - plane ?p - package ?wp - location)
      :duration (= ?duration 10)
      :condition (and
        (at start (in_plane ?p ?pl))
        (over all (at ?pl ?wp))
        (over all (package-free ?p))
      )
      :effect (and
        (at start (not (in_plane ?p ?pl)))
        (at end (at ?p ?wp))
      )
    )
    
)