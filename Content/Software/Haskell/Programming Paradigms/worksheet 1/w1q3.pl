% author: Adam Knox
% nsid: ark043
% CMPT 340
% assignment 1
% questions 3

% Synopsis: a quotient & remainder are discovered using only addition and subtraction


%%%%%%%%%%%%%%%%%%%%%%
% tail recursive version
%%%%%%%%%%%%%%%%%%%%%%
% divide(+Num, +Den, -Q, -R)
% Numerator: Num >= 0
% Denominator: Den > 0
% Quotient: Q
% Remainder: R
% divides the numerator by the denominator, and returns the quotient and remainder
%%%%%%%%%%%%%%%%%%%%%%

% Pretty user interface
divideT(Num, Den, Q, R) :-
	divideT_loop(Num, Den, 0, Q, R).

% Base Case: Can no longer pull the denominator from the numerator, so get remainder
divideT_loop(Num, Den, CurrQ, Q, R) :-
	Num >= 0,
	Den > 0,
	Den > Num,
	R is Num,
	Q is CurrQ.

% Recursive Case: Pull the denominator from the numinator until not possible to find the quotient
divideT_loop(Num, Den, CurrQ, Q, R) :-
	Num >= 0,
	Den > 0,
	Num >= Den,	
	Num2 is Num - Den,
	CurrQ2 is CurrQ + 1,
	divideT_loop(Num2, Den, CurrQ2, Q, R).
%%%%%%%%%%%%%%%%%%%%%%







%%%%%%%%%%%%%%%%%%%%%%
% recursive version
%%%%%%%%%%%%%%%%%%%%%%
% divide(+Num, +Den, -Q, -R)
% Numerator: Num >= 0
% Denominator: Den > 0
% Quotient: Q
% Remainder: R
% divides the numerator by the denominator, and returns the quotient and remainder
%%%%%%%%%%%%%%%%%%%%%%

% Base Case: Can no longer pull the denominator from the numerator, so get remainder
divide(Num, Den, Q, R) :-
	Num >= 0,
	Den > 0,
	Den > Num,
	R is Num,
	Q = 0.

% Recursive Case: Pull the denominator from the numinator until not possible to find the quotient
divide(Num, Den, Q, R) :-
	Num >= 0,
	Den > 0,
	Num >= Den,	
	Num2 is Num - Den,
	divide(Num2, Den, Q2, R),
	Q is Q2 + 1.
%%%%%%%%%%%%%%%%%%%%%%
