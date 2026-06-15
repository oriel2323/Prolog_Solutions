%Israel Shteinberg
%ID:215270265

% 3.a)

% error case: both inputs must be lists.
intersection(L1, L2, _) :-
    ( \+ is_list(L1) ; \+ is_list(L2) ),
    write('Error: L1 and L2 must be lists.'), nl,
    fail.

% base case: intersection with an empty list is empty.
intersection([], _, []).

% if H appears in L2, keep it in the answer.
intersection([H|T], L2, [H|Z]) :-
    member(H, L2),
    intersection(T, L2, Z).

% if H does not appear in L2, skip it.
intersection([H|T], L2, Z) :-
    \+ member(H, L2),
    intersection(T, L2, Z).


% 3.b)

% error case: both inputs must be lists.
minus(L1, L2, _) :-
    ( \+ is_list(L1) ; \+ is_list(L2) ),
    write('Error: L1 and L2 must be lists.'), nl,
    fail.

% base case: empty list minus any list is empty.
minus([], _, []).

% if H appears in L2, remove it from the answer.
minus([H|T], L2, Z) :-
    member(H, L2),
    minus(T, L2, Z).

% if H does not appear in L2, keep it.
minus([H|T], L2, [H|Z]) :-
    \+ member(H, L2),
    minus(T, L2, Z).


% 4.a)

% error case: L must be a list.
subset(_, L) :-
    \+ is_list(L),
    write('Error: L must be a list.'), nl,
    fail.

% base case: the only subset of an empty list is the empty list.
subset([], []).

% option 1: do not take the head.
subset(S, [_|T]) :-
    subset(S, T).

% option 2: take the head.
subset([H|S], [H|T]) :-
    subset(S, T).


% 4.b)

% sum of an empty list is 0.
sum_list_my([], 0).

% recursive step: sum is head plus sum of tail.
sum_list_my([H|T], Sum) :-
    number(H),
    sum_list_my(T, Temp),
    Sum is H + Temp.

% error case: List must be a list and Sum must be a number.
subsum(List, Sum, _) :-
    ( \+ is_list(List) ; \+ number(Sum) ),
    write('Error: List must be a list and Sum must be a number.'), nl,
    fail.

% generate a subset and check if its sum equals Sum.
subsum(List, Sum, SubSet) :-
    subset(SubSet, List),
    sum_list_my(SubSet, Sum).

% same predicate name as in the example.
subSum(List, Sum, SubSet) :-
    subsum(List, Sum, SubSet).