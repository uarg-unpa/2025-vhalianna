% ============================================
% productos2.pl — Base de productos del supermercado
% ============================================

:- dynamic producto/3.

% Hechos (categorías como átomos)
producto(arroz,   120, 'E').
producto(leche,   250, 'F').
producto(manzana, 180, 'E').
producto(shampoo, 600, 'H').
producto(jabon,    90, 'H').
producto(queso,   800, 'F').

% --- Mostrar (para verificar antes/después) ---
mostrar_productos :-
    producto(N, P, C),
    format("Producto: ~w | Precio: $~w | Categoría: ~w~n", [N, P, C]),
    fail ; true.

% --- Aumentar +5% sólo 'E' sin bucle infinito ---
aumento_productos :-
    % tomamos y removemos un producto 'E'
    retract(producto(Nombre, Precio, 'E')), 
    !,                                        % cut: fija esta elección
    Nuevo is round(Precio * 1.05),
    % procesamos el resto antes de reinsertar éste
    aumento_productos,
    % ahora sí, reinsertamos ACTUALIZADO
    assertz(producto(Nombre, Nuevo, 'E')),
    format("~w → nuevo precio: $~w (categoría: 'E')~n", [Nombre, Nuevo]).
aumento_productos :- 
    % caso base: ya no hay más 'E' para retract
    write('Actualización finalizada.'), nl.
