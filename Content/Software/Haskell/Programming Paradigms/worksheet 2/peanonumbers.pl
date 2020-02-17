% this file shows how to represent 
% constants in your Prolog programs.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% technique 1: each constant is
% given its own unique property name
% give as many as you want

zero(0).
one(s(0)).
two(s(s(0))).
three(s(s(s(0)))).
four(s(s(s(s(0))))).

% How to use:
% ?- two(X), three(Y), greaterThan(X,Y).
% This example uses the facts to
% unify X and Y to Peano numbers,
% which are then passed to
% greaterThan/2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% technique 2:
% have a special relation for
% related constants
% give as many as you want

peanoNumber(zero,0).
peanoNumber(one,s(0)).
peanoNumber(two,s(s(0))).
peanoNumber(three,s(s(s(0)))).
peanoNumber(four,s(s(s(s(0))))).

% How to use:
% ?- peanoNumber(two,X), peanoNumber(three,Y), greaterThan(X,Y).
% similar to the above, only more
% verbose.  The advantage is that you
% can use zero/1 for some other
% purpose, if you need to.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for Peano numbers, it might be
% simpler to have a program to convert
% from integers to Peano number and
% back.  It's a good exercise.

% toPeano(+N,-P)
% convert integer N to Peano P

% exercise

% fromPeano(+P, -N)
% convert from Peano number P to
% integer N

% exercise

% eof
