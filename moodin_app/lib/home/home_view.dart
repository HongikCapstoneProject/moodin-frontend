import 'package:flutter/material.dart';
import 'package:moodin_app/mypage/mypage_view.dart';
import 'package:provider/provider.dart';
import 'package:moodin_app/measure/measure_model.dart';
import 'package:moodin_app/measure/measure_view.dart';

class HomeView extends StatelessWidget {
  final String username;

  const HomeView({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB3E5FC),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                'assets/images/cloud.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Consumer<MeasureModel>(builder: (context, model, _) {
            if (model.isDone) {
              // 측정 완료 UI
              return Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: '오늘 ',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF37474F),
                            ),
                            children: [
                              TextSpan(
                                text: '$username',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlue,
                                ),
                              ),
                              const TextSpan(
                                text: ' 님의\n스트레스 신호는',
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        Container(
                          width: 360,
                          padding: const EdgeInsets.symmetric(
                              vertical: 24, horizontal: 24),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(153),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 120,
                                height: 120,
                                child: Image.asset(
                                  'assets/images/redlight_main.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(width: 30, height: 150),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '매우 높음',
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.red,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MyPageView()),
                                        );
                                      },
                                      child: const Text(
                                        '자세히 보러가기 >',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        _bottomNav(context),
                      ],
                    ),
                  ),
                  // 화면 맨 하단에 토끼 + 텍스트 고정
                  Padding(
                    // 여백을 40으로 설정 (필요 시 이 값을 조절하세요)
                    padding: const EdgeInsets.only(bottom: 80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/bunny_emoji.png',
                          width: 90,
                          height: 90,
                        ),
                        const SizedBox(width: 1),
                        const Text(
                          '설문조사를 통해\n오늘의 스트레스와 비교해보세요!',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF364D57),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            // 측정 전 UI
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    text: '오늘 ',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF37474F),
                    ),
                    children: [
                      TextSpan(
                        text: '$username',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue,
                        ),
                      ),
                      const TextSpan(
                        text: ' 님의 스트레스 신호를\n확인해 보세요!',
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Image.asset(
                  'assets/images/measureicon.png',
                  width: 120,
                  height: 120,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFECB3),
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 3,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MeasureView(),
                      ),
                    );
                  },
                  child: const Text(
                    '측정 하러 가기 >',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                _bottomNav(context),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _bottomNav(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyPageView()),
            );
          },
          child: const Text(
            '마이페이지',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
        const SizedBox(width: 16),
        const Text('|', style: TextStyle(fontSize: 14, color: Colors.black45)),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MeasureView()),
            );
          },
          child: const Text(
            '측정 페이지',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}
