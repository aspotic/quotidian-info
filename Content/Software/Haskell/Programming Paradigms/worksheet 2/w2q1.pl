% author: Adam Knox
% nsid: ark043
% CMPT 340
% assignment 2
% questions 1

% Synopsis: exp(B,E,Ans); expT(B,E,Ans); expH(B,E,Ans); and expHT(B,E,Ans) compute B**E (or B^E) using various methods




%%%%%%%%%%%%%%%%%%%%%%
% recursive version
%%%%%%%%%%%%%%%%%%%%%%
% exp(+B, +E, -Ans)
% Base: B
% Exponent: E >= 0, Integer
% Answer: A
% Finds B**E using recursion
%%%%%%%%%%%%%%%%%%%%%%

% Base Case
exp(B, 0, Ans):-
	B > 0,
	Ans is 1;
	B < 0,
	Ans is 1.

% Recursive Case
exp(B, E, Ans):-
	E > 0,
	E2 is E - 1,
	exp(B, E2, Ans2),
	Ans is Ans2 * B.	
	
	
	

%%%%%%%%%%%%%%%%%%%%%%
% tail recursive version
%%%%%%%%%%%%%%%%%%%%%%
% expT(+B, +E, -Ans)
% Base: B
% Exponent: E >= 0, Integer
% Answer: A
% Finds B**E using tail recursion
%%%%%%%%%%%%%%%%%%%%%%

% Interface Base Case
expT(B, 0, Ans):-
	B > 0,
	Ans is 1;
	B < 0,
	Ans is 1.
	
% User Interface
expT(B, E, Ans):-
	E > 0,
	expT_Loop(B, E, 1, Ans).
	
% Base Case
expT_Loop(_, 0, T, T).
	
% Recursive Case
expT_Loop(B, E, CurrAns, Ans):-
	E > 0,
	E2 is E - 1,
	CurrAns2 is CurrAns * B,
	expT_Loop(B, E2, CurrAns2, Ans).

	
	

%%%%%%%%%%%%%%%%%%%%%%
% O(logN) in time and space complexity version
%%%%%%%%%%%%%%%%%%%%%%
% expH(+B, +E, -Ans)
% Base: B
% Exponent: E >= 0, Integer
% Answer: A
% Finds B**E using recursion, and divides the question in half at each step to get O(logN)
%%%%%%%%%%%%%%%%%%%%%%

% Base Cases
expH(B, 1, B).
expH(B, 0, Ans):-
	B > 0,
	Ans is 1;
	B < 0,
	Ans is 1.
	
% Recursive Case where the exponent is even
expH(B, E, Ans):-
	E > 1,
	E mod 2 =:= 0,
	E2 is E // 2,
	expH(B, E2, Ans2),
	Ans is Ans2 * Ans2.	
	

% Recursive Case where the exponent is odd
expH(B, E, Ans):-
	E > 1,
	E mod 2 =:= 1,
	E2 is E // 2,
	expH(B, E2, Ans2),
	Ans is Ans2 * Ans2 * B.	





	
%%%%%%%%%%%%%%%%%%%%%%
% O(logN) time and and O(1) space complexity version
%%%%%%%%%%%%%%%%%%%%%%
% expHT(+B, +E, -Ans)
% Base: B
% Exponent: E >= 0, Integer
% Answer: Ans
% Finds B**E using tail recursion, and divides the question in half at each step to get O(logN)
%%%%%%%%%%%%%%%%%%%%%%

% Interface Base Case
expHT(B, 0, Ans):-
	B > 0,
	Ans is 1;
	B < 0,
	Ans is 1.

% User Interface
expHT(B, E, Ans):-
	expHT_Loop(B, E, B, Ans).
	
% Base Case
expHT_Loop(B, 1, T, T).

% Recursive Case where the exponent is even
expHT_Loop(B, E, CurrT, Ans):-
	E > 1,
	E mod 2 =:= 0,
	E2 is E // 2,
	CurrT2 is CurrT * CurrT,
	expHT_Loop(B, E2, CurrT2, Ans).
	

% Recursive Case where the exponent is odd
expHT_Loop(B, E, CurrT, Ans):-
	E > 1,
	E mod 2 =:= 1,
	E2 is E // 2,
	CurrT2 is CurrT * CurrT * B,
	expHT_Loop(B, E2, CurrT2, Ans).
	
	