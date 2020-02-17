% author: Adam Knox
% nsid: ark043
% CMPT 340
% assignment 2
% questions 3

% Synopsis: Practice implementing lists in prolog functions

%%%%%%%%%%%%%%%%%%%%%%
% member(+X,+L) 
% X is a member of list L
%%%%%%%%%%%%%%%%%%%%%%
member(X,[X|_]). 
member(X,[_|L]) :-
	member(X,L).

%%%%%%%%%%%%%%%%%%%%%%
% append(+L1, +L2, -Both) 
% Both is L2 joined to the end of L1
%%%%%%%%%%%%%%%%%%%%%%
append([], L2, L2). 
append([X|Xs], L2, [X|Rest]) :-
	append(Xs, L2, Rest).

%%%%%%%%%%%%%%%%%%%%%%
% replace(Key, Val, List, Ans)
% replaces the value associated with Key to be Val
% Ans is the updated list
%%%%%%%%%%%%%%%%%%%%%%
replace(Key, Val, [(K,V)|Xs], Ans) :-
	K == Key,
	append([(Key, Val)], Xs, Ans);
	replace(Key, Val, Xs, Ans2),
	append([(K,V)], Ans2, Ans).




%%%%%%%%%%%%%%%%%%%%%%
% lookup(Key, List, Ans)
% looks for the key Key inside the list
% Ans is the value associated with Key
% This version does not use member
%%%%%%%%%%%%%%%%%%%%%%
lookup(Key, [(K,V)|Xs], Ans) :-
	K == Key,
	Ans is V;
	lookup(Key, Xs, Ans).
	
	
	
	
%%%%%%%%%%%%%%%%%%%%%%
% lookup2(Key, List, Ans)
% looks for the key Key inside the list
% Ans is the value associated with Key
% This version uses member
%%%%%%%%%%%%%%%%%%%%%%
lookup2(Key, X, Ans) :-
	member((Key, Ans), X).
	
	
	
	
%%%%%%%%%%%%%%%%%%%%%%
% zip(L1, L2, Assoc)
% associates values in L1 with values in L2
% Assoc is the new list of associations
%%%%%%%%%%%%%%%%%%%%%%
zip([],[],[]).
zip([I1|X1s], [I2|X2s], Ass) :-
	zip(X1s, X2s, Ass2),
	Ass = [(I1, I2)|Ass2].




%%%%%%%%%%%%%%%%%%%%%%
% update(Key, Val, List, New)
% updates the list of associations to either update the value associated
% with Key to be the new value Val, or appends (Key, Val) to the list if
% Key is not yet in the list.
% New: The updated list
%%%%%%%%%%%%%%%%%%%%%%
update(Key, Val, [], New) :-
	New = [(Key, Val)].

update(Key, Val, X, New) :-
	replace(Key, Val, X, New);
	append(X, [(Key, Val)], New).





