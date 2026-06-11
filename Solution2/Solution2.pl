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
    
% 4)

% X appears at least twice if X is the head
% and X also appears somewhere in the tail.
my_member2(X, [X|T]) :-
    my_member(X, T).

% otherwise, continue searching in the tail.
my_member2(X, [_|T]) :-
    my_member2(X, T).


% 5)

% empty list is a palindrome.
my_palindrom([]).

% list with one element is a palindrome.
my_palindrom([_]).

% A list is a palindrome if the first and last elements are equal,
% and the middle part is also a palindrome.
my_palindrom([H|T]) :-
    append(Middle, [H], T),
    my_palindrom(Middle).


% 6)

% empty list is sorted.
my_sorted([]).

% list with one element is sorted.
my_sorted([_]).

% A list is sorted if the first element is smaller or equal to the second,
% and the tail is also sorted.
my_sorted([X, Y | T]) :-
    X =< Y,
    my_sorted([Y|T]).


% 7)

% If the list is empty, insert X as the only element.
my_insert(X, [], [X]).

% If X should come before the head, place it there.
my_insert(X, [H|T], [X,H|T]) :-
    X =< H.

% Otherwise, keep the head and insert X into the tail.
my_insert(X, [H|T], [H|Z]) :-
    X > H,
    my_insert(X, T, Z).
