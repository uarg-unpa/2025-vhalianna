producto(laptop, 800).   % producto(Nombre, Precio)
producto(celular, 300).
producto(tablet, 150).

% Clasificación con cut (!)
clasificar(Producto, Categoria) :-
    producto(Producto, Precio),
    Precio > 500,
    Categoria = caro,
    !.  % corta: si ya es caro, no sigue probando otras reglas

clasificar(Producto, Categoria) :-
    producto(Producto, Precio),
    Precio >= 200, Precio =< 500,
    Categoria = medio,
    !.  % corta: si es medio, no sigue probando

clasificar(Producto, Categoria) :-
    producto(Producto, Precio),
    Precio < 200,
    Categoria = barato.

% Un producto está en oferta si su precio es menor a 300
es_oferta(Producto) :-
    producto(Producto, Precio),
    (Precio < 300),
    !,
    write('El producto '), write(Producto),
    write(' está en oferta'), nl.


% Caso contrario: no es oferta
es_oferta(Producto) :-
    write('El producto '), write(Producto), write(' no está en oferta'), nl,
    fail.
