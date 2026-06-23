% Name: Israel Shteinberg      ID: 215270265
% Name: Oriel Borgharkar       ID: 337732739


% 1)

% Version A: no cuts.

% if X is smaller or equal to Y, X is the min and Y is the max.
min_max(X, Y, X, Y) :-
    X =< Y.

% otherwise, Y is the min and X is the max.
min_max(X, Y, Y, X) :-
    X > Y.


% Version B: green cut.

% if X is smaller or equal to Y, there is no need to check the next rule.
min_max_green(X, Y, X, Y) :-
    X =< Y,
    !.

% otherwise, Y is the min and X is the max.
min_max_green(X, Y, Y, X) :-
    X > Y.

% Green cut:
% the cut only prevents useless backtracking.


% Version C: red cut.

% if X is smaller or equal to Y, commit to this answer.
min_max_red(X, Y, X, Y) :-
    X =< Y,
    !.

% otherwise, Y is the min and X is the max.
min_max_red(X, Y, Y, X).

% Red cut:
% the second rule depends on the cut in the first rule.


% 2)

% !1 : Useless
% it appears before any real choice is made.

% !2 : Red
% it commits to the first car before checking the price.
% alpha costs 1100, so Prolog cannot go back and try subaru.

% !3 : Red
% it commits to the first car-price option before checking Z < 1000.
% because of that, Prolog cannot try another car.

% !4 : Useless
% it appears after the important checks are already done.

% !5 : Red
% it prevents car/1 from checking the next car.

% !6 : Useless
% subaru is already the last car fact.

% !7 : Useless
% it only cuts choices inside price/2.
% it does not stop buy/2 from going back to car(subaru).

% !8 : Useless
% subaru price is already the last price fact.


% 3)

% if there is a common element, fail.
disjoin(L1, L2) :-
    member(X, L1),
    member(X, L2),
    !,
    fail.

% Red cut:
% without it, Prolog could continue to the next rule and return true.

% if no common element was found, the lists are disjoint.
disjoin(_, _).


% 4)

% base case: merging an empty list with L gives L.
merge1([], L, L).

% base case: merging L with an empty list gives L.
merge1(L, [], L).

% if X is smaller or equal to Y, take X first.
merge1([X|T1], [Y|T2], [X|M]) :-
    X =< Y,
    !,
    merge1(T1, [Y|T2], M).

% otherwise, take Y first.
merge1([X|T1], [Y|T2], [Y|M]) :-
    merge1([X|T1], T2, M).

% Green cut:
% after X =< Y succeeds, there is no need to check the second rule.


% same predicate with the name merge.
merge(L1, L2, M) :-
    merge1(L1, L2, M).


% 5)

% base case: an empty list is already sorted.
mergesort([], []).

% base case: a list with one element is already sorted.
mergesort([X], [X]).

% recursive step: split the list, sort both parts, then merge them.
mergesort(L, LM) :-
    split_list(L, L1, L2),
    mergesort(L1, S1),
    mergesort(L2, S2),
    merge1(S1, S2, LM).


% split an empty list into two empty lists.
split_list([], [], []).

% split a list with one element.
split_list([X], [X], []).

% recursive step: put one element in each side.
split_list([X,Y|T], [X|T1], [Y|T2]) :-
    split_list(T, T1, T2).
