import 'package:flutter/material.dart';
import 'package:flutter_quiz/ModelClass/question_model.dart';
import 'package:flutter_quiz/Modules/Result/result_view.dart';
import 'package:flutter_quiz/Utils/color_utils.dart';
import 'package:flutter_quiz/Utils/const_utils.dart';
import 'package:flutter_quiz/Utils/image_utils.dart';
import 'package:get/get.dart';
import 'quiz_controller.dart';

class QuizScreen extends StatelessWidget {
  final QuizController controller = Get.put(QuizController());

  QuizScreen({super.key}) {
    controller.fetchQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.questions.isEmpty) {
          return Center(
            child: Text(
              ConstUtils.lblNoQuestions,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: ColorUtils.questionColor,
              ),
            ),
          );
        }

        Question question =
            controller.questions[controller.currentQuestionIndex.value];
        bool isLastQuestion = controller.currentQuestionIndex.value ==
            controller.questions.length - 1;
        bool isOptionSelected = controller
            .selectedAnswer.value.isNotEmpty; // Check if any option is selected
        int totalQuestions = controller.questions.length;

        // Calculate progress as a percentage
        double progress =
            (controller.currentQuestionIndex.value + 1) / totalQuestions;

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeading(),
              // Progress Bar and Question Count
              buildProgressBar(progress, totalQuestions),
              buildQuestion(question),
              const SizedBox(height: 64),
              // Display options
              ...['A', 'B', 'C', 'D'].asMap().entries.map((entry) {
                final index = entry.key;
                final label = entry.value;
                final option = [
                  question.optionA,
                  question.optionB,
                  question.optionC,
                  question.optionD
                ][index];

                return buildAnswerView(option, label);
                // ignore: unnecessary_to_list_in_spreads
              }).toList(),
              const Spacer(),
              buildContinueBtn(isOptionSelected, isLastQuestion),
            ],
          ),
        );
      }),
    );
  }

  Widget buildAnswerView(String option, String label) {
    return GestureDetector(
      onTap: () {
        controller.selectAnswer(option);
      },
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: controller.selectedAnswer.value == option
              ? ColorUtils.selectedAnswerBg
              : ColorUtils.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            // Letter or Icon
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: controller.selectedAnswer.value == option
                    ? ColorUtils.white
                    : ColorUtils.optionContainerBg,
                shape: BoxShape.circle,
              ),
              child: controller.selectedAnswer.value == option
                  ? Image.asset(
                      height: 24,
                      width: 24,
                      scale: 2.5,
                      ImageUtils.icRightIconThin,
                    )
                  : Center(
                      child: Text(
                        label,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: ColorUtils.black,
                        ),
                      ),
                    ),
            ),
            const SizedBox(width: 16),
            // Option text
            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: controller.selectedAnswer.value == option
                      ? ColorUtils.white
                      : ColorUtils.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContinueBtn(bool isOptionSelected, bool isLastQuestion) {
    return GestureDetector(
      onTap: isOptionSelected
          ? () {
              if (isLastQuestion) {
                Get.to(() => ResultScreen(score: controller.totalScore.value, correctPredictions: controller.correctPredictions.value,));
              } else {
                controller.nextQuestion(); // Go to next question
              }
            }
          : null,
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(8),
          color: isOptionSelected ? ColorUtils.btnGreen : ColorUtils.btnGrey,
        ),
        child: Center(
          child: Text(
            isLastQuestion ? ConstUtils.lblFinish : ConstUtils.lblContinue,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: ColorUtils.btnLbl,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildQuestion(Question question) {
    return Text(
      question.questionText,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: ColorUtils.questionColor,
      ),
    );
  }

  Widget buildProgressBar(double progress, int totalQuestions) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 12.0,
                backgroundColor: Colors.grey[300],
                color: ColorUtils.btnGreen,
                borderRadius: BorderRadiusDirectional.circular(16),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              '${controller.currentQuestionIndex.value + 1}/$totalQuestions',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: ColorUtils.questionCounter,
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget buildHeading() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 24),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 22,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: ColorUtils.containerBg,
            ),
            child: Row(
              children: [
                Image.asset(
                  width: 14,
                  height: 14,
                  ImageUtils.icScore,
                  scale: 3,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  ConstUtils.lbl200,
                  style: const TextStyle(
                    color: ColorUtils.questionColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 4,
            child: Text(
              ConstUtils.appBarString,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              print("Close Icon Tapped!!!");
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorUtils.containerBg,
              ),
              child: Image.asset(
                ImageUtils.icClose,
                scale: 3,
              ),
            ),
          )
        ],
      ),
    );
  }
}
