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
import 'package:permission_handler/permission_handler.dart';
import 'measure/gsr_stream.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        Provider<GsrBleClient>(create: (_) => GsrBleClient()),
        ChangeNotifierProvider(create: (_) => MeasureModel()),
        ChangeNotifierProvider(create: (_) => SurveyModel()),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> requestBlePermissions() async {
  // Android 12 이상에서는 반드시 필요
  final statuses = await [
    Permission.bluetoothScan,
    Permission.bluetoothConnect,
    Permission.location, // 일부 기기는 위치 권한 있어야 스캔됨
  ].request();

  if (statuses.values.any((s) => !s.isGranted)) {
    throw Exception('BLE 권한이 필요합니다. 설정에서 허용해주세요.');
  }
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
