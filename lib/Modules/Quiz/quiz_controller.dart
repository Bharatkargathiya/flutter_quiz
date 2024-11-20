import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_quiz/ApiService/base_response.dart';
import 'package:flutter_quiz/ModelClass/question_model.dart';
import 'package:flutter_quiz/Modules/Result/result_view.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Question> questions = <Question>[].obs;
  RxInt currentQuestionIndex = 0.obs;
  RxInt totalScore = 0.obs;
  RxString selectedAnswer = ''.obs;
  RxInt correctPredictions = 0.obs;

  final Dio dio = Dio();

  Future<void> fetchQuestions() async {
    isLoading.value = true;

    try {
      final response = await dio.get('https://practical.mytdigital.tech/');

      if (response.data is String) {
        final jsonData = jsonDecode(response.data);
        final apiResponse = ApiResponse.fromJson(
          jsonData,
              (data) => Question.fromJsonList(data['questions'] ?? []),
        );

        if (apiResponse.statusCode == 200 && apiResponse.data != null) {
          questions.value = apiResponse.data!;
        } else {
          Get.snackbar('Error', apiResponse.message);
        }
      } else {
        final apiResponse = ApiResponse.fromJson(
          response.data,
              (data) => Question.fromJsonList(data['questions'] ?? []),
        );

        if (apiResponse.statusCode == 200 && apiResponse.data != null) {
          questions.value = apiResponse.data!;
        } else {
          Get.snackbar('Error', apiResponse.message);
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch questions. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  void selectAnswer(String answer) {
    selectedAnswer.value = answer;

    if (questions.isNotEmpty && answer == questions[currentQuestionIndex.value].correctAnswer) {
      totalScore.value += (200 / questions.length).toInt(); // Increment score
      correctPredictions.value++; // Increment correct predictions
    }
  }


  void nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
      selectedAnswer.value = '';
    } else {
      Get.to(() => ResultScreen(
        score: totalScore.value,
        correctPredictions: correctPredictions.value,
      ));
    }
  }

}

