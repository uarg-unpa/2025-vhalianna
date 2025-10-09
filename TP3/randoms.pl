% Caso base: cuando queda imprimir solo 1 número
imprimir(1) :-
    random_between(1, 100, A),   % genera un número entre 1 y 100
    write(A), nl,                % lo imprime con salto de línea
    write('fin'), nl,            % marca que terminó
    !.                           % cut: evita seguir buscando más reglas


% Caso recursivo: cuando hay más de 1 número por imprimir
imprimir(X) :-
    X > 1,                       % se asegura de que sea mayor a 1
    random_between(1, 100, A),   % genera un número aleatorio
    write(A), nl,                % lo imprime
    X1 is X - 1,                 % calcula el siguiente contador
    imprimir(X1).                % llamada recursiva

