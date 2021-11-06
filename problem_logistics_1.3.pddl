(define (problem problem_logistics)
(:domain basic_logistics)
(:requirements :strips :typing :numeric-fluents :timed-initial-literals :duration-inequalities)

    (:objects 
        wp1 wp2 wp3 wp4 wp5 wp6 wp7 wp8 wp9 wp10 wp11 wpsky wplhouse - location
        t1 t2 - truck
        pl1 - plane
        sh1 - ship
        dr1 dr2 - driver
        pack1 pack2 pack3 pack4 - package
    )
    
    (:init
        ;; drivers
        (at dr1 wp4)
        (at dr2 wp1)
        
        ;; trucks
        (at t1 wp6)
        (at t2 wp9)
        
        ;;plane
        (at pl1 wpsky)
        
        ;;ship
        (at sh1 wplhouse)
        
        ;; packages
        (at pack1 wp2)
        (at pack2 wp3)
        (at pack3 wp5)
        (at pack4 wp11)
        
        ;; Ground Connections
        (ground_connected wp1 wp2)
        (ground_connected wp2 wp1)
        (ground_connected wp2 wp3)
        (ground_connected wp3 wp2)
        (ground_connected wp3 wp8)
        (ground_connected wp8 wp3)
        (ground_connected wp8 wp11)
        (ground_connected wp11 wp8)
        (ground_connected wp11 wp10)
        (ground_connected wp10 wp11)
        (ground_connected wp10 wp9)
        (ground_connected wp9 wp10)
        (ground_connected wp9 wp4)
        (ground_connected wp4 wp9)
        (ground_connected wp4 wp1)
        (ground_connected wp1 wp4)
        (ground_connected wp1 wp5)
        (ground_connected wp5 wp1)
        (ground_connected wp5 wp6)
        (ground_connected wp6 wp5)
        (ground_connected wp6 wp7)
        (ground_connected wp7 wp6)
        (ground_connected wp2 wp6)
        (ground_connected wp6 wp2)
        
        ;;Lighthouse Connections
        
        (lighthouse_connected wp7 wplhouse)    
        (lighthouse_connected wplhouse wp7)    
        
        ;;Sky Connections 
        
        (sky_connected wp2 wpsky)       
        (sky_connected wpsky wp2)
        (sky_connected wp4 wpsky)
        (sky_connected wpsky wp4)
        
        
        ;; Distances
        (= (distance wp1 wp2) 100) ;;ground-connections
        (= (distance wp2 wp1) 100)
        
        (= (distance wp2 wp6) 75)
        (= (distance wp6 wp2) 75)
        
        (= (distance wp2 wp3) 100)
        (= (distance wp3 wp2) 100)
        
        (= (distance wp3 wp8) 75)
        (= (distance wp8 wp3) 75)
        
        (= (distance wp8 wp11) 75)
        (= (distance wp11 wp8) 75)
        
        (= (distance wp11 wp10) 100)
        (= (distance wp10 wp11) 100)
        
        (= (distance wp10 wp9) 100)
        (= (distance wp9 wp10) 100)
        
        (= (distance wp9 wp4) 75)
        (= (distance wp4 wp9) 75)
        
        (= (distance wp1 wp4) 75)
        (= (distance wp4 wp1) 75)
        
        (= (distance wp1 wp5) 75)
        (= (distance wp5 wp1) 75)
        
        (= (distance wp5 wp6) 50)
        (= (distance wp6 wp5) 50)
        
        (= (distance wp7 wp6) 50)
        (= (distance wp6 wp7) 50)
        
        (= (distance wp7 wplhouse) 75)  ;;lighthouse-connections
        (= (distance wplhouse wp7) 75)
        
        (= (distance wp2 wpsky) 20)     ;;sky-connections
        (= (distance wpsky wp2) 20)
        
        (= (distance wp4 wpsky) 20)
        (= (distance wpsky wp4) 20)
        
        ;;Speeds
        (= (ship_speed sh1) 1.5)
        (= (walker_speed dr1) 0.5)
        (= (walker_speed dr2) 0.5)
        (= (truck_speed t1) 1)
        (= (truck_speed t2) 1)
        (= (plane_speed pl1) 2)
        
        ;;timed-initial-literals
        (package-free pack1)  
        (package-free pack2)
        (package-free pack3)
        (package-free pack4)
        
        ;;timed-initial-literals - 1.2
        ;(at 1386 (not(package-free pack1))) ;;minimum time for all
        ;(at 1386 (not(package-free pack2)))
        ;(at 1386 (not(package-free pack3)))
        ;(at 1386 (not(package-free pack4)))
        
        ;;timed-initial-literals - 1.3
        (at 321 (not(package-free pack1))) ;;minimum time for pack1 (1.3)
        (at 1426 (not(package-free pack2)))
        (at 1426 (not(package-free pack3)))
        (at 1426 (not(package-free pack4)))
    )
        
    (:goal (and 
        ;; drivers home
        ;(at dr1 wp1)
        ;(at dr2 wp1)
        
        ;; packages delivered
        (at pack1 wp9)
        (at pack2 wplhouse)
        (at pack3 wp9)
        (at pack4 wp2)
    ))
)