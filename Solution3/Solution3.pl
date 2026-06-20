% Name: Israel Shteinberg      ID: 215270265
% Name: Oriel Borgharkar       ID: 337732739


% 1.a)

% error case: N must be an integer greater than 1.
scum(N, _) :-
    ( \+ integer(N) ; N =< 1 ),
    write('Error: N must be an integer greater than 1.'), nl,
    fail.

% base case: the sum from 1 to 2 is 3.
scum(2, 3).

% recursive step: sum from 1 to N is N plus sum from 1 to N-1.
scum(N, Res) :-
    N > 2,
    N1 is N - 1,
    scum(N1, Temp),
    Res is Temp + N.


% 1.b)

% error case: Num must be a non-negative integer.
sumDigits(Num, _) :-
    ( \+ integer(Num) ; Num < 0 ),
    write('Error: Num must be an integer greater than or equal to 0.'), nl,
    fail.

% base case: the sum of digits of 0 is 0.
sumDigits(0, 0).

% recursive step: add the last digit to the sum of the rest.
sumDigits(Num, Sum) :-
    Num > 0,
    Digit is Num mod 10,
    Rest is Num // 10,
    sumDigits(Rest, Temp),
    Sum is Temp + Digit.


% 2.a)

% error case: N must be a non-negative integer.
split(N, _) :-
    ( \+ integer(N) ; N < 0 ),
    write('Error: N must be an integer greater than or equal to 0.'), nl,
    fail.

% base case: zero becomes a list with zero.
split(0, [0]).

% split a positive number into its digits.
split(N, Res) :-
    N > 0,
    split_helper(N, Res).

% base case: no more digits left.
split_helper(0, []).

% recursive step: take the last digit and add it to the end.
split_helper(N, Res) :-
    N > 0,
    Digit is N mod 10,
    Rest is N // 10,
    split_helper(Rest, Temp),
    append(Temp, [Digit], Res).


% 2.b)

% empty list is a valid list of digits.
digits_list([]).

% each element must be a digit between 0 and 9.
digits_list([H|T]) :-
    integer(H),
    H >= 0,
    H =< 9,
    digits_list(T).

% error case: List must contain only digits.
create(List, _) :-
    ( \+ is_list(List) ; \+ digits_list(List) ),
    write('Error: List must be a list of digits between 0 and 9.'), nl,
    fail.

% create a number from the list.
create(List, N) :-
    create_helper(List, N).

% base case: empty list creates 0.
create_helper([], 0).

% recursive step: the left digit is the units digit.
create_helper([H|T], N) :-
    create_helper(T, Temp),
    N is Temp * 10 + H.


% 2.c)

% error case: Num must be a non-negative integer.
reverseNumber(Num, _) :-
    ( \+ integer(Num) ; Num < 0 ),
    write('Error: Num must be an integer greater than or equal to 0.'), nl,
    fail.

% split the number and create it back in reverse order.
reverseNumber(Num, RevNum) :-
    split(Num, Digits),
    create(Digits, RevNum).


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