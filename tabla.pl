% Caso base: cuando llegamos a M = 10
tabla(N, 10) :-
    R is N * 10,
    format('~w x 10 = ~w~n', [N, R]),
    !.  % cut: corta acá para no seguir buscando reglas

% Caso recursivo: para M < 10
tabla(N, M) :-
    M < 10,
    R is N * M,
    format('~w x ~w = ~w~n', [N, M, R]),
    M1 is M + 1,          % incrementa el multiplicador
    tabla(N, M1).

% Predicado principal: inicia la tabla con M = 1
tabla(N) :-
    tabla(N, 1).
