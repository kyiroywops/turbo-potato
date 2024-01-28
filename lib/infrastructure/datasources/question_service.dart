import 'dart:convert';

import 'package:culturach/infrastructure/models/question_models.dart';
import 'package:flutter/services.dart';

class QuestionService {
  Future<List<Question>> loadQuestions(String category) async {
    final String response = await rootBundle.loadString('assets/jsons/$category.json');
    final data = json.decode(response);
    return (data['questions'] as List).map((i) => Question.fromJson(i)).toList();
  }
}
