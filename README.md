# Coffee Making Prolog Program  

**Overview**  
This repository contains a Prolog program that implements a knowledge representation of a domain in which a robot makes a cup of instant coffee. The program allows the robot to plan and execute the steps required to make coffee efficiently.
This Prolog program builds on previous experience to represent a coffee-making domain from a robot's perspective. It involves writing logical axioms to represent the domain and using Prolog syntax to implement a procedural interpretation of these axioms. The program solves a coffee world planning problem using knowledge representation and Prolog, facilitating debugging and execution tracing with a graphical utility.

**Coffee Domain**  
*The coffee-making domain involves a series of actions that the robot needs to perform to make a cup of instant coffee:*   
 -Open a cupboard, take a cup from the cupboard, and place it on the counter.  
 -Fill a kettle with water and plug it in.  
 -After the water boils, pour hot water into the cup.  
 -Add instant coffee to the cup.  
 -Stir the coffee to complete the process.  
 -The goal is to represent this domain in Prolog and create a program that plans and executes these steps effectively.  

**State of the World**
To represent the state of the world, we define fluents that capture the relevant aspects of the domain. These fluents include:  
 -cup_on_counter  
 -kettle_filled  
 -kettle_plugged_in  
 -water_boiling  
 -hot_water_in_cup  
 -coffee_added  
 -coffee_stirred  

 **Actions**  
Relevant actions in this world include:  
 -open_cupboard  
 -take_cup  
 -place_cup_on_counter  
 -fill_kettle  
 -plug_in_kettle  
 -boil_water  
 -pour_hot_water  
 -add_coffee  
 -stir_coffee  

**Precondition Axioms**  
Precondition axioms determine under which conditions each action is possible. For example:  

**Successor State Axioms**  
Successor state axioms describe how the state changes after each action occurrence. For instance:  

**Planning the Goal**  
To plan and achieve the goal of making coffee, we define a Prolog procedure:  
The goal state g(S) represents a state of the world in which the coffee is ready. It depends on fluents that indicate the completion of relevant actions.  
 
