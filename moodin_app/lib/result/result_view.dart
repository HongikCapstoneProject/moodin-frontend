// import 'package:flutter/material.dart';
// import 'result_controller.dart';
// import 'package:moodin_app/home/home_view.dart';

// class ResultView extends StatelessWidget {
//   const ResultView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = ResultController();
//     final user = controller.getResultUser();

//     // 예시 값 (필요하면 controller에서 가져오도록 수정 가능)
//     const double hrvValue = 30; // ms
//     const double gsrValue = 57; // ms

//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F7F8),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF7F7F8),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           color: const Color(0xFF6E7376),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.home),
//             color: const Color(0xFF6E7376),
//             onPressed: () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => HomeView(username: user.nickname),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 닉네임
//             Text.rich(
//               TextSpan(
//                 children: [
//                   TextSpan(
//                     text: user.nickname,
//                     style: const TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xFF0077A3),
//                     ),
//                   ),
//                   const TextSpan(
//                     text: ' 님',
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xFF2F3A3F),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 12),

//             // 타이틀 (가운데)
//             Align(
//               alignment: Alignment.center,
//               child: const Text(
//                 '오늘의 스트레스 수준',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF2F3A3F),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 18),

//             // 빨간불 박스
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFE9F4FB),
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.black,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: const [
//                         CircleAvatar(
//                           radius: 6,
//                           backgroundColor: Color(0xFF3A3A3A),
//                         ),
//                         SizedBox(width: 6),
//                         CircleAvatar(
//                           radius: 6,
//                           backgroundColor: Color(0xFF3A3A3A),
//                         ),
//                         SizedBox(width: 6),
//                         CircleAvatar(
//                           radius: 6,
//                           backgroundColor: Colors.red,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   const Text(
//                     '빨간불',
//                     style: TextStyle(
//                         color: Colors.red,
//                         fontWeight: FontWeight.w700,
//                         fontSize: 16),
//                   ),
//                   const SizedBox(width: 8),
//                   const Icon(Icons.play_arrow,
//                       color: Color.fromARGB(255, 42, 42, 42)),
//                   const SizedBox(width: 6),
//                   const Text(
//                     '너무 높아요 !!',
//                     style: TextStyle(
//                         color: Color(0xFF2F3A3F),
//                         fontWeight: FontWeight.w700,
//                         fontSize: 16),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 18),

//             // HRV & GSR 카드
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: _buildStatusCard(
//                     emoji: '❤️',
//                     title: 'HRV',
//                     valueText: '$hrvValue ms',
//                     position: 0.92,
//                     tooltipMessage:
//                         'HRV: 심박 변이도(Heart Rate Variability)를 의미합니다.',
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: _buildStatusCard(
//                     emoji: '✋',
//                     title: 'GSR',
//                     valueText: '$gsrValue ms',
//                     position: 0.72,
//                     tooltipMessage:
//                         'GSR: 피부 전기 반응(Galvanic Skin Response)를 의미합니다.',
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 28),
//             const Divider(color: Color(0xFFE6E9EA), height: 8, thickness: 1),
//             const SizedBox(height: 18),

//             // 맞춤 해소법 제목
//             Text.rich(
//               TextSpan(
//                 children: [
//                   TextSpan(
//                     text: user.nickname,
//                     style: const TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF0077A3),
//                     ),
//                   ),
//                   const TextSpan(
//                     text: '님 맞춤 스트레스 해소법',
//                     style: TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xFF2F3A3F),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 14),

//             // 그라운딩 카드 (five.png 반투명 배치)
//             Stack(
//               children: [
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         '5-4-3-2-1 그라운딩 기법',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF0077A3),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       const Text(
//                         '5-4-3-2-1 기법은 보이는 것 5가지, 느껴지는 것 4가지, 들리는 소리 3가지, 말할 수 있는 냄새 2가지, 맛볼 수 있는 것 1가지를 구체적으로 말하거나 생각하는 방식으로 진행되어 불안이나 트라우마로 인한 플래시백 증상을 완화하기 위해 사용되는 그라운딩 기법 중 하나입니다.',
//                         style: TextStyle(
//                             fontSize: 16,
//                             height: 1.6,
//                             color: Color(0xFF555B60)),
//                       ),
//                       const SizedBox(height: 14),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 8),
//                         child: Column(
//                           children: [
//                             _buildLabeledInput(
//                               '5가지 보이는 것 말하기',
//                               placeholder:
//                                   '예) "책상 위에 있는 파란색 펜", "창밖의 초록색 나무" 등',
//                             ),
//                             _buildLabeledInput(
//                               '4가지 느껴지는 것 말하기',
//                               placeholder:
//                                   '예) "발바닥으로 느껴지는 바닥의 차가움", "옷이 몸에 닿는 느낌" 등',
//                             ),
//                             _buildLabeledInput(
//                               '3가지 들리는 소리 말하기',
//                               placeholder: '예) "자동차 소리", "사람들의 이야기 소리" 등',
//                             ),
//                             _buildLabeledInput(
//                               '2가지 냄새 말하기',
//                               placeholder: '예) "커피 향", "비 오는 냄새" 등',
//                             ),
//                             _buildLabeledInput(
//                               '1가지 맛 말하기',
//                               placeholder: '예) "커피 맛", "빵 맛" 등',
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Center(
//                   child: Opacity(
//                     opacity: 0.1,
//                     child: Image.asset(
//                       'assets/images/five.png',
//                       width: 180,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 24),

//             // 상담 카드
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(18),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.08),
//                     blurRadius: 8,
//                     offset: const Offset(0, 6),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       Icon(Icons.call, size: 20, color: Color(0xFF4B5660)),
//                       SizedBox(width: 8),
//                       Text(
//                         '전문가 도움 연결',
//                         style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w700,
//                             color: Color(0xFF2F3A3F)),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     '계속 불안하고 도움이 필요하다면?',
//                     style: TextStyle(fontSize: 14, color: Color(0xFF6B7176)),
//                   ),
//                   const SizedBox(height: 14),
//                   Image.asset('assets/images/call.png', width: 110),
//                   const SizedBox(height: 10),
//                   const Text(
//                     '상담 센터나 심리지원 기관을 알려드릴게요.',
//                     style: TextStyle(fontSize: 13.5, color: Color(0xFF6B7176)),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 36),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStatusCard({
//     required String emoji,
//     required String title,
//     required String valueText,
//     required double position,
//     required String tooltipMessage,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(top: 4),
//       padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
//       decoration: BoxDecoration(
//         color: const Color(0xFFE9F4FB),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Stack(
//             children: [
//               // 이모지 + 텍스트 (왼쪽 정렬)
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(emoji, style: const TextStyle(fontSize: 26)),
//                   const SizedBox(width: 6),
//                   Text(
//                     title,
//                     style: const TextStyle(
//                         fontWeight: FontWeight.w800, fontSize: 16),
//                   ),
//                 ],
//               ),
//               // 오른쪽 위 물음표 아이콘 + 툴팁
//               Positioned(
//                 right: 0,
//                 top: 0,
//                 child: Tooltip(
//                   message: tooltipMessage,
//                   waitDuration: const Duration(milliseconds: 300),
//                   child: const Icon(
//                     Icons.help_outline,
//                     size: 18,
//                     color: Color(0xFF474E52),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Text(
//             valueText,
//             style: const TextStyle(
//                 fontSize: 36,
//                 fontWeight: FontWeight.w900,
//                 color: Color(0xFF151515)),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 12),
//           LayoutBuilder(builder: (context, constraints) {
//             final barWidth = constraints.maxWidth;
//             const barHeight = 14.0;
//             const dotSize = 18.0;
//             double left = (barWidth - dotSize) * position;
//             if (left < 0) left = 0;
//             if (left > barWidth - dotSize) left = barWidth - dotSize;

//             return SizedBox(
//               height: barHeight + dotSize / 2,
//               child: Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   Container(
//                     height: barHeight,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       gradient: const LinearGradient(
//                         colors: [
//                           Color(0xFF4FC24F),
//                           Color(0xFFF2D541),
//                           Color(0xFFEF6C4A),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: left,
//                     top: -((dotSize - barHeight) / 2),
//                     child: Container(
//                       width: dotSize,
//                       height: dotSize,
//                       decoration: const BoxDecoration(
//                         color: Colors.black,
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }),
//         ],
//       ),
//     );
//   }

