% ============================================
% productos.pl — Base de productos del supermercado
% ============================================


% Hecho: producto(Nombre, Precio, Categoria)
producto(arroz,120, E).   % E podría representar 'alimentos'
producto(leche,250, F).   % F podría representar 'lácteos'
producto(manzana,180, G).   % G podría representar 'frutas'
producto(shampoo,600, H).   % H podría representar 'higiene'
producto(jabon,90, H).
producto(queso,800, F).

% Declaramos producto/3 como dinámico para poder modificarlo en tiempo de ejecución
:- dynamic producto/3.
% Predicado principal: aplica aumento del 5% a todos los productos de la categoría E
aumento_productos :-
    producto(Nombre, Precio, E),              % buscar un producto de categoría E
    NuevoPrecio is round(Precio * 1.05),      % calcular el nuevo precio (redondeado)
    retract(producto(Nombre, Precio, E)),     % eliminar el hecho viejo
    assertz(producto(Nombre, NuevoPrecio, E)),% agregar el hecho actualizado
    aumento_productos.                        % llamada recursiva para seguir con el resto
% Caso base: si no quedan más productos E, termina sin error
Aumento_productos.

