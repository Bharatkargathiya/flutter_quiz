import 'dart:convert';
import 'package:flutter_quiz/ModelClass/question_model.dart';
import 'package:http/http.dart' as http;


class QuizService {
  final String apiUrl = 'https://practical.mytdigital.tech/';

  Future<List<Question>> fetchQuestions() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final questionsList = data['DATA']['questions'] as List;
      return questionsList.map((json) => Question.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load questions');
    }
  }
}
