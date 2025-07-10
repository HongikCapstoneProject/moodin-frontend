import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 꼭 추가
import 'package:moodin_app/measure/measure_model.dart'; // 모델 경로 확인
import 'package:moodin_app/home/home_view.dart';
import 'package:moodin_app/intro/intro_view.dart';
import 'package:moodin_app/login/login_view.dart';
import 'package:moodin_app/measure/measure_view.dart';
import 'package:moodin_app/mypage/mypage_view.dart';
import 'package:moodin_app/result/result_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MeasureModel()),
      ],
      child: const MyApp(),   // ← MyApp 전체가 MeasureModel 스코프 안에 들어갑니다
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
        '/result': (_) => const ResultView(),
        '/home': (_) => const HomeView(username: '무딘',),
        '/mypage': (_) => const MyPageView(),
      },
    );
  }
}
