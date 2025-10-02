// lib/mypage/hwabyeong_view.dart
import 'package:flutter/material.dart';

class HwabyeongView extends StatelessWidget {
  const HwabyeongView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = 20.0;
    const imageHeight = 200.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF9E9E9E)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Color(0xFF9E9E9E)),
            onPressed: () =>
                Navigator.of(context).popUntil((route) => route.isFirst),
          ),
        ],
        iconTheme: const IconThemeData(color: Color(0xFF9E9E9E)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 상단 이미지
            SizedBox(
              width: double.infinity,
              height: imageHeight,
              child: Image.asset(
                'assets/images/Hwabyeong.png',
                fit: BoxFit.cover,
              ),
            ),

            // 흰색 카드 내용
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    horizontalPadding, 24, horizontalPadding, 36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row: "화병" 왼쪽, "출처" 오른쪽
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        const Text(
                          '화병',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '출처 자하연 한의원',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // 첫 단락 RichText
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF263238),
                            height: 1.6),
                        children: [
                          const TextSpan(
                              text:
                                  '가슴이 답답하고 숨이 막히며 뱃속에서 뜨거운 기운이 치밀어 오르는 증상과 함께 '),
                          TextSpan(
                            text: '불안·절망·우울·분노',
                            style: TextStyle(
                              backgroundColor: Colors.yellow.shade100,
                              color: const Color(0xFF263238),
                            ),
                          ),
                          const TextSpan(
                              text:
                                  '가 나타나는 병입니다. 억울한 감정과 스트레스를 풀지 못해 자율적인 감정 조절 능력이 상실되면서 신체 증상으로 이어져 결국 '),
                          TextSpan(
                            text: '화병이 발생',
                            style: TextStyle(
                                backgroundColor: Colors.yellow.shade100,
                                color: const Color(0xFF263238)),
                          ),
                          const TextSpan(text: '합니다.'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Q1
                    const Text(
                      'Q. 화병은 왜 나타날까요?',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'A. 울화가 치밀어 주먹으로 가슴을 치며 한숨 쉬는 모습을 종종 볼 수 있습니다. 울화는 억울한 '
                      '감정을 발산하지 못하고 억지로 참는 가운데 생기는 화를 말합니다. 이러한 감정과 스트레스가 쌓이면서 감정 조절 능력이 저하되어 신체 증상으로 이어지고 결국 화병이 발생합니다.',
                      style: TextStyle(
                          fontSize: 15, height: 1.6, color: Color(0xFF263238)),
                    ),

                    const SizedBox(height: 22),

                    // Q2
                    const Text(
                      'Q. 화병이 나타나는 주요 원인이 뭔가요?',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'A. 다양한 원인이 있습니다.',
                      style: TextStyle(fontSize: 15),
                    ),

                    const SizedBox(height: 8),

                    // bullet list
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('• 배우자와의 갈등', style: TextStyle(fontSize: 15)),
                          SizedBox(height: 6),
                          Text('• 과중한 업무와 그로 인한 스트레스',
                              style: TextStyle(fontSize: 15)),
                          SizedBox(height: 6),
                          Text('• 사업실패나 타인과의 금전관계에서 재산상의 손실, 고생 등의 경제적 요인',
                              style: TextStyle(fontSize: 15)),
                          SizedBox(height: 6),
                          Text('• 자녀의 비정상적인 행동이나 시험 낙방, 성격 문제',
                              style: TextStyle(fontSize: 15)),
                          SizedBox(height: 6),
                          Text('• 자신의 오랜 지병', style: TextStyle(fontSize: 15)),
                          SizedBox(height: 6),
                          Text('• 가족이나 친지, 친구의 갑작스러운 사망',
                              style: TextStyle(fontSize: 15)),
                          SizedBox(height: 6),
                          Text('• 정보의 홍수, 교통체증, 정치의 불만족 감',
                              style: TextStyle(fontSize: 15)),
                          SizedBox(height: 6),
                          Text('• 편중된 정서장애, 정서의 급격한 변화',
                              style: TextStyle(fontSize: 15)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    const Divider(height: 1, color: Color(0xFFF0F0F0)),
                    const SizedBox(height: 22),

                    // mood in RichText
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                            fontSize: 15,
                            height: 1.6,
                            color: Color(0xFF263238)),
                        children: const [
                          TextSpan(
                            text: 'mood in',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 62, 133, 168),
                            ),
                          ),
                          TextSpan(
                            text:
                                '은 자가진단 또는 최근 7일간의 회원님의 스트레스 추이를 분석하여, 화병을 사전에 예측할 수 있습니다.',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // 분석 버튼
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFBEEAF6),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          // TODO: 분석 페이지 연결
                        },
                        child: const Text(
                          '지금 분석하러 가기 >',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF0F1724)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
