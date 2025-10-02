import 'package:flutter/material.dart';
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

                    // mood in 텍스트 + 빨간불
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
                          Image.asset(
                            'assets/images/redlight.png',
                            width: 50,
                            height: 50,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '빨간불',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade700,
                            ),
                          ),
                        ],
                      ],
                    ),

                    const SizedBox(height: 50),

                    // questionBunny + 말풍선
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 토끼 이미지
                        Image.asset(
                          'assets/images/questionBunny.png',
                          width: 120,
                        ),
                        const SizedBox(width: 12),
                        // 말풍선
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 4,
                                  offset: const Offset(2, 2),
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black87),
                                    children: [
                                      TextSpan(
                                          text: '화병',
                                          style: TextStyle(
                                              color: Colors.red.shade700,
                                              fontWeight: FontWeight.bold)),
                                      const TextSpan(text: '에 대해 알고계신가요?\n'),
                                      const TextSpan(
                                          text: '궁금하다면 저와 함께 알아보아요.'),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    // TODO: 이동할 화면 연결
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey.shade200,
                                    foregroundColor: Colors.black87,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                  ),
                                  child: const Text("알아보러 가기"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
