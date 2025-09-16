# Ejercicio de Entrega N°1

---

## 🔹 Parte 2: Consultas sobre Hechos

En esta sección se muestran las consultas pedidas en la Parte 2, con sus respuestas y una breve explicación de cómo Prolog las resuelve mediante unificación y backtracking

a) ¿Cuáles películas dirige Christopher Nolan?
```prolog
?- director(christopher_nolan, TituloPelicula).
```

✅ Respuestas:

TituloPelicula = inception ;
TituloPelicula = interstellar.

📝 Explicación:
Prolog busca todos los hechos que cumplan director(christopher_nolan, X).
Primero unifica con inception, y al presionar ; retrocede (backtracking) y encuentra interstellar.

b) ¿Qué actores actúan en películas de ciencia ficción?
```prolog
?- pelicula(TituloPelicula, ciencia_ficcion),
   actor(NombreActor, TituloPelicula).
```
✅ Respuestas:

Película	Actor
inception	leonardo_dicaprio
inception	joseph_gordon_levitt
inception	tom_hardy
interstellar	matthew_mcconaughey
interstellar	anne_hathaway

📝 Explicación:
Primero busca un pelicula/2 con género ciencia_ficcion.
Después, con ese mismo título, unifica con hechos de actor/2.
El backtracking permite ir sacando todas las combinaciones posibles.

c) Lista todas las películas y sus géneros
```prolog
?- pelicula(TituloPelicula, Genero).
```

✅ Respuestas:

Película	Género
inception	ciencia_ficcion
forrest_gump	drama
jurassic_park	aventura
interstellar	ciencia_ficcion
saving_private_ryan	guerra
the_pursuit_of_happyness	drama

📝 Explicación:
Prolog recorre uno por uno los hechos de pelicula/2, y en cada caso unifica los valores con TituloPelicula y Genero.

d) ¿Actor en Inception y otra película?
```prolog
?- actor(NombreActor, inception),
   actor(NombreActor, OtraPelicula),
   OtraPelicula \= inception.
```

✅ Respuesta:

false.


📝 Explicación:
Prolog intenta buscar un mismo NombreActor en Inception y en otra película distinta.
Como en esta base de hechos ningún actor de Inception aparece en otra, devuelve false.

✨ Consultas propias

1) Todas las películas de Tom Hanks
```prolog
?- actor(tom_hanks, P).
```

✅ Respuestas:

P = forrest_gump ;
P = saving_private_ryan.

📝 Explicación:
El hecho se cumple en dos casos, y Prolog los devuelve uno por vez.

2) Directores de películas de ciencia ficción
```prolog
?- pelicula(T, ciencia_ficcion),
   director(D, T).
```

✅ Respuestas:

T = inception,    D = christopher_nolan ;
T = interstellar, D = christopher_nolan.

📝 Explicación:
Prolog primero busca películas de género ciencia_ficcion.
Después, con ese mismo T, revisa quién la dirige.
El backtracking permite listar todas las coincidencias.

---

## 🔹 Parte 3: Definir reglas


Explicación acerca de consultas para chequear las reglas pedidas en la Parte 3, con sus respuestas y una breve explicación

a) Géneros en los que actúa Leonardo DiCaprio
```prolog
?- actua_en_genero(leonardo_dicaprio, Genero).
```
👉 Obtenido:

Genero = ciencia_ficcion.

b) Colaboradores de Leonardo DiCaprio
```prolog
?- colaboracion(leonardo_dicaprio, OtroActor).
```
👉 Obtenido:

OtroActor = joseph_gordon_levitt ;
OtroActor = tom_hardy.

c) Géneros de películas dirigidas por Christopher Nolan

```prolog
?- director_de_genero(christopher_nolan, Genero).
```

👉 Obtenido:
```prolog
Genero = ciencia_ficcion.
```

(Prolog devuelve dos veces ciencia_ficcion porque Nolan tiene Inception e Interstellar en ese género.)

d) Películas con más de un actor
```prolog
?- pelicula_con_colaboracion(Pelicula).
```

La salida fue:

?- pelicula_completa(P).
P = inception ;
P = inception ;
P = inception ;
P = jurassic_park ;
P = jurassic_park ;
P = jurassic_park ;
P = forrest_gump ;
P = interstellar ;
P = interstellar;
P = saving_private_ryan ;
P = the_pursuit_of_happyness.

