% author: Adam Knox
% nsid: ark043
% CMPT 340
% assignment 2
% questions 2

% Synopsis: reimplement a number of functions using peano natural numbers


%%%%%%%%%%%%%%%%%%%%%%
% subtraction(+X,+Y, -Z)
% X, Y, and Z are natural peano numbers
% X - Y = Z
%%%%%%%%%%%%%%%%%%%%%%
subtraction(X, 0, X).
subtraction(s(X), s(Y), Z) :-
	subtraction(X, Y, Z).
	
%%%%%%%%%%%%%%%%%%%%%%
% add(+X,+Y, -Z)
% X, Y, and Z are natural peano numbers
% X + Y = Z
%%%%%%%%%%%%%%%%%%%%%%
add(0, X, X). 
add(s(X), Y, Z) :-
	add(X, s(Y), Z).

%%%%%%%%%%%%%%%%%%%%%%
% multiply(+X,+Y, -Z)
% X, Y, and Z are natural peano numbers
% X * Y = Z
%%%%%%%%%%%%%%%%%%%%%%
multiply(0, _, 0).
multiply(s(X),Y,Z) :-
	multiply(X,Y,Q), 
	add(Y,Q,Z).

%%%%%%%%%%%%%%%%%%%%%%
% greaterThanOrEqual(+X,+Y)
% X >= Y for Natural numbers X, Y
%%%%%%%%%%%%%%%%%%%%%%
greaterThanOrEqual(X, Y) :-
	subtraction(X, Y, _).
	



%%%%%%%%%%%%%%%%%%%%%%
% greaterThan(+X,+Y)
% X > Y for Natural numbers X, Y
%%%%%%%%%%%%%%%%%%%%%%
greaterThan(s(X), Y) :-
	subtraction(X, Y, _).
	



%%%%%%%%%%%%%%%%%%%%%%
% divide(+Num,+Den,-Q,-R)
% Q is the quotient of Num / Den
% R is the remainder
% Does a natural number division of the numerator by the denominator
%%%%%%%%%%%%%%%%%%%%%%
	
% Base Case: Can no longer pull the denominator from the numerator, so get remainder
divide(Num, Den, Q, R) :-
	greaterThanOrEqual(Num, 0),
	greaterThan(Den, 0),
	greaterThan(Den, Num),
	add(Num, 0, R),
	Q = 0.

% Recursive Case: Pull the denominator from the numinator until not possible to find the quotient
divide(Num, Den, Q, R) :-
	greaterThanOrEqual(Num, 0),
	greaterThan(Den, 0),
	greaterThanOrEqual(Num, Den),	
	subtraction(Num, Den, Num2),
	divide(Num2, Den, Q2, R),
	add(Q2, s(0), Q).
		
	
	

%%%%%%%%%%%%%%%%%%%%%%
% exp(+B,+E,-Ans)
% Base: B >= 0
% Exponent: E >= 0
% Answer: Ans
% Finds B**E using tail recursion, and divides the question in half at each step to get O(logN). uses peano numbers
%%%%%%%%%%%%%%%%%%%%%%
% Interface Base Case
exp(B, 0, Ans):-
	greaterThan(B, 0),
	add(0, s(0), Ans);
	greaterThan(0, B),
	add(0, s(0), Ans).

% User Interface
exp(B, E, Ans):-
	exp_Loop(B, E, B, Ans).
	
% Base Case
exp_Loop(B, s(0), T, T).

% Recursive Case where the exponent is even
exp_Loop(B, E, CurrT, Ans):-
	greaterThan(E, s(0)),
	divide(E, s(s(0)), E2, 0),
	multiply(CurrT, CurrT, CurrT2),
	exp_Loop(B, E2, CurrT2, Ans).
	

% Recursive Case where the exponent is odd
exp_Loop(B, E, CurrT, Ans):-
	greaterThan(E, s(0)),
	divide(E, s(s(0)), E2, s(0)),
	multiply(CurrT, CurrT, CurrT2),
	multiply(CurrT2, B, CurrT3),
	exp_Loop(B, E2, CurrT3, Ans).


