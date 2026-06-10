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

