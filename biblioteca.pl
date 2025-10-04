% ============================================
% biblioteca.pl — TP: Modificación dinámica y consultas
% ============================================

% ------------------------------------------------------------------
% [Datos iniciales provistos por la consigna]
% ------------------------------------------------------------------
precio(el_principito, 60).
precio(harry_potter, 45).

stock(el_principito, 10).
stock(harry_potter, 3).
stock(el_principito, 10).  % (repetido a propósito según enunciado)

% ------------------------------------------------------------------
% [Parte de consultas sencillas / clasificación de precios]
%   - "caro" si Precio > 50
%   - "economico" si Precio =< 50
%   - Comentado para dejar claro que responde a la consigna del "caro"
% ------------------------------------------------------------------
% [Consigna: clasificación de libro por precio]
clasificar_libro(Precio, Categoria) :- Precio > 50, Categoria = caro.
clasificar_libro(Precio, Categoria) :- Precio =< 50, Categoria = economico.

% [Consigna: libro_disponible_caro/3]
% Versión mejor explicada: relaciona Titulo con precio/stock y exige Precio>50 y Stock>0.
libro_disponible_caro(Titulo, Precio, Stock) :-
    precio(Titulo, Precio),
    stock(Titulo, Stock),
    Precio > 50,
    Stock > 0.

% ------------------------------------------------------------------
% [Consigna: hechos y regla de películas y géneros]
% ------------------------------------------------------------------
pelicula(inception, ficcion). 
pelicula(gump, drama).

% [Consigna: géneros diferentes]
generos_diferentes(T1, T2) :-
    pelicula(T1, G1), 
    pelicula(T2, G2), 
    G1 \= G2.

% ------------------------------------------------------------------
% [Consigna: Negación por fallo]
%   sin_stock(T) es verdadero si NO hay ningún hecho stock(T,_)
% ------------------------------------------------------------------
sin_stock(Titulo) :- \+ stock(Titulo, _).

% ------------------------------------------------------------------
% [Consigna: declarar predicados dinámicos]
%   Repaso de dynamic: habilita modificar hechos en tiempo de ejecución
%   (asserta/assertz/retract). Sin esto, Prolog no permite alterarlos.
% ------------------------------------------------------------------
:- dynamic libro/2.
:- dynamic prestado/2.

% ------------------------------------------------------------------
% [Base mínima de biblioteca]
%   Nota: acá usás STRINGS ("el_principito"). No unifican con átomos.
% ------------------------------------------------------------------
libro("el_principito", "antoine_de_saint_exupery").
libro("1984", "george_orwell").

prestado("el_principito", "juan").

% ------------------------------------------------------------------
% [Utilidades de biblioteca]
% ------------------------------------------------------------------

% [Consigna: disponible/1] — un libro está disponible si existe y NO está prestado
disponible(Titulo) :- 
    libro(Titulo, _), 
    \+ prestado(Titulo, _).

% [Consigna: agregar un libro (al final)]
agregar_libro(Titulo, Autor) :- 
    assertz(libro(Titulo, Autor)).

% [Consigna: agregar un libro (al inicio)]
agregar_libro_al_inicio(Titulo, Autor) :- 
    asserta(libro(Titulo, Autor)).

% [Consigna: registrar un préstamo si está disponible]
prestar(Titulo, Persona) :- 
    disponible(Titulo), 
    assertz(prestado(Titulo, Persona)).

% [Consigna: listar todos los libros]
listar_libros :-
    libro(Titulo, Autor),
    write('Libro: '), write(Titulo), write(', Autor: '), write(Autor), nl,
    fail.
listar_libros.  % cláusula de corte para terminar el listado

% ------------------------------------------------------------------
% [PARTE 1 de la consigna: Modificación dinámica con dynamic y retract]
%   Implementar eliminar_libro(Titulo) con 3 casos:
%     1) Existe y NO está prestado -> eliminar + mensaje + éxito
%     2) Está prestado -> mensaje de error + fail
%     3) NO existe -> mensaje de error + fail
% ------------------------------------------------------------------

% Caso 1: existe y NO está prestado -> eliminar
eliminar_libro(Titulo) :-
    libro(Titulo, Autor),          % Verifica que el libro exista
    \+ prestado(Titulo, _),        % Asegura que no esté prestado
    retract(libro(Titulo, Autor)), % Elimina el hecho libro/2
    write('Libro eliminado: '), write(Titulo), nl, !.

% Caso 2: libro prestado -> informar y fallar
eliminar_libro(Titulo) :-
    prestado(Titulo, _),
    write('Error: no se puede eliminar el libro porque está prestado.'), nl,
    fail.

% Caso 3: libro NO existe -> informar y fallar
eliminar_libro(Titulo) :-
    \+ libro(Titulo, _),
    write('Error: Libro '), write(Titulo), write(' no existe.'), nl,
    fail.


% ------------------------------------------------------------------
% [EJERCICIO ADICIONAL de la consigna]
%   eliminar_prestamo(Titulo): usar retract/1; si no hay préstamo, fallar
% ------------------------------------------------------------------
eliminar_prestamo(Titulo) :-
    retract(prestado(Titulo, Persona)),
    write('Préstamo eliminado: '), write(Titulo),
    write(' que estaba prestado a '), write(Persona), nl, !.
eliminar_prestamo(Titulo) :-
    write('Error: no existe préstamo registrado para ese título.'), nl,
    fail.

% ------------------------------------------------------------------
% [Pruebas sugeridas — como comentarios]
%   % ?- clasificar_libro(60, C).         % C = caro.
%   % ?- libro_disponible_caro(el_principito, P, S).
%   % ?- generos_diferentes(inception, gump).
%   % ?- sin_stock(un_titulo_que_no_esta).
%   % ?- listar_libros.
%   % ?- eliminar_libro("1984").           % elimina (si no hay préstamo)
%   % ?- eliminar_libro("el_principito").  % error: está prestado
%   % ?- eliminar_prestamo("el_principito").
%   % ?- eliminar_libro("el_principito").  % ahora sí elimina
% ------------------------------------------------------------------