//   Widget _buildLabeledInput(String title,
//       {required String placeholder, bool purpleBorder = false}) {
//     final borderColor =
//         purpleBorder ? const Color(0xFF6E4BD6) : const Color(0xFFBFC5C8);
//     final focusColor =
//         purpleBorder ? const Color(0xFF6E4BD6) : const Color(0xFF8E9699);

//     return Padding(
//       padding: const EdgeInsets.only(top: 12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w700,
//                 color: Color.fromARGB(255, 29, 44, 50)),
//           ),
//           const SizedBox(height: 8),
//           TextField(
//             maxLines: 1,
//             decoration: InputDecoration(
//               hintText: placeholder,
//               hintStyle:
//                   const TextStyle(fontSize: 13.5, color: Color(0xFF9EA4A7)),
//               contentPadding:
//                   const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(color: borderColor, width: 1.6),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(color: focusColor, width: 2),
//               ),
//             ),
//             style: const TextStyle(fontSize: 14, color: Color(0xFF222629)),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'result_controller.dart';
import 'package:moodin_app/home/home_view.dart';

class ResultView extends StatefulWidget {
  const ResultView({super.key});

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  int countdown = 30;
  Timer? _timer;
  final TextEditingController reflectController = TextEditingController();
  int selectedChoiceIndex = -1;

