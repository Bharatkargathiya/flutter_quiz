import 'package:flutter/material.dart';
import 'package:flutter_quiz/Modules/Quiz/quiz_controller.dart';
import 'package:flutter_quiz/Modules/Quiz/quiz_view.dart';
import 'package:flutter_quiz/Utils/const_utils.dart';
import 'package:get/get.dart';

import '../../Utils/color_utils.dart';
import '../../Utils/image_utils.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int correctPredictions;

  const ResultScreen({super.key, required this.score, required this.correctPredictions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            buildCloseIcon(),
            buildImg(),
            buildResultTxt(),
            const SizedBox(
              height: 65,
            ),
            buildResultContainer(),
            const Spacer(),
            buildOkayBtn()
          ],
        ),
      ),
    );
  }

  Widget buildOkayBtn() {
    return GestureDetector(
      onTap: () {
        final controller = Get.find<QuizController>();
        controller.currentQuestionIndex.value = 0; // Reset to the first question
        controller.totalScore.value = 0; // Reset the score
        controller.correctPredictions.value = 0; // Reset correct predictions
        controller.selectedAnswer.value = ''; // Clear selected answer

        // Navigate back to the QuizScreen
        Get.offAll(() => QuizScreen());
      },
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(8),
          color: ColorUtils.btnGreen,
        ),
        child: Center(
          child: Text(
            ConstUtils.lblOkay,
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

  Widget buildResultContainer() {
    return Container(
      decoration: BoxDecoration(
          color: ColorUtils.containerBg,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          buildScoreContainer(
              img: ImageUtils.icScoreGained,
              text: ConstUtils.lblScoreGained,
              gainedScore: score.toString()),
          const Divider(
            height: 1,
            color: ColorUtils.appBg,
            indent: 3,
            endIndent: 3,
          ),
          buildScoreContainer(
              img: ImageUtils.icRightIconThick,
              text: ConstUtils.lblCorrectPredictions,
              gainedScore: correctPredictions.toString()),
        ],
      ),
    );
  }

  Widget buildResultTxt() {
    return Text(
      ConstUtils.lblResultOfQuiz,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: ColorUtils.questionColor,
      ),
    );
  }

  Widget buildImg() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 40),
      child: Image.asset(
        height: 150,
        ImageUtils.icResultReward,
      ),
    );
  }

  Widget buildCloseIcon() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () {
            // ignore: avoid_print
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
        ),
      ),
    );
  }

  Widget buildScoreContainer(
      {required String text,
      required String img,
      required String gainedScore}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            height: 36,
            width: 36,
            decoration: const BoxDecoration(
              color: ColorUtils.appBg,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              img,
              scale: 3,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
            ),
          ),
          const Spacer(),
          Text(
            gainedScore,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
