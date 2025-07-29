import 'package:flutter/material.dart';
import 'result_model.dart';
import 'result_controller.dart';
import 'package:moodin_app/home/home_view.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ResultController();
    final user = controller.getResultUser();

    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F5),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeView(username: user.nickname),
                ),
              );
            },
          ),
        ],
        backgroundColor: Color(0xFFEFF3F5),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${user.nickname}님',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0077A3),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '오늘의 스트레스 수준',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF535A61),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F8FC),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  // ✅ 검정 직사각형 + 원 3개
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.circle, color: Color(0xFF3A3A3A), size: 16),
                        SizedBox(width: 4),
                        Icon(Icons.circle, color: Color(0xFF3A3A3A), size: 16),
                        SizedBox(width: 4),
                        Icon(Icons.circle, color: Colors.red, size: 16),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // ✅ 빨간 텍스트
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '빨간불',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red, // 원하는 색상으로
                          ),
                        ),
                        TextSpan(
                          text: '\u2003 ▶  너무 높아요 !!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // textAlign: TextAlign.center, // 필요시 가운데 정렬
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatusCard('HRV', '30 ms', Colors.black),
                _buildStatusCard('GSR', '57 ms', Colors.black),
              ],
            ),
            const SizedBox(height: 30),
            const Divider(
              height: 32,
              color: Color.fromARGB(255, 232, 232, 232),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: user.nickname,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF0077A3), // 원하는 색상으로
                    ),
                  ),
                  const TextSpan(
                    text: '님 맞춤 스트레스 해소법',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF535A61),
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center, // 필요시 가운데 정렬
            ),
            const SizedBox(height: 20),
            _buildTipItem('1분\n해소법', Icons.self_improvement, '횡경막 호흡하기'),
            _buildTipItem('2분\n해소법', Icons.cookie, '초콜릿 섭취'),
            _buildTipItem('3분\n해소법', Icons.remove_red_eye, '반복패턴 응시하기'),
            _buildTipItem('10분\n해소법', Icons.local_cafe, '녹차 마시기'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(String title, String value, Color indicatorColor) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8FC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(title == 'HRV' ? Icons.favorite : Icons.pan_tool,
                  color: Colors.red),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 4),
              const Icon(Icons.help_outline, size: 16),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            height: 10,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.green, Colors.yellow, Colors.red],
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: indicatorColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String time, IconData icon, String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // 아이콘 (왼쪽)
          Icon(icon, size: 40),
          const SizedBox(width: 12),

          // 원형 텍스트
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.orangeAccent, width: 6),
            ),
            child: Center(
              child: Text(
                time,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF455A64),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // 해소법 텍스트 박스
          Container(
            width: 180,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Color(0xFFFBEFE8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              tip,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
