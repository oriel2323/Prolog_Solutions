% Name: Israel Shteinberg      ID: 215270265
% Name: Oriel Borgharkar       ID: 337732739


% 1)

% Version A: No cuts
min_max(X, Y, X, Y) :- X =< Y.
min_max(X, Y, Y, X) :- X > Y.

% Version B: Green cut (Optimization only)
min_max(X, Y, X, Y) :- X =< Y, !.
min_max(X, Y, Y, X) :- X > Y.

% Version C: Red cut (Changes the logic)
min_max(X, Y, X, Y) :- X =< Y, !.
min_max(X, Y, Y, X).


% 2)

% !1 : Useless
% It appears before any choice point or variable binding is made,
% so there is nothing for it to cut.

% !2 : Red
% It commits to the first car found, alpha, before checking whether
% its price is below 1000. Since alpha costs 1100, Prolog cannot
% backtrack and try subaru, which costs 990.

% !3 : Red
% It commits to the first car-price combination: alpha and 1100.
% When Z < 1000 fails, Prolog cannot backtrack to subaru and 990.

% !4 : Useless
% By the time Prolog reaches this cut, subaru is already the last car
% fact and 990 is already the last price fact.

% !5 : Red
% It prevents car/1 from backtracking from car(alpha) to car(subaru).

% !6 : Useless
% Subaru is already the last fact of car/1.

% !7 : Red
% It prevents price/2 from backtracking from price(alpha,1100)
% to price(subaru,990).

% !8 : Useless
% There are no price facts after Subaru's price.


% 3)

% A common element exists in both lists.
disjoin(L1, L2) :-
    member(X, L1),
    member(X, L2),
    !,
    fail.

% Red cut: without it, Prolog would continue to the next rule
% and return true even when the lists have a common element.

% No common element was found, so the lists are disjoint.
disjoin(_, _).