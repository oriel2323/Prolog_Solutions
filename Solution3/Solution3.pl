% ==========================================
% שאלה 1.א
% ==========================================

% Main predicate: checks validation before calculating
scum(N, Res) :- 
    % Check if N > 1 (and stop backtracking if true)
    N > 1, !,                
    calculate_scum(N, Res). 

% Error handling: if N is not greater than 1
scum(N, _) :-
    N =< 1,
    write('Error: Input N must be greater than 1.'), nl,
    fail.                     

% Base case: sum from 1 to 2 is 3 (since N > 1, the smallest valid base is 2)
calculate_scum(2, 3) :- !.

% Recursive case
calculate_scum(N, Res) :-
    NextN is N - 1,
    % Recursive call with N-1
    calculate_scum(NextN, SubRes), 
    % Add current N to the subtotal
    Res is SubRes + N.             


% ==========================================
% שאלה 1.ב
% ==========================================

sumDigits(Num,Sum) :- 
    Num >= 0, !,
    calculate_digits_sum(Num,Sum). % Fixed to match the predicate name below

% Error handling: if Num is negative
sumDigits(Num, _) :-
    Num < 0,
    write('Error: Input Num must be greater than or equal to 0.'), nl,
    fail.                    

% Base case: the sum of digits for 0 is 0
calculate_digits_sum(0, 0) :- !.

% Recursive case
calculate_digits_sum(Num, Sum) :-
    Num > 0,
    % Get the rightmost digit
    CurrentDigit is Num mod 10,   
    % Remove the rightmost digit    
    RemainingNum is Num // 10,        
    % Recursive call with the rest of the number
    calculate_digits_sum(RemainingNum, SubSum),
    % Add current digit to the subtotal.
    Sum is SubSum + CurrentDigit.     


% ==========================================
% שאלה 2.א
% ==========================================

split(N,Res) :- 
    N >= 0 , ! ,
    calculate_split(N, Res).

% Error handling: if N is negative
split(N, _) :-
    N < 0,
    write('Error: Input N must be greater than or equal to 0.'), nl,
    fail.

% --- All calculate_split clauses are now TOGETHER to fix the warning ---
% Special case: if the initial number is 0, return [0]
calculate_split(0, [0]) :- !.

% Helper to trigger the recursive extraction for numbers > 0
calculate_split(N, Res) :-
    N > 0,
    get_digits(N, Res).
% ---------------------------------------------------------------------

% Base case for recursion: when we finish breaking down a positive number
get_digits(0, []) :- !.

% Recursive case to extract digits
get_digits(Num, Res) :-
    Num > 0,
    % Get the last digit
    CurrentDigit is Num mod 10,  
    % Remove the last digit        
    RemainingNum is Num // 10, 
    % Recursive call with the rest          
    get_digits(RemainingNum, SubRes),    
    % Append current digit to the END of the list
    append(SubRes, [CurrentDigit], Res). 


% ==========================================
% שאלה 2.ב
% ==========================================

create(List,N) :- 
    % Ensure all elements are valid digits
    validate_digits(List), !,        
    calculate_create(List, N).

% Error handling: if the list contains invalid digits
create(_, _) :-
    write('Error: Input list must contain digits between 0 and 9 only.'), nl,
    fail.

% Helper predicate to validate that all items in the list are digits between 0 and 9
validate_digits([]).
validate_digits([H|T]) :-
    integer(H), H >= 0, H =< 9,
    validate_digits(T).

% Base case for calculation: an empty list results in the number 0
calculate_create([], 0) :- !.

% Recursive case
calculate_create([Head|Tail], N) :-
    % Solve the sub-problem for the rest of the list
    calculate_create(Tail, SubN), 
    % Shift sub-result to the left and add current digit   
    N is (SubN * 10) + Head.         


% ==========================================
% שאלה 2.ג
% ==========================================

reverseNumber(Num, RevNum) :-
     % Check if input is valid (>= 0)
    Num >= 0, !,          
    % Step 1: Break number into [5, 8, 4]           
    split(Num, DigitList),         
    % Step 2: Reassemble as [5->ones, 8->tens, 4->hundreds] -> 485   
    create(DigitList, RevNum).        

% Error handling: if the input number is negative
reverseNumber(Num, _) :-
    Num < 0,
    write('Error: Input number must be greater than or equal to 0.'), nl,
    fail.


% ==========================================
% שאלה 3.א
% ==========================================

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


% ==========================================
% שאלה 3.ב
% ==========================================

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


% ==========================================
% שאלה 4.א
% ==========================================

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


% ==========================================
% שאלה 4.ב
% ==========================================

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