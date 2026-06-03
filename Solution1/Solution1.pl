% Name: Israel Shteinberg      ID: 215270265
% Name: Oriel Borgharkar       ID: 337732739 

:- [data1].

%1 - father
father(X,Y) :- parent(X,Y),male(X). 
%2 - mother
mother(X,Y) :- parent(X,Y),female(X).
%3 - son 
son(X,Y) :- parent(Y,X),male(X).
%4 - daughter
daughter(X,Y) :- parent(Y,X),female(X).
%5 - grandfather
grandfather(X,Y) :- parent(X,Z), parent(Z,Y), male(X).
%6 - grandmother
grandmother(X,Y) :- parent(X,Z), parent(Z,Y), female(X).
%7 - grandson
grandson(X,Y) :- parent(Z,X), parent(Y,Z) , male(X).
%8 - granddaughter
granddaughter(X,Y) :- parent(Z,X), parent(Y,Z), female(X).
%9 - sibiling
sibiling(X,Y) :- parent(Z,X), parent(Z,Y) , X \= Y. 
%10 - uncle
uncle(X,Y) :- parent(Z,Y), sibiling(A,Z), female(A), married(X,A) .
%11 - cousin 
cousin(X,Y) :- parent(Z,Y), sibiling(Z,A), female(A), parent(A,X),male(X). 
%12 - brother in law
brother_in_law(X,Y) :- female(Y), married(H,Y), sibiling(X,H), male(X). 
brother_in_law(X,Y) :- female(Y), sibiling(S,Y), female(S), married(X,S) ,male(X). 
brother_in_law(X,Y) :- female(Y), married(H,Y), sibiling(S,H), female(S), married(X,S), male(X).
brother_in_law(X,Y) :- male(Y), married(Y,W), sibiling(X,W), male(X). 
brother_in_law(X,Y) :- male(Y), sibiling(S,Y), female(S), married(X,S), male(X).  
brother_in_law(X,Y) :- male(Y), married(Y,W), sibiling(S,W), female(S), married(X,S), male(X).
%13 - niece
niece(X,Y) :- female(X), parent(Z,X), sibiling(Y,Z). 
%14 - second cousin
regular_cousin(X,Y) :- parent(P1,X), parent(P2,Y), sibiling(P1,P2). 
second_cousin(X,Y) :- parent(P1,X), parent(P2,Y), regular_cousin(P1,P2). 
%15 - grandmother niece
grandmother_niece(X,Y) :- grandmother(Z,X),niece(Y,Z).