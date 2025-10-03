import 'package:flutter/material.dart';
import 'dart:async';

class HwabyeongMeasureView extends StatefulWidget {
  const HwabyeongMeasureView({Key? key}) : super(key: key);

  @override
  State<HwabyeongMeasureView> createState() => _HwabyeongMeasureViewState();
}

class _HwabyeongMeasureViewState extends State<HwabyeongMeasureView> {
  bool _isLoading = false;
  bool _isCompleted = false;

  void _startAnalysis() {
    // 이미 로딩 중이면 함수를 종료하여 중복 실행 방지
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _isCompleted = false;
    });

    Timer(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
        _isCompleted = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF263238)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home_outlined, color: Color(0xFF263238)),
            onPressed: () =>
                Navigator.of(context).popUntil((route) => route.isFirst),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                '16개 문항 중 해당되는 항목의 개수를 확인해 주세요.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF263238),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _buildSelfDiagnosisSection(),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _buildDiagnosisGraph(),
            ),
            const SizedBox(height: 30),
            _buildAnalysisResultSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSelfDiagnosisSection() {
    const questions = [
      '가슴이 답답하고 숨이 막히는 듯 하다.',
      '무언가 치밀어 오르는 느낌이 든다.',
      '열이 얼굴이나 가슴에 올라오는 느낌이 든다.',
      '목이나 명치에 무언가 뭉쳐진 것 같다.',
      '억울하고 분한 느낌이 든다.',
      '갑자기 화가 나고 분노가 치민다.',
      '가슴이 두근거린다.',
      '잠을 못 이루고 자주 깨며 아침에 일찍 일어난다.',
      '두통이나 어지럼증이 있다.',
      '입이 마르거나 목이 자주 마른다.',
      '식욕이 잘 생기지 않는다.',
      '두려운 생각이 자꾸 들고 쉽게 놀라는 증상이 있다.',
      '잡생각이 자꾸 든다.',
      '삶이 허무하고 우울하게 느껴진다.',
      '한숨을 자주 쉰다.',
      '모든 것이 한스럽게 느껴진다.',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '화병 자가진단',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF263238),
              ),
            ),
            Text(
              '출처 자하연 한의원',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...questions.asMap().entries.map((entry) {
          int index = entry.key;
          String text = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              '${index + 1} $text',
              style: const TextStyle(
                fontSize: 15,
                height: 1.6,
                color: Color(0xFF263238),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildDiagnosisGraph() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGraphTitle('화병 초기 증상'),
        _buildGraphBar('3개 이상', const Color(0xFF3e3e3e), 0.35),
        const SizedBox(height: 12),
        _buildGraphTitle('화병 으로 진단'),
        _buildGraphBar('7개 이상', Colors.black, 0.55),
        const SizedBox(height: 12),
        _buildGraphTitle('화병이 극심한 상태'),
        _buildGraphBar('12개 이상', const Color(0xFF5a2221), 0.85),
        const SizedBox(height: 8),
        const Text(
          '2차 정신과적 질환으로 발전하기 쉬운 만큼 조속한 치료가 필요합니다.',
          style: TextStyle(fontSize: 13, color: Color(0xFF6C757D)),
        ),
      ],
    );
  }

  Widget _buildGraphTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Color(0xFF263238),
      ),
    );
  }

  Widget _buildGraphBar(String label, Color color, double widthRatio) {
    return Container(
      height: 30,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: [
          FractionallySizedBox(
            widthFactor: widthRatio,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisResultSection() {
    return Container(
      width: double.infinity,
      color: const Color(0xFFE6F4FA),
      padding: const EdgeInsets.only(top: 24, left: 20, right: 20, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 16, color: Colors.black),
              children: [
                TextSpan(
                  text: "무딘",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(text: "님의 최근 7일간의 스트레스 신호 추이"),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // 흰색 카드
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 120),
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(20),
                // ▼ 여기가 핵심 수정 부분입니다.
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFFBEEAF6)),
                          strokeWidth: 4,
                        ),
                      )
                    : _isCompleted
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: "분석 결과, "),
                                    TextSpan(
                                      text: "화병이 의심",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(text: "됩니다."),
                                  ],
                                ),
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "스트레스 관리가 필요합니다.",
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 12),
                              Text(
                                "* 최근 7일 중 5일 이상 GSR 수치와 HRV 수치 모두 불안정 합니다.",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black54),
                              ),
                            ],
                          )
                        : null // 처음에는 아무것도 표시하지 않음
                ),
          ),
          const SizedBox(height: 16),
          // 버튼 (카드 밖)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              // ▼ 로딩 중일 때 버튼 비활성화
              onPressed: _isLoading ? null : _startAnalysis,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _isCompleted ? Colors.grey.shade300 : Colors.white,
                // ▼ 비활성화 시 색상 지정 (선택사항)
                disabledBackgroundColor: Colors.grey.shade200,
                side: const BorderSide(color: Colors.black),
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Text(
                _isLoading
                    ? '분석 중...'
                    : _isCompleted
                        ? '다시 분석하기'
                        : '분석 하기',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          // ▼ 기존에 있던 로딩 위젯은 삭제합니다.
        ],
      ),
    );
  }
}
