% Name: Israel Shteinberg      ID: 215270265
% Name: Oriel Borgharkar       ID: 337732739


% 1)

% base case: when only three elements are left,
% they are the last three elements.
three_last([X, Y, Z], X, Y, Z).

% recursive step: ignore the first element and continue.
three_last([_ | Tail], X, Y, Z) :-
    three_last(Tail, X, Y, Z).

% This is tail recursion:
% the recursive call is the last operation in the rule.


% 2)

% regular recursion - union.

% base case: union of an empty list with L2 is L2.
union([], L2, L2).

% recursive step: first solve the union of the tail.
union([X | L1], L2, L3) :-
    union(L1, L2, Temp),
    member(X, Temp),
    !,
    L3 = Temp.

% Green cut:
% after X is already in Temp, there is no need to try adding it again.

% if X is not in Temp, add it to the result.
union([X | L1], L2, [X | Temp]) :-
    union(L1, L2, Temp).


% tail recursion - union.

% start with L2 as the accumulator.
union_tail(L1, L2, L3) :-
    union_acc(L1, L2, L3).

% base case: when L1 is empty, the accumulator is the answer.
union_acc([], Acc, Acc).

% if X already exists in the accumulator, skip it.
union_acc([X | L1], Acc, L3) :-
    member(X, Acc),
    !,
    union_acc(L1, Acc, L3).

% Green cut:
% after X is already in Acc, there is no need to try adding it.

% if X does not exist in the accumulator, add it.
union_acc([X | L1], Acc, L3) :-
    union_acc(L1, [X | Acc], L3).


% 3)

% regular recursion.

% base case: an empty list returns an empty list.
kuku([], []).

% recursive step: convert X to [X, 2X] and put it after the rest.
kuku([X | L1], L2) :-
    kuku(L1, Rest),
    DoubleX is 2 * X,
    append(Rest, [[X, DoubleX]], L2).


% tail recursion.

% start with an empty accumulator.
kuku_tail(L1, L2) :-
    kuku_acc(L1, [], L2).

% base case: when the list is empty, the accumulator is the answer.
kuku_acc([], Acc, Acc).

% recursive step: add [X, 2X] to the accumulator.
kuku_acc([X | L1], Acc, L2) :-
    DoubleX is 2 * X,
    kuku_acc(L1, [[X, DoubleX] | Acc], L2).


% regular recursion for nested lists.

% base case: an empty list returns an empty list.
kuku_nested([], []).

% if X is a number, convert it to [X, 2X].
kuku_nested([X | L1], L2) :-
    number(X),
    !,
    kuku_nested(L1, Rest),
    DoubleX is 2 * X,
    append(Rest, [[X, DoubleX]], L2).

% Green cut:
% after X is known to be a number, it cannot be a list.

% if X is a list, handle it recursively.
kuku_nested([X | L1], L2) :-
    is_list(X),
    kuku_nested(X, NewX),
    kuku_nested(L1, Rest),
    append(Rest, [NewX], L2).


% 4)

% regular recursion - flattenList.

% base case: an empty list is already flat.
flattenList([], []).

% if the head is a list, flatten it and also flatten the tail.
flattenList([X | T], Flat) :-
    is_list(X),
    !,
    flattenList(X, FlatX),
    flattenList(T, FlatT),
    append(FlatX, FlatT, Flat).

% Green cut:
% after X is known to be a list, there is no need to check it as an atom.

% if the head is not a list, keep it.
flattenList([X | T], [X | FlatT]) :-
    flattenList(T, FlatT).


% tail recursion - flattenList.

% start with an empty accumulator.
flattenList_tail(L, Flat) :-
    flatten_acc(L, [], Flat).

% base case: when the list is empty, reverse the accumulator.
flatten_acc([], Acc, Flat) :-
    reverse(Acc, Flat).

% if the head is a list, flatten it first.
flatten_acc([X | T], Acc, Flat) :-
    is_list(X),
    !,
    flatten_acc(X, Acc, NewAcc),
    flatten_acc(T, NewAcc, Flat).

% Green cut:
% after X is known to be a list, there is no need to check it as an atom.

% if the head is not a list, add it to the accumulator.
flatten_acc([X | T], Acc, Flat) :-
    flatten_acc(T, [X | Acc], Flat).


% 5)

% base case: deep reverse of an empty list is empty.
deepReverse([], []).

% if the head is a list, reverse it deeply.
deepReverse([X | T], R) :-
    is_list(X),
    !,
    deepReverse(X, RX),
    deepReverse(T, RT),
    append(RT, [RX], R).

% Green cut:
% after X is known to be a list, there is no need to treat it as an atom.

% if the head is not a list, put it at the end.
deepReverse([X | T], R) :-
    deepReverse(T, RT),
    append(RT, [X], R).
