%segundo hechos
precio(el_principito, 60).
precio(harry_potter, 45).
stock(el_principito, 10).
stock(harry_potter, 3).
stock(el_principito,10).

libro_disponible_caro(Titulo, Precio, Stock) :- stock(Titulo, Stock), Precio > 50.

clasificar_libro(Precio, Categoria) :- Precio > 50, Categoria = caro.
clasificar_libro(Precio, Categoria) :- Precio =< 50, Categoria = economico.

pelicula(inception, ficcion). pelicula(gump,drama).
generos_diferentes(T1,T2) :- pelicula(T1, G1), pelicula(T2,G2), G1 \= G2.

%Negacion por fallo
sin_stock(Titulo):- \+ stock(Titulo,_).

% tercero: declarar predicados dinamicos
%:- dynamic nombre_predicado /aridad
:-dynamic libro/2.
:-dynamic prestado/2.


libro("el_principito", "antoine_de_saint_exupery").
libro("1984", "george_orwell").
prestado("el_principito", "juan").

%Regla: Un libro esta disponible si no esta prestado
disponible(Titulo):- libro(Titulo,_), \+ prestado(Titulo, _).

% Regla: Un libro está disponible si no está prestado
disponible(Titulo) :- libro(Titulo, _), \+ prestado(Titulo, _).

% Procedimiento para agregar un libro nuevo (al final)
agregar_libro(Titulo, Autor) :- assertz(libro(Titulo, Autor)).

% Procedimiento para agregar un libro nuevo (al inicio)
agregar_libro_al_inicio(Titulo, Autor) :- asserta(libro(Titulo, Autor)).

%Consulta para ver todos los libros
listar_libros :- libro(Titulo, Autor), write('Libro: '), write(Titulo), write(', Autor: '), write(Autor), nl,fail.  % Fuerza backtracking para listar todos
listar_libros.  % Clausula vacía para terminar

% Procedimiento para registrar un préstamo
prestar(Titulo, Persona) :- disponible(Titulo), assertz(prestado(Titulo, Persona)).

% Procedimiento para eliminar un libro
eliminar_libro(Titulo) :-
    libro(Titulo, Autor),          % Verifica que el libro exista
    \+ prestado(Titulo, _),        % Asegura que no esté prestado
    retract(libro(Titulo, Autor)), % Elimina el hecho libro/2
    write('Libro eliminado: '), write(Titulo), nl.

% Caso alternativo: libro prestado → falla
eliminar_libro(Titulo) :-
    prestado(Titulo, _),
    write('Error: no se puede eliminar el libro porque está prestado.'), nl,
    fail.

% Procedimiento para eliminar un préstamo de un libro
eliminar_prestamo(Titulo) :-
    retract(prestado(Titulo, Persona)),
    write('Préstamo eliminado: '), write(Titulo),
    write(' que estaba prestado a '), write(Persona), nl.