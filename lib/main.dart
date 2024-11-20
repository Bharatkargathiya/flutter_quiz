import 'package:flutter/material.dart';
import 'package:flutter_quiz/Modules/Quiz/quiz_view.dart';
import 'package:flutter_quiz/Utils/color_utils.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Modules/Result/result_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: GoogleFonts.openSans().fontFamily,
        scaffoldBackgroundColor: ColorUtils.appBg,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => QuizScreen()),
        GetPage(
            name: '/result',
            page: () => const ResultScreen(
                  score: 0,
              correctPredictions: 0,
                )),
      ],
    );
  }
}
