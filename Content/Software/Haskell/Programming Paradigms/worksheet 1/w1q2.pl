% author: Adam Knox
% nsid: ark043
% CMPT 340
% assignment 1
% questions 2

% Synopsis: Two methods to find the time for a spaceship to travel a given distance
%	if the spaceship takes 1 min to travel half the distance, and 1 min to travel
%	a distance larger than 0 and less than or equal to 1


%%%%%%%%%%%%%%%%%%%%%%
% tail recursion version
%%%%%%%%%%%%%%%%%%%%%%
% travelTimeT(+Distance, -Time)
% 1min to travel half the current distance; 1 min to travel a distance between 0 and 1 
% calculates total travel time

% The case where the space ship is at the destination
travelTimeT(0, Time) :-
	Time is 0.

% Nice function for the user to use
travelTimeT(Distance, Time) :-
    travelTimeT_loop(Distance, 0, Time).
    
% Case 1: Ship must jump half the distance in 1 minute
travelTimeT_loop(Distance, T, Time) :-
    Distance > 1,
    Distance1 is Distance / 2,
    T1 is T + 1,
    travelTimeT_loop(Distance1, T1, Time).
    
% Case 2: Ship is traveling the last meter in 1 minute
travelTimeT_loop(Distance, T, Time) :-
    Distance > 0,
    Distance =< 1,
    Time is T + 1.
%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%
% recursion version
%%%%%%%%%%%%%%%%%%%%%%
% travelTime(+Distance, -Time)
% 1min to travel half the current distance; 1 min to travel a distance between 0 and 1 
% calculates total travel time

% The case where the space ship is at the destination
travelTime(0, Time) :-
	Time is 0.

% Base Case: Spaceship is within 1 of the destination
travelTime(Distance, Time) :-
	Distance > 0,
	Distance =< 1,
	Time is 1.

% Recursive Case: Spaceship is traveling half the distance in 1 minute
travelTime(Distance, Time) :-
	Distance > 1,
	Distance2 is Distance / 2,
	travelTime(Distance2, Time2),
	Time is Time2 + 1.

%%%%%%%%%%%%%%%%%%%%%%
