% =========================
% Ejercicio de entrega
% Base de conocimientos: Películas y Actores
% Ver detalles en la carpeta TP1>README.md
% Parte 1 – Hechos
% =========================
%
% En Prolog los hechos son la base de datos. 
% Cuando le preguntamos algo, Prolog trata de "unificar" la consulta
% con estos hechos. Si encuentra coincidencia, responde "true" (sí).
% Si no encuentra nada, responde "false" (no).
%
% Ejemplo: Si cargamos este archivo y hacemos ?- pelicula(inception, ciencia_ficcion).
% Prolog compara la consulta con los hechos cargados, ve que coincide con el primero,
% y nos responde "true".

% --- Hechos pedidos en el enunciado ---

% Acá le decimos a Prolog: "Inception es una película de ciencia ficción".
% Cuando consultemos con ?- pelicula(inception, X)., Prolog unifica X = ciencia_ficcion.
pelicula(inception, ciencia_ficcion).

% Le informamos que Leonardo DiCaprio actúa en Inception.
% Entonces si consultamos ?- actor(leonardo_dicaprio, inception).
% Prolog encuentra este hecho y responde que sí (true).
actor(leonardo_dicaprio, inception).

% Christopher Nolan dirige Inception.
% Si preguntamos ?- director(christopher_nolan, Pelicula).
% Prolog buscará qué Pelicula coincide y nos devolverá Pelicula = inception.
director(christopher_nolan, inception).

% Tom Hanks actúa en Forrest Gump.
% Esto permite que si hacemos ?- actor(tom_hanks, Pelicula).
% Prolog nos devuelva Pelicula = forrest_gump.
actor(tom_hanks, forrest_gump).

% Forrest Gump es una película de drama.
% Entonces con ?- pelicula(forrest_gump, Genero).
% Prolog responderá Genero = drama.
pelicula(forrest_gump, drama).

% Steven Spielberg dirige Jurassic Park.
% Si consultamos ?- director(steven_spielberg, Titulo).
% Prolog devolverá Titulo = jurassic_park.
director(steven_spielberg, jurassic_park).

% Jurassic Park es una película de aventura.
% Con la consulta ?- pelicula(jurassic_park, Genero).
% Prolog unifica Genero = aventura.
pelicula(jurassic_park, aventura).

% --- Hechos adicionales para enriquecer la base ---

% Joseph Gordon-Levitt y Tom Hardy también actúan en Inception.
% Esto amplía las posibles respuestas cuando consultemos los actores de esa película.
actor(joseph_gordon_levitt, inception).
actor(tom_hardy, inception).

% Forrest Gump fue dirigida por Robert Zemeckis.
% Ahora Prolog sabe que esa película tiene un director asociado.
director(robert_zemeckis, forrest_gump).

% En Jurassic Park actuaron Laura Dern, Sam Neill y Jeff Goldblum.
% Si preguntamos ?- actor(Actor, jurassic_park).
% Prolog nos devolverá los tres actores, uno por vez con el ; (backtracking).
actor(laura_dern, jurassic_park).
actor(sam_neill, jurassic_park).
actor(jeff_goldblum, jurassic_park).

% Interstellar es otra película de Christopher Nolan, de ciencia ficción.
% Consultando ?- director(christopher_nolan, P).
% Prolog dará dos resultados: P = inception ; P = interstellar.
pelicula(interstellar, ciencia_ficcion).
director(christopher_nolan, interstellar).
actor(matthew_mcconaughey, interstellar).
actor(anne_hathaway, interstellar).

% Saving Private Ryan es de Spielberg, y Tom Hanks también actúa ahí.
% Prolog ya puede responder que Tom Hanks participa en dos películas distintas.
pelicula(saving_private_ryan, guerra).
director(steven_spielberg, saving_private_ryan).
actor(tom_hanks, saving_private_ryan).

% Una más: The Pursuit of Happyness, que es un drama dirigido por Gabriele Muccino
% y protagonizado por Will Smith. Esto diversifica los géneros.
pelicula(the_pursuit_of_happyness, drama).
actor(will_smith, the_pursuit_of_happyness).
director(gabriele_mucciono, the_pursuit_of_happyness).

% =========================
% Parte 3 – Reglas
% =========================

