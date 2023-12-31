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
