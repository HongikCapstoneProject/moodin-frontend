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

  Color get statusColor {
    if (score >= 19) return Colors.red;
    if (score >= 17) return Colors.orange;
    if (score >= 14) return Colors.yellow;
    return Colors.green;
  }

  String get trafficLightAsset {
    if (score >= 19) return 'assets/images/redlight.png';
    if (score >= 17) return 'assets/images/yellowlight.png';
    if (score >= 14) return 'assets/images/yellowlight.png';
    return 'assets/images/greenlight.png';
  }

  String get getBubbleText {
    if (score >= 19) {
      return "0~13점 : 낮음 \n14~16점 : 보통\n17~18점 : 높음 \n19점 이상 : 매우 높음";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB3E5FC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF90A4AE)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Color(0xFF90A4AE)),
            onPressed: () {
              Navigator.pop(context); // 현재 페이지 pop
             Navigator.pop(context); // 이전 페이지 pop → 결국 이전이전 페이지로 이동
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/images/cloud.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            top: 20,
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
                  // Score Container
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: const [], // 그림자 제거
                    ),
                    child: Center(
                      child: Text(
                        "$score 점",
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF263238),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Result Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "자가진단 결과",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF37474F),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.play_arrow, color: Color(0xFF37474F)),
                      const SizedBox(width: 8),
                      Image.asset(
                        trafficLightAsset,
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  
                  // Result Description List
                  _buildResultDescription(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultDescription() {
    return Container(
      padding: const EdgeInsets.all(15), // 패딩 감소
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [], // 그림자 제거
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusItem(
              '0~13점',
              '당신이 느끼고 있는 스트레스 정도는 정상적인 수준으로, 심리적으로 안정되어 있습니다.',
              Colors.green),
          _buildStatusItem(
              '14~16점',
              '약간의 스트레스를 받고 계신 것으로 보입니다. 스트레스를 해소하기 위해 운동이나 가벼운 산책, 명상 등 자신만의 스트레스 해소법을 찾아보는 것이 좋겠습니다.',
              Colors.yellow),
          _buildStatusItem(
              '17~18점',
              '중간 정도의 스트레스를 받고 있는 것으로 보입니다. 스트레스 해소하기 위해 적극적인 노력을 하실 필요가 있으며, 원하신다면 전문가에게 도움을 요청해 보십시오.',
              Colors.orange),
          _buildStatusItem(
              '19점 이상',
              '심한 스트레스를 받고 있는 것으로 나타내고 있어, 일상생활에서 어려움을 겪고 있을 가능성이 높아 보입니다. 전문가와 자신의 상태에 대해 이야기해 볼 것을 권합니다.',
              Colors.red),
        ],
      ),
    );
  }

  Widget _buildStatusItem(
      String range, String description, Color indicatorColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: indicatorColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: '$range: ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 10, // 폰트 크기 감소
                ),
                children: [
                  TextSpan(
                    text: description,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey, // 글자 색상 변경
                      fontSize: 10, // 폰트 크기 감소
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}