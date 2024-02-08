import 'dart:math';

import 'package:culturach/infrastructure/datasources/question_service.dart';
import 'package:culturach/infrastructure/models/question_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionsNotifier extends StateNotifier<AsyncValue<List<Question>>> {
  final QuestionService _questionService;

  QuestionsNotifier(this._questionService, String category)
      : super(const AsyncValue.loading()) {
    loadQuestions(category);
  }
 Future<void> loadQuestions(String category) async {
  state = const AsyncValue.loading();
  try {
    List<Question> categoryQuestions =
        await _questionService.loadQuestions(category);
    state = AsyncValue.data(categoryQuestions..shuffle(Random()));
  } catch (e, stack) { // Aquí capturas también el StackTrace del error
    state = AsyncValue.error(e, stack); // Y aquí lo pasas como segundo argumento
  }
}
}

final questionServiceProvider = Provider<QuestionService>((ref) {
  return QuestionService();
});

final questionsProvider = StateNotifierProvider.family<QuestionsNotifier,
    AsyncValue<List<Question>>, String>(
  (ref, category) {
    final questionService = ref.watch(questionServiceProvider);
    return QuestionsNotifier(questionService, category);
  },
);
