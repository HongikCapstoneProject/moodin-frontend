import 'package:flutter/material.dart';

class SurveyResultView extends StatelessWidget {
  final int score;

  const SurveyResultView({super.key, required this.score});

  String get status {
    if (score >= 19) {
      return "매우 높음";
    } else if (score >= 17) {
      return "높음";
    } else if (score >= 14) {
      return "보통";
    } else {
      return "낮음";
    }
  }

  Color get statusColor {
    if (score >= 19) {
      return Colors.red;
    } else if (score >= 17) {
      return Colors.orange;
    } else if (score >= 14) {
      return Colors.blue;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB3E5FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4FC3F7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("스트레스 자가진단 결과"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Column(
                  children: [
                    // 이미지 (첨부된 이미지 경로로 변경 가능)
                    Image.asset(
                      'assets/images/bunny_result.png', // 본인이 프로젝트에 맞게 경로 바꿔주세요
                      width: 120,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        "$score 점",
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "0~13점: 낮음   14~16점: 보통   17~18점: 높음   19점 이상: 매우 높음",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                  children: [
                    const TextSpan(text: "오늘 나의 mood in은 "),
                    TextSpan(
                      text: status,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