El motor de Prolog evalúa esta regla combinando todos los hechos disponibles de director/2 y actor/2 para un mismo Titulo. Este mecanismo genera un producto cartesiano entre directores y actores: por cada director asociado a una película, se devuelven tantas soluciones como actores estén registrados en esa misma película. En consecuencia, si una película posee un director y tres actores, Prolog entregará tres soluciones idénticas para esa película, una por cada emparejamiento director–actor que satisface la regla.

En el caso de la base de hechos utilizada, los resultados fueron los siguientes:

Inception: 1 director × 3 actores = 3 soluciones.
Jurassic Park: 1 director × 3 actores = 3 soluciones.
Interstellar: 1 director × 2 actores = 2 soluciones.
Forrest Gump: 1 director × 1 actor = 1 solución.
Saving Private Ryan: 1 director × 1 actor = 1 solución.
The Pursuit of Happyness: 1 director × 1 actor = 1 solución.

En total, la consulta produjo 11 respuestas, lo cual evidencia cómo Prolog, al no distinguir entre repeticiones en los valores de Titulo, devuelve todas las combinaciones válidas de director y actor que satisfacen la condición planteada en la regla.

e) Películas "completas" (con director y al menos un actor)

?- pelicula_completa(P).

Se define que una película está completa en la base si tiene al menos un director y un actor.

---

## 🔹 Parte 4: Análisis y Extensión


1. Explica en 1-2 párrafos cómo Prolog resuelve una consulta compleja de la Parte 2 (Ej., chaining
en b), incluyendo unificación (matching de variables) y backtracking (prueba de soluciones
alternativas).
2. Extiende la base: Agrega hechos sobre sexo de actores (ejemplo, sexo(NombreActor,
masculino/femenino).) y define una regla como actriz_en_pelicula(NombreActriz,
TituloPelicula)

---

## 1. Consulta compleja

Ejemplo:

```prolog
?- pelicula(Titulo, ciencia_ficcion), actor(Actor, Titulo).
```

Prolog resuelve esta consulta en dos pasos encadenados (chaining). Primero intenta unificar la variable Titulo con todos los hechos pelicula/2 que tengan ciencia_ficcion como género. Cuando encuentra uno válido (por ejemplo, inception), mantiene esa unificación y pasa al segundo objetivo: buscar un hecho actor/2 que tenga como segundo argumento ese mismo Titulo. Así obtiene un primer resultado, por ejemplo Actor = leonardo_dicaprio.

En este punto, Prolog queda preparado para el backtracking. Si el usuario presiona ;, el motor retrocede y prueba otra posible solución: primero busca otro actor/2 para el mismo Titulo, devolviendo joseph_gordon_levitt, después tom_hardy, y así hasta agotarlos. Cuando no quedan más actores para inception, Prolog vuelve atrás al primer objetivo (pelicula/2) y prueba otra película de ciencia ficción, interstellar. Con ese nuevo valor de Titulo, repite el proceso para actor/2 y devuelve matthew_mcconaughey y anne_hathaway. El mecanismo de unificación (igualar variables con términos de los hechos) junto con el backtracking (probar soluciones alternativas cuando se pide más con ;) permiten a Prolog encontrar todas las combinaciones posibles que satisfacen la consulta.


---

## 2. Extiende la base

Luego de agregar los solicitado en el punto 2. y ejecutar make., se realizaron las siguientes consultas:

**a) Actrices en una película concreta**
```prolog
?- actriz_en_pelicula(A, jurassic_park).
```
👉 Obtenido:

A = laura_dern.

**b) Todas las actrices y sus películas**
```prolog
?- actriz_en_pelicula(A, P).
```
👉Obtenido (Con ; se pueden recorrer todas):

A = laura_dern,    P = jurassic_park ;
A = anne_hathaway, P = interstellar.

**c) Actrices en un género**
```prolog
?- actriz_en_genero(A, ciencia_ficcion).
```
👉Obtenido:

A = anne_hathaway.

**Probar el análisis de backtracking**

```prolog
?- pelicula(T, ciencia_ficcion), actor(A, T).
```
Al presionar ; varias veces, Prolog primero muestra todos los actores de Inception y luego hace backtracking para continuar con los de Interstellar.

👉Obtenido:

T = inception,
A = leonardo_dicaprio ;
T = inception,
A = joseph_gordon_levitt ;
T = inception,
A = tom_hardy ;
T = interstellar,
A = matthew_mcconaughey ;
T = interstellar,
A = anne_hathaway.