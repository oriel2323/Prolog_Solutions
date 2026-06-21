% Name: Israel Shteinberg      ID: 215270265
% Name: Oriel Borgharkar       ID: 337732739 


% 1) 

% Base case:
% When only three elements are left, they are the last three elements.
three_last([X, Y, Z], X, Y, Z).

% Recursive case:
% Ignore the first element and continue with the rest of the list.
three_last([_ | Tail], X, Y, Z) :-
    three_last(Tail, X, Y, Z).

% This is tail recursion.
% The recursive call is the last operation in the rule.


% 2)


%------------------------------------------

%non tail recursion 


% Base case:
% When the first list is empty, the union is the second list.
union([], L2, L2).

% If X already exists in L2, do not add it again.
union([X | L1], L2, L3) :-
    member(X, L2),
    !,
    union(L1, L2, L3).

% The cut is red:
% Without it, Prolog could also try the next rule
% and add X even though it already exists in L2.


% If X does not exist in L2, add it to the result.
union([X | L1], L2, [X | L3]) :-
    union(L1, L2, L3).


%------------------------------------------


%tail recursion 

% The recursive call is the last operation,
% so this is tail recursion.

% This predicate starts the process with L2 as the accumulator.
union_tail(L1, L2, L3) :-
    union_acc(L1, L2, L3).

% Base case:
% When L1 is empty, the accumulator is the final union.
union_acc([], Acc, Acc).

% If X already exists in the accumulator, do not add it again.
union_acc([X | L1], Acc, L3) :-
    member(X, Acc),
    !,
    union_acc(L1, Acc, L3).

% The cut is red:
% Without it, Prolog may also try the next rule
% and add X even when it already exists.

% If X does not exist in the accumulator, add it to the accumulator.
union_acc([X | L1], Acc, L3) :-
    union_acc(L1, [X | Acc], L3).




% 3) 

% Regular Recursion

% Base case:
% An empty list returns an empty list.
kuku([], []).

% Recursive case:
% Convert X to [X, 2X] and place it after the rest.
kuku([X | L1], L2) :-
    kuku(L1, Rest),
    DoubleX is 2 * X,
    append(Rest, [[X, DoubleX]], L2).


%------------------------------------------


% Tail Recursion

% Start with an empty accumulator.
kuku_tail(L1, L2) :-
    kuku_acc(L1, [], L2).

% Base case:
% When the list is empty, the accumulator is the result.
kuku_acc([], Acc, Acc).

% Convert X to [X, 2*X] and add it to the accumulator.
kuku_acc([X | L1], Acc, L2) :-
    DoubleX is 2 * X,
    kuku_acc(L1, [[X, DoubleX] | Acc], L2).

% The recursive call is the last operation,
% so this is tail recursion.


%------------------------------------------

% Regular Recursion for Nested Lists

% Base case:
% An empty list returns an empty list.
kuku_nested([], []).

% If X is a number, convert it to [X, 2*X].
kuku_nested([X | L1], L2) :-
    number(X),
    kuku_nested(L1, Rest),
    DoubleX is 2 * X,
    append(Rest, [[X, DoubleX]], L2).

% If X is a list, handle the nested list recursively.
kuku_nested([X | L1], L2) :-
    is_list(X),
    kuku_nested(X, NewX),
    kuku_nested(L1, Rest),
    append(Rest, [NewX], L2).


