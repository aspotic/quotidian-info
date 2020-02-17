% author: Adam Knox
% nsid: ark043
% CMPT 340
% assignment 2
% questions 4

% Synopsis: Binary Search Tree operations including insertBST, removeBST, mergeBST, and deleteMax


%%%%%%%%%%%%%%%%%%%%%%
% insertBST(+Tree1, +Key, -Tree2)
% Key: The key to insert into the tree
% Tree1: The tree to insert Key into
% Tree2: The new version of Tree1 that contains Key
% Inserts a key into a binary search tree
%%%%%%%%%%%%%%%%%%%%%%
% Base Case
insertBST(empty, Key, Tree2) :-
	Tree2 = tree(Key, empty, empty).

% Case 1: Smaller than Key
% Case 1 Base
insertBST(tree(K, empty, RTree), Key, Tree2) :-
	Key < K,
	Tree2 = tree(K, tree(Key, empty, empty), RTree).

% Case 1 Recursive
insertBST(tree(K, LTree, RTree), Key, Tree2) :-
	Key < K,
	insertBST(LTree, Key, Tree3),
	Tree2 = tree(K, Tree3, RTree).
	

% Case 2: Larger than Key
% Case 2 Base
insertBST(tree(K, LTree, empty), Key, Tree2) :-
	Key > K,
	Tree2 = tree(K, LTree, tree(Key, empty, empty)).

% Case 2 Recursive
insertBST(tree(K, LTree, RTree), Key, Tree2) :-
	Key > K,
	insertBST(RTree, Key, Tree3),
	Tree2 = tree(K, LTree, Tree3).
	
	
	

%%%%%%%%%%%%%%%%%%%%%%
% deleteMax(+Tree1, -Key, -Tree2)
% Key: The key that was removed
% Tree1: The tree to remove the largest key from
% Tree2: The new version of Tree1 without the removed key
% deletes the largest key from the binary search tree
%%%%%%%%%%%%%%%%%%%%%%
deleteMax(tree(K, LTree, RTree), Key, Tree2) :-
	RTree == empty,
	Key = K,
	Tree2 = empty;
	deleteMax(RTree, Key, Tree3),
	Tree2 = tree(K, LTree, Tree3).



%%%%%%%%%%%%%%%%%%%%%%
% mergeBST(+PickedTree, +SubTree, -Combo)
% PickedTree: The key to insert the subtree into
% SubTree: The tree to insert
% Combo: The merged combination of PickedTree an SubTree
% Takes two BSTs and merges them
%%%%%%%%%%%%%%%%%%%%%%
mergeBST(PickedTree, empty, PickedTree).
mergeBST(PickedTree, SubTree, Combo) :-
	deleteMax(SubTree, Key, NewSubTree),
	insertBST(PickedTree, Key, NewPickedTree),
	mergeBST(NewPickedTree, NewSubTree, Combo).
	

	
%%%%%%%%%%%%%%%%%%%%%%
% removeBST(+Tree1, +Key, -Tree2)
% Key: The key to remove from the binary search tree
% Tree1: The tree to remove the key from
% Tree2: The new version of Tree1 without the removed key
%%%%%%%%%%%%%%%%%%%%%%
removeBST(tree(K, LTree, RTree), Key, Tree2) :-
	removeBST_L(tree(K, LTree, RTree), Key, PickedTree, LSubTree, RSubTree),
	mergeBST(PickedTree, LSubTree, TempTree),
	mergeBST(TempTree, RSubTree, Tree2).

% Case 1: Smaller than Key
removeBST_L(tree(K, LTree, RTree), Key, Tree2, LSubTree, RSubTree) :-
	Key < K,
	removeBST_L(LTree, Key, Tree3, LSubTree, RSubTree),
	Tree2 = tree(K, Tree3, RTree).

% Case 2: Larger than Key
removeBST_L(tree(K, LTree, RTree), Key, Tree2, LSubTree, RSubTree) :-
	Key > K,
	removeBST_L(RTree, Key, Tree3, LSubTree, RSubTree),
	Tree2 = tree(K, LTree, Tree3).

% Case 3: Found the Key
removeBST_L(tree(K, LTree, RTree), K, empty, LTree, RTree).
	

