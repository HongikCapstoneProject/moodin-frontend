import 'package:flutter/material.dart';

class SurveyResultView extends StatelessWidget {
  final int score;

  const SurveyResultView({super.key, required this.score});

  String get status {
    if (score >= 19) return "매우 높음";
    if (score >= 17) return "높음";
    if (score >= 14) return "보통";
    return "낮음";
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFB3E5FC), // 하늘색
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () => Navigator.pop(context), // 이전 페이지로
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.grey),
            onPressed: () {
              Navigator.pop(context); // 현재 페이지 pop
              Navigator.pop(context); // 이전 페이지 pop → 결국 이전이전 페이지로 이동
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // 구름 배경
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/images/cloud.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 본문
          Positioned.fill(
            top: 20,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "스트레스 자가진단 결과",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF263238),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // 토끼 + 말풍선
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xE6E9F8FF),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 32),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/bunny_result.png',
                            height: screenHeight * 0.25,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 24),

                          // 말풍선
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              CustomPaint(
                                size: const Size(30, 15),
                                painter: TrianglePainter(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    "$score 점",
                                    style: const TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF263238),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),
                          const Text(
                            "0~13점 : 낮음   14~16점 : 보통\n"
                            "17~18점 : 높음   19점 이상 : 매우 높음",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // mood in + 신호등
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.radio_button_checked,
                            color: Colors.black54, size: 24),
                        const SizedBox(width: 8),
                        const Text("오늘 나의 ", style: TextStyle(fontSize: 18)),
                        const Text("mood in",
                            style: TextStyle(
                                fontSize: 18, color: Colors.lightBlue)),
                        const Text("은", style: TextStyle(fontSize: 18)),
                        const SizedBox(width: 8),
                        Image.asset(
                          'assets/images/redlight.png',
                          width: 80,
                          height: 80,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          status,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 말풍선 꼬리 삼각형
class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
