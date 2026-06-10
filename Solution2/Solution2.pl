% Name: Israel Shteinberg      ID: 215270265
% Name: Oriel Borgharkar       ID: 337732739

% 1)

% base case an empty list reversed is still an empty list.
my_reverse([],[]). 

% Recursive Step Split the list into Head and Tail.
my_reverse([H|T], R) :-
    my_reverse(T,Treversed),
    append(Treversed,[H],R).
    

% 2) 

% empty list is a prefix of every list
my_prefix([],_).

% heads must be equal, then check tails
my_prefix([H|T1],[H|T2]) :-
    my_prefix(T1,T2). 

% 3) 

% X is the head of the list
my_member(X,[X|_]).

% otherwise, search X in the tail
my_member(X,[_|T]) :-
    my_member(X,T). 