% a) actua_en_genero(Actor, Genero)
% Verdadero si un actor actúa en una película de ese género.
% Prolog resuelve unificando Actor con actor/2 y Película con pelicula/2.
% Ejemplo de uso: ?- actua_en_genero(leonardo_dicaprio, G).
actua_en_genero(Actor, Genero) :-
    actor(Actor, Titulo),
    pelicula(Titulo, Genero).

% b) colaboracion(Actor1, Actor2)
% Verdadero si dos actores diferentes trabajan en la misma película.
% Prolog prueba todas las combinaciones de actores para una película,
% y descarta los casos donde Actor1 = Actor2.
% Ejemplo: ?- colaboracion(leonardo_dicaprio, Otro).
colaboracion(Actor1, Actor2) :-
    actor(Actor1, Titulo),
    actor(Actor2, Titulo),
    Actor1 \= Actor2.

% c) director_de_genero(Director, Genero)
% Verdadero si un director dirigió una película de cierto género.
% Prolog unifica Director con director/2 y esa misma película con pelicula/2.
% Ejemplo: ?- director_de_genero(christopher_nolan, G).
director_de_genero(Director, Genero) :-
    director(Director, Titulo),
    pelicula(Titulo, Genero).

% d) pelicula_con_colaboracion(Titulo)
% Verdadero si en una película hay al menos dos actores distintos.
% Prolog busca dos hechos actor/2 distintos con el mismo título.
% Ejemplo: ?- pelicula_con_colaboracion(P).
pelicula_con_colaboracion(Titulo) :-
    actor(Actor1, Titulo),
    actor(Actor2, Titulo),
    Actor1 \= Actor2.

% e) Regla propia: pelicula_completa(Titulo)
% Verdadero si una película tiene al menos un director y un actor.
% Así garantizamos que está completa en la base de datos.
% Ejemplo: ?- pelicula_completa(P).
pelicula_completa(Titulo) :-
    director(_, Titulo),
    actor(_, Titulo).


% =========================
% Parte 4 – Análisis y extensión
% =========================

% =========================
% Extensión de la base: sexo y reglas nuevas
% =========================

% Ahora agregamos información sobre el sexo de cada actor/actriz.
% Esto nos permitirá crear reglas que diferencien entre masculino/femenino.
% Cuando consultemos, Prolog buscará un hecho "sexo/2" que unifique con la persona dada.

sexo(leonardo_dicaprio, masculino).
sexo(tom_hanks, masculino).
sexo(joseph_gordon_levitt, masculino).
sexo(tom_hardy, masculino).
sexo(laura_dern, femenino).
sexo(sam_neill, masculino).
sexo(jeff_goldblum, masculino).
sexo(matthew_mcconaughey, masculino).
sexo(anne_hathaway, femenino).
sexo(will_smith, masculino).

% -------------------------
% actriz_en_pelicula/2
% -------------------------
% Esta regla dice: "Una persona es actriz de una película si:
%   1) aparece como sexo femenino
%   2) y además figura como actor en esa película".
% Prolog resuelve primero verificando el sexo y después la actuación.
% Ejemplo de uso: ?- actriz_en_pelicula(anne_hathaway, P).
% Prolog busca sexo(anne_hathaway, femenino) (lo encuentra)
% y luego actor(anne_hathaway, P) (devuelve P = interstellar).

actriz_en_pelicula(NombreActriz, Titulo) :-
    sexo(NombreActriz, femenino),
    actor(NombreActriz, Titulo).

% -------------------------
% Consultas de prueba
% -------------------------
% a) Listar actrices en Jurassic Park
% ?- actriz_en_pelicula(A, jurassic_park).
% Prolog responde A = laura_dern.

% b) Listar todas las actrices con sus películas (backtracking)
% ?- actriz_en_pelicula(A, P).
% Prolog da A = laura_dern, P = jurassic_park ;
%              A = anne_hathaway, P = interstellar.

% -------------------------
% actriz_en_genero/2 (otra regla)
% -------------------------
% Esta regla amplía el concepto: "Una persona es actriz en un género
% si es mujer, actúa en una película y esa película es de dicho género".
% Prolog encadena los tres predicados: sexo/2, actor/2 y pelicula/2.
% Ejemplo: ?- actriz_en_genero(A, ciencia_ficcion).
% Devuelve A = anne_hathaway, porque cumple las tres condiciones.

actriz_en_genero(Actriz, Genero) :-
    sexo(Actriz, femenino),
    actor(Actriz, Titulo),
    pelicula(Titulo, Genero).
