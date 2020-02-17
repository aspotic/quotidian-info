% file: sched.pl
% author: adam knox
% nsid: ark043
% CMPT 340
% assignment 1
% questions 3

% Synopsis: Defines some simple Prolog rules for a database about
%           temporal events.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data structures used
% (Note: The documentation is useful, but no declarations 
% are necessary to use these data structures.)  Thus this
% part of the file is entirely comments.

% date(Day, Month, Year)
%   Day: 1-31 (depending on the month)
%   Month: jan feb mar apr may june july aug sept oct nov dec
%   Year: any positive integer
date(Day, Month, Year) :-
	Day >= 1,
	Day =< 31,
	Year > 0,
	month(Month).

% month(Month)
% Month: jan feb mar apr may june july aug sept oct nov dec
month(Month) :-
	Month = jan;
	Month = feb;
	Month = mar;
	Month = apr;
	Month = may;
	Month = june;
	Month = july;
	Month = aug;
	Month = sept;
	Month = oct;
	Month = nov;
	Month = dec.



% time24(Hour, Minute)
%   Hour: 0-23
%   Minute: 0-59
time24(Hour, Minute) :-
	Hour >= 0,
	Hour =< 23,
	Minute >= 0,
	Minute =< 59.

% event(Date, StartTime, EndTime, Details)
%   Date: a date/3 structure as above
%   StartTime, EndTime: A time24/2 as above
%   Details: any (presumably a name for the event, and any other detail)
event(date(Day, Month, Year), time24(HStart, MStart), time24(HEnd, MEnd), _) :-
	date(Day, Month, Year),
	before_time(StartTime, EndTime).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% event database
% The database consists of facts of the following form:

% anEvent(Event)
%   Event: an event/4 structure as above.

% To Do:  Write down your class schedule for this term 
% using the facts anEvent/1, and the structures defined above.
anEvent(event(date(24, jan, 2011), time24(11, 30), time24(12, 20), 'Differential Equations II')).
anEvent(event(date(26, jan, 2011), time24(11, 30), time24(12, 20), 'Differential Equations II')).
anEvent(event(date(28, jan, 2011), time24(11, 30), time24(12, 20), 'Differential Equations II')).

anEvent(event(date(24, jan, 2011), time24(9, 30), time24(10, 20), 'Networking')).
anEvent(event(date(26, jan, 2011), time24(9, 30), time24(10, 20), 'Networking')).
anEvent(event(date(28, jan, 2011), time24(9, 30), time24(10, 20), 'Networking')).

anEvent(event(date(25, jan, 2011), time24(8, 30), time24(9, 50), 'Macroeconomics')).
anEvent(event(date(27, jan, 2011), time24(8, 30), time24(9, 50), 'Macroeconomics')).

anEvent(event(date(25, jan, 2011), time24(10, 00), time24(11, 20), 'Programming Paradigms')).
anEvent(event(date(27, jan, 2011), time24(10, 00), time24(11, 20), 'Programming Paradigms')).

anEvent(event(date(27, jan, 2011), time24(14, 30), time24(17, 0), 'Physics Seminar')).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% rules about time
%
% To do:  For each of the predicates described below, 
% write a simple Prolog rule (or rules).



%%%%%
% before_time(Time1,Time2)
% Time1 is strictly earlier than Time2 
% Your program should handle both.
% To Do: Implement before_time/2 for times.
before_time(time24(Hs, Ms), time24(He, Me)) :- 
	Hs = He,
	Ms < Me;
	Hs < He.



%%%%%
% meet(Event1,Event2)
% Event1 ends exactly when Event2 begins
% To Do: Implement meet/2 for events
meet(event(Date, _, time24(MidH, MidM), _), event(Date, time24(MidH, MidM), _, _)).
	
	

%%%%%
% before(Event1,Event2)
% Event1 ends before Event2 begins
% To Do: Implement before/2 for events
before(event(Date, _, time24(H1End, M1End), _), event(Date, time24(H2Start, M2Start), _, _)) :-
	before_time(time24(H1End, M1End), time24(H2Start, M2Start)).



%%%%%
% during(Event1,Event2)
% Event1 happens while Event2 happens
% To Do: Implement during/2 for events
during(event(Date, time24(H1Start, M1Start), time24(H1End, M1End), _), event(Date, time24(H2Start, M2Start), time24(H2End, M2End), _)) :-
	before_time(time24(H2Start, M2Start), time24(H1Start, M1Start)),
	before_time(time24(H1End, M1End), time24(H2End, M2End)).
	

%%%%%
% after(Event1, Event2)
% Event1 begins after Event2 ends
% To Do: Implement after/2 for events
before(event(Date, time24(H1Start, M1Start), _, _), event(Date, _, time24(H2End, M2End), _)) :-
	before_time(time24(H2End, M2End), time24(H1Start, M1Start)).	



%%%%%
% overlap(Event1,Event2)
% Event1 starts before Event2, and Event2 starts before Event1 ends

% To Do: Implement overlap/2 for events
overlap(event(Date, time24(H1Start, M1Start), time24(H1End, M1End), _), event(Date, time24(H2Start, M2Start), time24(H2End, M2End), _)) :-
	before_time(time24(H1Start, M1Start), time24(H2End, M2End)),
	before_time(time24(H2Start, M2Start), time24(H1End, M1End)).


% eof
