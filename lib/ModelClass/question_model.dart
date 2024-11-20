class Question {
  final int questionId;
  final String questionText;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String correctAnswer;

  Question({
    required this.questionId,
    required this.questionText,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.correctAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionId: json['question_id'],
      questionText: json['question'],
      optionA: json['ans_a'],
      optionB: json['ans_b'],
      optionC: json['ans_c'],
      optionD: json['ans_d'],
      correctAnswer: json['answer'],
    );
  }

  static List<Question> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Question.fromJson(json)).toList();
  }
}
