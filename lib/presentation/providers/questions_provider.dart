import 'dart:math';

import 'package:culturach/infrastructure/models/question_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionsNotifier extends StateNotifier<List<Question>> {
  QuestionsNotifier() : super([]);

  void loadQuestions(String category) {
    // Lista simulada de todas las preguntas
    List<Question> allQuestions = [
      Question(category: 'marcas', content: 'La cultura chupística pide marcas de autos'),
      Question(category: 'marcas', content: 'La cultura chupística pide marcas de ropa'),
      Question(category: 'marcas', content: 'La cultura chupística pide marcas de celulares'),
      Question(category: 'marcas', content: 'La cultura chupística pide marcas de relojes'),
      Question(category: 'marcas', content: 'La cultura chupística pide marcas de zapatos deportivos'),
      Question(category: 'marcas', content: 'La cultura chupística pide marcas de bebidas alcohólicas'),
      Question(category: 'marcas', content: 'La cultura chupística pide marcas de cosméticos'),
      Question(category: 'marcas', content: 'La cultura chupística pide marcas de supermercados'),
      Question(category: 'marcas', content: 'La cultura chupística pide marcas de cadenas de comida rápida'),
      Question(category: 'marcas', content: 'La cultura chupística pide marcas de electrodomésticos'),
      Question(category: 'marcas', content: 'La cultura chupística pide marcas de computadoras'),
      Question(category: 'marcas', content: 'La cultura chupística pide marcas de cámaras fotográficas'),
      Question(category: 'marcas', content: 'La cultura chupística pide marcas de tiendas de ropa'),
      Question(category: 'marcas', content: 'La cultura chupística pide marcas de bicicletas'),
      Question(category: 'marcas', content: 'La cultura chupística pide marcas de herramientas'),
      Question(category: 'marcas', content: 'La cultura chupística pide marcas de juguetes'),
      Question(category: 'marcas', content: 'La cultura chupística pide marcas de tiendas de electrónica'),
      Question(category: 'marcas', content: 'La cultura chupística pide marcas de videojuegos'),
      Question(category: 'marcas', content: 'La cultura chupística pide marcas de artículos deportivos'),
      Question(category: 'marcas', content: 'La cultura chupística pide marcas de servicios de streaming'),
      // Continuación de la lista de preguntas...

      Question(category: 'series', content: 'La cultura chupística pide series de comedia'),
      Question(category: 'series', content: 'La cultura chupística pide series de ciencia ficción'),
      Question(category: 'series', content: 'La cultura chupística pide series dramáticas aclamadas por la crítica'),
      Question(category: 'series', content: 'La cultura chupística pide series que hayan ganado un Emmy'),
      Question(category: 'series', content: 'La cultura chupística pide series basadas en libros'),
      Question(category: 'series', content: 'La cultura chupística pide series de superhéroes'),
      Question(category: 'series', content: 'La cultura chupística pide series de terror'),
      Question(category: 'series', content: 'La cultura chupística pide series que se emitan en Netflix'),
      Question(category: 'series', content: 'La cultura chupística pide series antiguas de los años 90'),
      Question(category: 'series', content: 'La cultura chupística pide series de anime japonés'),
      Question(category: 'series', content: 'La cultura chupística pide series de fantasía'),
      Question(category: 'series', content: 'La cultura chupística pide series con temporadas de más de 10 episodios'),
      Question(category: 'series', content: 'La cultura chupística pide series con un elenco principal femenino'),
      Question(category: 'series', content: 'La cultura chupística pide series de crimen e investigación'),
      Question(category: 'series', content: 'La cultura chupística pide series que hayan sido canceladas'),
      Question(category: 'series', content: 'La cultura chupística pide series con spin-offs'),
      Question(category: 'series', content: 'La cultura chupística pide series que hayan tenido un reboot'),
      Question(category: 'series', content: 'La cultura chupística pide series de reality show'),
      Question(category: 'series', content: 'La cultura chupística pide series de una sola temporada'),
      Question(category: 'series', content: 'La cultura chupística pide series que hayan cambiado de protagonista'),

     // Continuación de la lista de preguntas...

      Question(category: 'peliculas', content: 'La cultura chupística pide películas ganadoras del Oscar a Mejor Película'),
      Question(category: 'peliculas', content: 'La cultura chupística pide películas de acción de los años 80'),
      Question(category: 'peliculas', content: 'La cultura chupística pide películas de ciencia ficción con viajes en el tiempo'),
      Question(category: 'peliculas', content: 'La cultura chupística pide películas de culto'),
      Question(category: 'peliculas', content: 'La cultura chupística pide películas dirigidas por mujeres'),
      Question(category: 'peliculas', content: 'La cultura chupística pide películas de superhéroes'),
      Question(category: 'peliculas', content: 'La cultura chupística pide películas que se hayan convertido en franquicias'),
      Question(category: 'peliculas', content: 'La cultura chupística pide películas clásicas del cine negro'),
      Question(category: 'peliculas', content: 'La cultura chupística pide películas de romance que hagan llorar'),
      Question(category: 'peliculas', content: 'La cultura chupística pide películas que tengan secuelas'),
      Question(category: 'peliculas', content: 'La cultura chupística pide películas que hayan sido filmadas en tu país'),
      Question(category: 'peliculas', content: 'La cultura chupística pide películas que hayan sido prohibidas en algún momento'),
      Question(category: 'peliculas', content: 'La cultura chupística pide películas de animación nominadas a premios internacionales'),
      Question(category: 'peliculas', content: 'La cultura chupística pide películas basadas en hechos reales'),
      Question(category: 'peliculas', content: 'La cultura chupística pide películas que se desarrollen en el futuro'),
      Question(category: 'peliculas', content: 'La cultura chupística pide películas con plot twist inesperados'),
      Question(category: 'peliculas', content: 'La cultura chupística pide películas de horror clásicas'),
      Question(category: 'peliculas', content: 'La cultura chupística pide películas que han inspirado memes'),
      Question(category: 'peliculas', content: 'La cultura chupística pide películas con bandas sonoras memorables'),
      Question(category: 'peliculas', content: 'La cultura chupística pide películas que hayan sido adaptadas de series de televisión'),

      // Continuación de la lista de preguntas...

      Question(category: 'actores', content: 'La cultura chupística pide actores ganadores de un Oscar'),
      Question(category: 'actores', content: 'La cultura chupística pide actores que hayan interpretado superhéroes'),
      Question(category: 'actores', content: 'La cultura chupística pide actrices que hayan protagonizado películas de acción'),
      Question(category: 'actores', content: 'La cultura chupística pide actores que también sean músicos'),
      Question(category: 'actores', content: 'La cultura chupística pide actores que hayan trabajado en películas de ciencia ficción'),
      Question(category: 'actores', content: 'La cultura chupística pide actores que hayan dado voz a personajes de animación'),
      Question(category: 'actores', content: 'La cultura chupística pide actores que hayan participado en series de televisión'),
      Question(category: 'actores', content: 'La cultura chupística pide actores que hayan estado en películas de culto'),
      Question(category: 'actores', content: 'La cultura chupística pide actores de comedia romántica'),
      Question(category: 'actores', content: 'La cultura chupística pide actores con carreras en Broadway'),
      Question(category: 'actores', content: 'La cultura chupística pide actrices que hayan interpretado a personajes históricos'),
      Question(category: 'actores', content: 'La cultura chupística pide actores que empezaron su carrera en el teatro'),
      Question(category: 'actores', content: 'La cultura chupística pide actores que hayan ganado múltiples premios internacionales'),
      Question(category: 'actores', content: 'La cultura chupística pide actores que hayan protagonizado películas de terror'),
      Question(category: 'actores', content: 'La cultura chupística pide actores que hayan aparecido en adaptaciones de cómics'),
      Question(category: 'actores', content: 'La cultura chupística pide actores que hayan realizado sus propias acrobacias en películas'),
      Question(category: 'actores', content: 'La cultura chupística pide actores que hayan dirigido películas'),
      Question(category: 'actores', content: 'La cultura chupística pide actores que hayan ganado premios por roles de soporte'),
      Question(category: 'actores', content: 'La cultura chupística pide actrices que hayan ganado premios antes de los 30 años'),
      Question(category: 'actores', content: 'La cultura chupística pide actores que hayan interpretado a personajes basados en novelas'),

      // Continúa agregando más preguntas según necesites...

            // Continuación de la lista de preguntas...

      Question(category: 'deportes', content: 'La cultura chupística pide nombres de equipos de fútbol internacionales'),
      Question(category: 'deportes', content: 'La cultura chupística pide deportistas que hayan ganado medallas olímpicas de oro'),
      Question(category: 'deportes', content: 'La cultura chupística pide nombres de tenistas que han ganado Grand Slams'),
      Question(category: 'deportes', content: 'La cultura chupística pide deportes que se jueguen con pelota'),
      Question(category: 'deportes', content: 'La cultura chupística pide disciplinas deportivas olímpicas'),
      Question(category: 'deportes', content: 'La cultura chupística pide deportes acuáticos'),
      Question(category: 'deportes', content: 'La cultura chupística pide nombres de pilotos de Fórmula 1'),
      Question(category: 'deportes', content: 'La cultura chupística pide campeones del mundo de ajedrez'),
      Question(category: 'deportes', content: 'La cultura chupística pide estadios de fútbol famosos'),
      Question(category: 'deportes', content: 'La cultura chupística pide marcas conocidas de artículos deportivos'),
      Question(category: 'deportes', content: 'La cultura chupística pide deportistas famosos por su labor filantrópica'),
      Question(category: 'deportes', content: 'La cultura chupística pide equipos de baloncesto de la NBA'),
      Question(category: 'deportes', content: 'La cultura chupística pide países que han sido sede de los Juegos Olímpicos'),
      Question(category: 'deportes', content: 'La cultura chupística pide jugadores de golf con campeonatos mayores'),
      Question(category: 'deportes', content: 'La cultura chupística pide boxeadores campeones del mundo'),
      Question(category: 'deportes', content: 'La cultura chupística pide nombres de gimnastas olímpicos'),
      Question(category: 'deportes', content: 'La cultura chupística pide competencias internacionales de rugby'),
      Question(category: 'deportes', content: 'La cultura chupística pide atletas que hayan batido récords mundiales'),
      Question(category: 'deportes', content: 'La cultura chupística pide jugadores de voleibol destacados'),
      Question(category: 'deportes', content: 'La cultura chupística pide campeones de ciclismo del Tour de Francia'),

      // Continúa agregando más preguntas según necesites...


      Question(category: 'musica', content: 'La cultura chupística pide nombres de bandas de rock clásico'),
      Question(category: 'musica', content: 'La cultura chupística pide cantantes solistas ganadores de Grammys'),
      Question(category: 'musica', content: 'La cultura chupística pide géneros de música electrónica'),
      Question(category: 'musica', content: 'La cultura chupística pide nombres de grandes compositores de música clásica'),
      Question(category: 'musica', content: 'La cultura chupística pide artistas famosos del pop de los años 2000'),
      Question(category: 'musica', content: 'La cultura chupística pide intérpretes icónicos de jazz'),
      Question(category: 'musica', content: 'La cultura chupística pide grupos de hip-hop influyentes'),
      Question(category: 'musica', content: 'La cultura chupística pide nombres de divas del soul'),
      Question(category: 'musica', content: 'La cultura chupística pide canciones que hayan roto récords en Billboard'),
      Question(category: 'musica', content: 'La cultura chupística pide músicos que han actuado en películas'),
      Question(category: 'musica', content: 'La cultura chupística pide festivales de música internacionales'),
      Question(category: 'musica', content: 'La cultura chupística pide nombres de instrumentos de cuerda'),
      Question(category: 'musica', content: 'La cultura chupística pide canciones ganadoras del Eurovisión'),
      Question(category: 'musica', content: 'La cultura chupística pide álbumes que hayan sido certificados como Diamante'),
      Question(category: 'musica', content: 'La cultura chupística pide artistas de reggaetón'),
      Question(category: 'musica', content: 'La cultura chupística pide cantautores de música folk'),
      Question(category: 'musica', content: 'La cultura chupística pide bandas sonoras de películas famosas'),
      Question(category: 'musica', content: 'La cultura chupística pide nombres de boy bands y girl groups'),
      Question(category: 'musica', content: 'La cultura chupística pide estilos de música latinoamericana'),
      Question(category: 'musica', content: 'La cultura chupística pide artistas que han tenido residencias en Las Vegas'),

      // Continuación de la lista de preguntas...

      Question(category: 'historia', content: 'La cultura chupística pide nombres de antiguas civilizaciones'),
      Question(category: 'historia', content: 'La cultura chupística pide grandes emperadores de la historia'),
      Question(category: 'historia', content: 'La cultura chupística pide inventos que cambiaron el mundo'),
      Question(category: 'historia', content: 'La cultura chupística pide batallas históricas importantes'),
      Question(category: 'historia', content: 'La cultura chupística pide mujeres que marcaron la historia'),
      Question(category: 'historia', content: 'La cultura chupística pide exploradores y conquistadores famosos'),
      Question(category: 'historia', content: 'La cultura chupística pide líderes de movimientos de independencia'),
      Question(category: 'historia', content: 'La cultura chupística pide grandes filósofos de la antigüedad'),
      Question(category: 'historia', content: 'La cultura chupística pide descubrimientos arqueológicos notables'),
      Question(category: 'historia', content: 'La cultura chupística pide periodos de arte histórico'),
      Question(category: 'historia', content: 'La cultura chupística pide revoluciones que cambiaron naciones'),
      Question(category: 'historia', content: 'La cultura chupística pide tratados internacionales clave'),
      Question(category: 'historia', content: 'La cultura chupística pide pandemias históricas'),
      Question(category: 'historia', content: 'La cultura chupística pide inventores notables y sus invenciones'),
      Question(category: 'historia', content: 'La cultura chupística pide monarcas que dejaron su huella en la historia'),
      Question(category: 'historia', content: 'La cultura chupística pide eventos que desencadenaron la Primera Guerra Mundial'),
      Question(category: 'historia', content: 'La cultura chupística pide civilizaciones desaparecidas y sus misterios'),
      Question(category: 'historia', content: 'La cultura chupística pide cambios territoriales significativos tras guerras'),
      Question(category: 'historia', content: 'La cultura chupística pide ciudades antiguas famosas por su legado cultural'),
      Question(category: 'historia', content: 'La cultura chupística pide importantes figuras de la Ilustración'),

      // Continúa agregando más preguntas según necesites...

      Question(category: 'geografia', content: 'La cultura chupística pide nombres de países que comiencen con la letra "A"'),
      Question(category: 'geografia', content: 'La cultura chupística pide ciudades que hayan sido capitales olímpicas'),
      Question(category: 'geografia', content: 'La cultura chupística pide ríos importantes de Sudamérica'),
      Question(category: 'geografia', content: 'La cultura chupística pide desiertos del mundo'),
      Question(category: 'geografia', content: 'La cultura chupística pide islas que son países'),
      Question(category: 'geografia', content: 'La cultura chupística pide montañas más altas de cada continente'),
      Question(category: 'geografia', content: 'La cultura chupística pide capitales de países europeos'),
      Question(category: 'geografia', content: 'La cultura chupística pide nombres de parques nacionales famosos'),
      Question(category: 'geografia', content: 'La cultura chupística pide países con costas en el mar Mediterráneo'),
      Question(category: 'geografia', content: 'La cultura chupística pide países que atraviesa el ecuador'),
      Question(category: 'geografia', content: 'La cultura chupística pide países miembros de la Unión Europea'),
      Question(category: 'geografia', content: 'La cultura chupística pide ciudades conocidas por sus canales'),
      Question(category: 'geografia', content: 'La cultura chupística pide lugares Patrimonio de la Humanidad por UNESCO'),
      Question(category: 'geografia', content: 'La cultura chupística pide lagos importantes en Norteamérica'),
      Question(category: 'geografia', content: 'La cultura chupística pide países que han cambiado de nombre'),
      Question(category: 'geografia', content: 'La cultura chupística pide volcanes activos en el mundo'),
      Question(category: 'geografia', content: 'La cultura chupística pide países con sistemas monárquicos'),
      Question(category: 'geografia', content: 'La cultura chupística pide países sin salida al mar'),
      Question(category: 'geografia', content: 'La cultura chupística pide capitales que estén a gran altitud'),
      Question(category: 'geografia', content: 'La cultura chupística pide ciudades que son sede de importantes instituciones internacionales'),

      // Continúa agregando más preguntas según necesites...
      // Continuación de la lista de preguntas...

      Question(category: 'ciudades', content: 'La cultura chupística pide ciudades que sean capitales de sus países'),
      Question(category: 'ciudades', content: 'La cultura chupística pide ciudades famosas por sus festivales de música'),
      Question(category: 'ciudades', content: 'La cultura chupística pide ciudades que tienen un río dividiéndolas'),
      Question(category: 'ciudades', content: 'La cultura chupística pide ciudades que han albergado los Juegos Olímpicos'),
      Question(category: 'ciudades', content: 'La cultura chupística pide ciudades conocidas por su arquitectura antigua'),
      Question(category: 'ciudades', content: 'La cultura chupística pide ciudades con un monumento icónico'),
      Question(category: 'ciudades', content: 'La cultura chupística pide ciudades con sistemas de metro'),
      Question(category: 'ciudades', content: 'La cultura chupística pide ciudades que son centros financieros globales'),
      Question(category: 'ciudades', content: 'La cultura chupística pide ciudades famosas por su comida callejera'),
      Question(category: 'ciudades', content: 'La cultura chupística pide ciudades que son islas'),
      Question(category: 'ciudades', content: 'La cultura chupística pide ciudades con muros antiguos aún en pie'),
      Question(category: 'ciudades', content: 'La cultura chupística pide ciudades que son Patrimonio de la Humanidad'),
      Question(category: 'ciudades', content: 'La cultura chupística pide ciudades conocidas por sus desfiles de carnaval'),
      Question(category: 'ciudades', content: 'La cultura chupística pide ciudades que han cambiado de nombre'),
      Question(category: 'ciudades', content: 'La cultura chupística pide ciudades con playas urbanas'),
      Question(category: 'ciudades', content: 'La cultura chupística pide ciudades famosas por su vida nocturna'),
      Question(category: 'ciudades', content: 'La cultura chupística pide ciudades que son capitales culturales'),
      Question(category: 'ciudades', content: 'La cultura chupística pide ciudades famosas por sus puentes'),
      Question(category: 'ciudades', content: 'La cultura chupística pide ciudades que han sido escenario de grandes películas'),
      Question(category: 'ciudades', content: 'La cultura chupística pide ciudades que se consideran cunas de civilizaciones'),

      // Continuación de la lista de preguntas...

      Question(category: 'normal', content: 'La cultura chupística pide nombres de frutas tropicales'),
      Question(category: 'normal', content: 'La cultura chupística pide nombres de razas de perros'),
      Question(category: 'normal', content: 'La cultura chupística pide idiomas oficiales en más de un país'),
      Question(category: 'normal', content: 'La cultura chupística pide países con monarquías actuales'),
      Question(category: 'normal', content: 'La cultura chupística pide colores del arcoíris'),
      Question(category: 'normal', content: 'La cultura chupística pide instrumentos musicales de cuerda'),
      Question(category: 'normal', content: 'La cultura chupística pide platos típicos de tu país'),
      Question(category: 'normal', content: 'La cultura chupística pide nombres de dinosaurios'),
      Question(category: 'normal', content: 'La cultura chupística pide maravillas del mundo moderno'),
      Question(category: 'normal', content: 'La cultura chupística pide elementos de la tabla periódica'),
      Question(category: 'normal', content: 'La cultura chupística pide autores de libros famosos'),
      Question(category: 'normal', content: 'La cultura chupística pide nombres de capitales de países asiáticos'),
      Question(category: 'normal', content: 'La cultura chupística pide nombres de océanos'),
      Question(category: 'normal', content: 'La cultura chupística pide personajes de mitología griega'),
      Question(category: 'normal', content: 'La cultura chupística pide inventos del siglo XX'),
      Question(category: 'normal', content: 'La cultura chupística pide nombres de constelaciones'),
      Question(category: 'normal', content: 'La cultura chupística pide premios Nobel de la Paz'),
      Question(category: 'normal', content: 'La cultura chupística pide animales en peligro de extinción'),
      Question(category: 'normal', content: 'La cultura chupística pide especias y hierbas culinarias'),
      Question(category: 'normal', content: 'La cultura chupística pide festivales culturales importantes en el mundo'),

      // Continúa agregando más preguntas según necesites...



    ];

    // Filtrar preguntas por categoría
    List<Question> filteredQuestions = allQuestions.where((question) => question.category == category).toList();
    state = filteredQuestions..shuffle(Random());
  }
}

final questionsProvider =
    StateNotifierProvider.family<QuestionsNotifier, List<Question>, String>(
  (ref, category) => QuestionsNotifier()..loadQuestions(category),
);
