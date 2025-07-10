import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'mypage_controller.dart';
import 'mypage_model.dart';
import 'package:provider/provider.dart';
import 'package:moodin_app/measure/measure_model.dart';

class MyPageView extends StatelessWidget {
  const MyPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MyPageController();
    final user = controller.getUserProfile();
    final measureModel = Provider.of<MeasureModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFB3E5FC), // 하늘색
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.grey),
            onPressed: () => Navigator.pop(context),
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

          // "무딘 님" 텍스트
          Positioned(
            top: 10,
            left: 24,
            child: Text(
              '${user.nickname} 님',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF263238),
              ),
            ),
          ),

          // 흰색 아래 배경 + 내용
          Positioned.fill(
            top: 120,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 프로필 카드
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xE6E9F8FF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset('assets/images/star.png', width: 80),
                              Image.asset('assets/images/bunny.png', width: 60),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('닉네임  ${user.nickname}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text('이메일  ${user.email}',
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(height: 4),
                              Text('스펙 및 성별  ${user.gender}',
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // mood in 텍스트 + 측정 여부에 따라 빨간불 표시
                    Row(
                      children: [
                        const Icon(Icons.favorite, color: Colors.blue),
                        const SizedBox(width: 8),
                        const Text('오늘 나의 ', style: TextStyle(fontSize: 16)),
                        const Text('mood in',
                            style: TextStyle(fontSize: 16, color: Colors.blue)),
                        const Text('은', style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 8),
                        if (measureModel.isDone) ...[
                          Text(
                            '빨간불',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade700,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Image.asset(
                            'assets/images/redlight.png',
                            width: 50,
                            height: 50,
                          ),
                        ],
                      ],
                    ),

                    const SizedBox(height: 30),

                    // 스트레스 추이 그래프
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                        children: [
                          const TextSpan(text: '최근 '),
                          TextSpan(
                              text: '${user.nickname} ',
                              style: const TextStyle(color: Colors.lightBlue)),
                          const TextSpan(text: '님의 스트레스 추이'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      height: 160,
                      child: LineChart(
                        LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                              isCurved: true,
                              spots: List.generate(
                                user.stressTrend.length,
                                (i) =>
                                    FlSpot(i.toDouble(), user.stressTrend[i]),
                              ),
                              barWidth: 3,
                              color: Colors.blue,
                              dotData: FlDotData(show: false),
                            )
                          ],
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(show: false),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
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
