import 'dart:math';

import 'package:culturach/infrastructure/datasources/question_service.dart';
import 'package:culturach/infrastructure/models/question_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionsNotifier extends StateNotifier<List<Question>> {
  final QuestionService _questionService;
  var _isLoading = false;

  QuestionsNotifier(this._questionService, String category) : super([]) {
    loadQuestions(category);
  }

  Future<void> loadQuestions(String category) async {
    _isLoading = true;
    try {
      List<Question> categoryQuestions = await _questionService.loadQuestions(category);
      state = categoryQuestions..shuffle(Random());
    } catch (e) {
      // Manejo de errores
    } finally {
      _isLoading = false;
    }
  }

  bool get isLoading => _isLoading;
}

final questionServiceProvider = Provider<QuestionService>((ref) {
  return QuestionService();
});

final questionsProvider = StateNotifierProvider.family<QuestionsNotifier, List<Question>, String>(
  (ref, category) {
    final questionService = ref.watch(questionServiceProvider);
    return QuestionsNotifier(questionService, category);
  },
);
