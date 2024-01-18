%---fluents---
cupboardOpen(n, []). %cupboard is not open
onCounter(n,[]).%cup is not on counter
kettleFull(n,[]).% kettle is empty
plugIn(n,[]). %kettle is not plugged
boiled(n,[]).%water is not boiling
water_inCup(n,[]).%hot water is not in cup
coffee_add(n,[]).%coffee is not added
stirred(n,[]). %coffee is not stirred

%---Pre-Condition---
%cupboard can be opened if it closed, and cup is not on counter
poss([openCupboard()|S]):- cupboardOpen(n,S),onCounter(n,S).

%cup can be placed if cupboard is open and is not already on counter
poss([place_Cup()|S]):- cupboardOpen(y,S),onCounter(n,S).

% filling the kettle is possible if the kettle is not full and cup is on
% the counter
poss([fillKettle()|S]):- onCounter(y,S), kettleFull(n,S).


%you can plug in kettle if kettle is full and is not plugged in
poss([plugKettle()|S]):-  kettleFull(y,S), plugIn(n,S).


% you should wait for water to boil, if it is plugged
poss([wait()|S]):- plugIn(y,S),boiled(n,S).

% Hot water can be poured if water is boiled and water
poss([pour_hotWater()|S]):- boiled(y,S), water_inCup(n,S).

%add coffee if water is in cup, and coffee isnt already in the cup
poss([add_coffee()|S]):- water_inCup(y,S),coffee_add(n,S).

%coffee can be stirred if it isnt already stirred and  coffee is added
poss([stir_coffee()|S]):- coffee_add(y,S).


%---Axiom---
%cupboard can be open if cup not placed on the counter
cupboardOpen(y,[openCupboard()|S]):- poss([openCupboard()|S]).

%cupboard would be closed if you place the cup unless you opened
cupboardOpen(n,[place_Cup()|S]):- poss([place_Cup()|S]).
cupboardOpen(n,[A|S]):- poss([A|S]), A \= openCupboard(), cupboardOpen(n,S).


% cup is on counter if placed unless your try to grab it from the
% cupboard.
onCounter(y,[place_Cup()|S]):- poss([place_Cup()|S]).
onCounter(y,[A|S]):- poss([A|S]), A \= openCupboard(), onCounter(y,S).

%cup is not on counter unless placed
onCounter(n,[fillKettle()|S]):- poss([fillKettle()|S]).
onCounter(n,[A|S]):- poss([A|S]), A \= place_Cup(), onCounter(n,S).

%kettle can be filled if unless cup is being placed
kettleFull(y,[fillKettle()|S]):- poss([fillKettle()|S]).
kettleFull(y,[A|S]):- poss([A|S]), A \= place_Cup(), kettleFull(y,S).

%kettle cant plugged unless full
kettleFull(n,[plugKettle()|S]):- poss([plugKettle()|S]).
kettleFull(n,[A|S]):- poss([A|S]), A \= fillKettle(), kettleFull(n,S).

%Kettle can be plug in not already boiling
plugIn(y,[plugKettle()|S]):- poss([plugKettle()|S]).
plugIn(y,[A|S]):- poss([A|S]), A \= fillKettle(), plugIn(y,S).

%kettle cant be plugged in if its already boiling
plugIn(n,[wait()|S]):- poss([wait()|S]).
plugIn(n,[A|S]):- poss([A|S]), A \= plugKettle(), plugIn(n,S).

%water can be boiled unless its being plugged
boiled(y,[wait()|S]):- poss([wait()|S]).
boiled(y,[A|S]):- poss([A|S]), A \= plugKettle(), boiled(y,S).

%water cant be boiling if the water is being poured
boiled(n,[pour_hotWater()|S]):- poss([pour_hotWater()|S]).
boiled(n,[A|S]):- poss([A|S]), A \= wait(), boiled(n,S).

%water is can be poured in cup unless its still boiling
water_inCup(y,[pour_hotWater()|S]):- poss([pour_hotWater()|S]).
water_inCup(y,[A|S]):- poss([A|S]), A \= wait(), water_inCup(y,S).

%water cant be in the cup if its boiling unles you pour it
water_inCup(n,[add_coffee()|S]):- poss([add_coffee()|S]).
water_inCup(n,[A|S]):- poss([A|S]), A \= pour_hotWater(), water_inCup(n,S).

%coffee can be added unless water is being poured
coffee_add(y,[add_coffee()|S]):- poss([add_coffee()|S]).
coffee_add(y,[A|S]):- poss([A|S]), A \= pour_hotWater(), coffee_add(y,S).

%coffee cant be added if coffee is being stirred
coffee_add(n,[stir_coffee()|S]):- poss([stir_coffee()|S]).
coffee_add(n,[A|S]):- poss([A|S]), A \= add_coffee(), coffee_add(n,S).

%coffee can be stirred with stirred coffee action
stirred(y,[stir_coffee()|S]):- poss([stir_coffee()|S]).
stirred(y,[A|S]):- poss([A|S]), stirred(y,S).


%---Breath First Search ----
%! plan(stirred(y,S),S).
plan(Goal,Plan):- bposs(Plan),Goal.
bposs(S) :- tryposs([],S).
tryposs(S,S) :- poss(S).
tryposs(X,S) :- tryposs([_|X],S).




