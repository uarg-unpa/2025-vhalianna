% ============================================
% producto.pl — Solapamiento para ver efecto del cut
% Entrega N°2
% ============================================

% Hechos base: producto(Nombre, Precio).
producto(laptop, 800).
producto(celular, 300).
producto(tablet, 150).

% Producto de frontera para provocar solapamiento (precio = 500)
producto(console, 500).

% --------------------------------------------
% CLASIFICACIÓN *SIN* CUT  (provoca múltiples respuestas si hay solapamiento)
% caro  : Precio >= 500
% medio : 200 =< Precio =< 500
% barato: Precio < 200
% Nota: para Precio = 500, coinciden "caro" y "medio"
% --------------------------------------------

clasificar_sin_cut(Producto, Categoria) :-
    producto(Producto, Precio),
    Precio >= 500,
    Categoria = caro.

clasificar_sin_cut(Producto, Categoria) :-
    producto(Producto, Precio),
    Precio >= 200, Precio =< 500,
    Categoria = medio.

clasificar_sin_cut(Producto, Categoria) :-
    producto(Producto, Precio),
    Precio < 200,
    Categoria = barato.

% --------------------------------------------
% CLASIFICACIÓN *CON* CUT (evita alternativas redundantes)
% Mismas condiciones, pero cortamos al encontrar la primera coincidencia.
% --------------------------------------------

clasificar_con_cut(Producto, Categoria) :-
    producto(Producto, Precio),
    Precio >= 500,
    Categoria = caro,
    !.

clasificar_con_cut(Producto, Categoria) :-
    producto(Producto, Precio),
    Precio >= 200, Precio =< 500,
    Categoria = medio,
    !.

clasificar_con_cut(Producto, Categoria) :-
    producto(Producto, Precio),
    Precio < 200,
    Categoria = barato.

% --------------------------------------------
% Ejercicio adicionalgit  para ver efecto del cut con mensajes visibles
% --------------------------------------------

% es_oferta SIN cut (puede imprimir mensajes contradictorios al pedir más soluciones con ;)
es_oferta_sin_cut(Producto) :-
    producto(Producto, Precio),
    Precio < 300,
    write('El producto '), write(Producto), write(' está en oferta'), nl.

es_oferta_sin_cut(Producto) :-
    write('El producto '), write(Producto), write(' no está en oferta'), nl,
    fail.

% es_oferta CON cut (una sola rama consistente)
es_oferta_con_cut(Producto) :-
    producto(Producto, Precio),
    Precio < 300,
    !,
    write('El producto '), write(Producto), write(' está en oferta'), nl.

es_oferta_con_cut(Producto) :-
    write('El producto '), write(Producto), write(' no está en oferta'), nl,
    fail.
