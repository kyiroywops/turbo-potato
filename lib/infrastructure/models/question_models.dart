class Question {
  final String category;
  final String content;

  Question({required this.category, required this.content});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      category: json['category'],
      content: json['content'],
    );
  }
}
