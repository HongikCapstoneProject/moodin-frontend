import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moodin_app/measure/measure_model.dart';
import 'package:moodin_app/home/home_view.dart';
import 'package:moodin_app/intro/intro_view.dart';
import 'package:moodin_app/login/login_view.dart';
import 'package:moodin_app/measure/measure_view.dart';
import 'package:moodin_app/mypage/mypage_view.dart';
import 'package:moodin_app/survey/survey_model.dart'; 
import 'package:moodin_app/survey/survey_view.dart'; 
import 'package:moodin_app/survey/survey_result_view.dart'; 

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MeasureModel()),
        ChangeNotifierProvider(create: (_) => SurveyModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood In',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => const IntroView(),
        '/measure': (_) => const MeasureView(),
        '/home': (_) => const HomeView(username: '무딘'),
        '/mypage': (_) => const MyPageView(),
        '/survey': (_) => const SurveyView(), // 설문조사 등록
      },
    );
  }
}