  void startTimer() {
    _timer?.cancel();
    setState(() => countdown = 30);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() => countdown--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    reflectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ResultController();
    final user = controller.getResultUser();

    const double hrvValue = 30;
    const double gsrValue = 57;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xFF6E7376),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            color: const Color(0xFF6E7376),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeView(username: user.nickname)),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 닉네임
            Text.rich(TextSpan(children: [
              TextSpan(
                text: user.nickname,
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0077A3)),
              ),
              const TextSpan(
                text: ' 님',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2F3A3F)),
              ),
            ])),
            const SizedBox(height: 12),

            const Align(
              alignment: Alignment.center,
              child: Text(
                '오늘의 스트레스 수준',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F3A3F)),
              ),
            ),
            const SizedBox(height: 18),

            // 🟡 노란불 박스
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                  color: const Color(0xFFE9F4FB),
                  borderRadius: BorderRadius.circular(14)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        CircleAvatar(radius: 6, backgroundColor: Colors.grey),
                        SizedBox(width: 6),
                        CircleAvatar(radius: 6, backgroundColor: Colors.grey),
                        SizedBox(width: 6),
                        CircleAvatar(radius: 6, backgroundColor: Colors.yellow),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text('노란불',
                      style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.w700,
                          fontSize: 16)),
                  const SizedBox(width: 8),
                  const Icon(Icons.play_arrow,
                      color: Color.fromARGB(255, 42, 42, 42)),
                  const SizedBox(width: 6),
                  const Text('유지하세요 ~',
                      style: TextStyle(
                          color: Color(0xFF2F3A3F),
                          fontWeight: FontWeight.w700,
                          fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // HRV & GSR 카드
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildStatusCard(
                    emoji: '❤️',
                    title: 'HRV',
                    valueText: '$hrvValue ms',
                    position: 0.55,
                    tooltipMessage:
                        'HRV: 심박 변이도(Heart Rate Variability)를 의미합니다.',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatusCard(
                    emoji: '✋',
                    title: 'GSR',
                    valueText: '$gsrValue ms',
                    position: 0.65,
                    tooltipMessage:
                        'GSR: 피부 전기 반응(Galvanic Skin Response)를 의미합니다.',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            const Divider(color: Color(0xFFE6E9EA), height: 8, thickness: 1),
            const SizedBox(height: 18),

            // 맞춤 해소법 제목
            Text.rich(TextSpan(children: [
              TextSpan(
                text: user.nickname,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0077A3)),
              ),
              const TextSpan(
                text: '님 맞춤 스트레스 해소법',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2F3A3F)),
              ),
            ])),
            const SizedBox(height: 14),

            // 🔹 SBRC 기법 (박스 제거)
            const Text(
              'SBRC 기법',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0077A3)),
            ),
            const SizedBox(height: 10),
            const Text(
              'SBRC는 Stop-Breathe-Reflect-Choose의 약자로, 멈추어 30초간 숨을 쉬고 텍스트로 상황을 적은 후 어떻게 할지 고르는 방식입니다. 이는 반사적인 부정 반응을 줄이고 의식적 대응을 유도해줍니다.',
              style: TextStyle(
                  fontSize: 16, height: 1.6, color: Color(0xFF555B60)),
            ),
            const SizedBox(height: 20),

            // 4단계 아이콘
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _IconButtonWithLabel(icon: Icons.pause, label: 'Stop'),
                _IconButtonWithLabel(icon: Icons.air, label: 'Breathe'),
                _IconButtonWithLabel(icon: Icons.self_improvement, label: 'Reflect'),
                _IconButtonWithLabel(icon: Icons.check_circle_outline, label: 'Choose'),
              ],
            ),
            const SizedBox(height: 24),

            // 타이머 (Breathe)
            GestureDetector(
              onTap: startTimer,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFFBFC5C8)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFF555B60), width: 2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          '$countdown',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text('30초 동안 숨 쉬기',
                        style: TextStyle(
                            fontSize: 18, color: Color(0xFF2F3A3F))),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Reflect 입력 박스
            const Text('Reflect',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0077A3))),
            const SizedBox(height: 6),
            TextField(
              controller: reflectController,
              decoration: InputDecoration(
                hintText: '지금 떠오르는 감정을 적어보세요.',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF0077A3)),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
            const SizedBox(height: 20),

            // Choose 선택
            const Text('Choose',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0077A3))),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: List.generate(3, (index) {
                final labels = ['커피 마시기', '산책하기', '명상하기'];
                final isSelected = selectedChoiceIndex == index;
                return ChoiceChip(
                  label: Text(labels[index]),
                  selected: isSelected,
                  selectedColor: const Color(0xFF0077A3),
                  backgroundColor: const Color(0xFFE0E0E0),
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  onSelected: (selected) {
                    setState(() {
                      selectedChoiceIndex = selected ? index : -1;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard({
    required String emoji,
    required String title,
    required String valueText,
    required double position,
    required String tooltipMessage,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F4FB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(emoji, style: const TextStyle(fontSize: 26)),
                const SizedBox(width: 6),
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 16)),
              ],
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Tooltip(
                message: tooltipMessage,
                waitDuration: const Duration(milliseconds: 300),
                child: const Icon(Icons.help_outline,
                    size: 18, color: Color(0xFF474E52)),
              ),
            ),
          ]),
          const SizedBox(height: 12),
          Text(valueText,
              style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF151515)),
              textAlign: TextAlign.center),
          const SizedBox(height: 12),
          LayoutBuilder(builder: (context, constraints) {
            final barWidth = constraints.maxWidth;
            const barHeight = 14.0;
            const dotSize = 18.0;
            double left = (barWidth - dotSize) * position;
            left = left.clamp(0, barWidth - dotSize);

            return SizedBox(
              height: barHeight + dotSize / 2,
              child: Stack(clipBehavior: Clip.none, children: [
                Container(
                  height: barHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(colors: [
                      Color(0xFF4FC24F),
                      Color(0xFFF2D541),
                      Color(0xFFEF6C4A),
                    ]),
                  ),
                ),
                Positioned(
                  left: left,
                  top: -((dotSize - barHeight) / 2),
                  child: Container(
                      width: dotSize,
                      height: dotSize,
                      decoration: const BoxDecoration(
                          color: Colors.black, shape: BoxShape.circle)),
                ),
              ]),
            );
          }),
        ],
      ),
    );
  }
}

class _IconButtonWithLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  const _IconButtonWithLabel({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 3))
              ]),
          padding: const EdgeInsets.all(10),
          child: Icon(icon, size: 28, color: const Color(0xFF4B5660)),
        ),
        const SizedBox(height: 6),
        Text(label,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2F3A3F))),
      ],
    );
  }
}