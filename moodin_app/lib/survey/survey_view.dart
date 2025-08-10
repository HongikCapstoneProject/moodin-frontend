import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'survey_model.dart';
import 'survey_controller.dart';

class SurveyView extends StatelessWidget {
  const SurveyView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SurveyController();
    final questions = [
      "1. 지난 한 달 동안, 예상치 못한 일이 생겨서 기분 나빠진 적이 얼마나 있었나요?",
      "2. 지난 한 달 동안, 중요한 일들을 통제할 수 없다고 느낀 적은 얼마나 있었나요?",
      "3. 지난 한 달 동안, 초조하거나 스트레스가 쌓인다고 느낀 적은 얼마나 있었나요?",
      "4. 지난 한 달 동안, 짜증나고 성가신 일들을 성공적으로 처리한 적이 얼마나 있었나요?",
      "5. 지난 한 달 동안, 생활 속에서 일어나는 중요한 변화들을 효과적으로 대처한 적이 얼마나 있었나요?",
      "6. 지난 한 달 동안, 개인적 문제를 처리하는 능력에 대해 자신감을 느낀 적이 얼마나 있었나요?",
      "7. 지난 한 달 동안, 자신의 뜻대로 일이 진행된다고 느낀 적이 얼마나 있었나요?",
      "8. 지난 한 달 동안, 예상한 통제를 잘 컨트롤하고 있다고 느낀 적이 얼마나 있었나요?",
      "9. 지난 한 달 동안, 어려움에 부딪혔을 때 효과적으로 대처한 적이 얼마나 있었나요?",
      "10. 지난 한 달 동안, 어려운 일이 너무 많아서 극복할 수 없다고 느낀 적이 얼마나 있었나요?",
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB3E5FC), Color(0xFFB3E5FC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 상단 영역
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 첫 번째 줄: 이전, 홈 버튼
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.grey),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.home, color: Colors.grey),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // 두 번째 줄: 제목
                    const Text(
                      "스트레스 자가진단",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF263238),
                      ),
                    ),
                  ],
                ),
              ),

              // 본문 영역
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: Consumer<SurveyModel>(
                    builder: (context, model, _) {
                      return ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: questions.length + 2, // 출처 텍스트 포함
                        separatorBuilder: (context, index) => const Divider(
                          color: Color.fromARGB(217, 241, 241, 241),
                          thickness: 1,
                          height: 1,
                        ),
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            // 출처 + 간격
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "출처 : 서울대학교 간호학연구소 - 한국판 지각된 스트레스 척도(perceived stress scale : PSS)",
                                  style: TextStyle(
                                    fontSize: 8, 
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 20), // 출처와 첫 질문 사이 간격
                              ],
                            );
                          } else if (index <= questions.length) {
                            // 질문 항목
                            return ListTile(
                              title: Text(
                                questions[index - 1],
                                style: const TextStyle(fontSize: 15),
                              ),
                              trailing: DropdownButton<int>(
                                value: model.answers[index - 1],
                                underline: const SizedBox(),
                                items: const [
                                  DropdownMenuItem(value: 0, child: Text("선택")),
                                  DropdownMenuItem(value: 3, child: Text("매우 그렇다")),
                                  DropdownMenuItem(value: 2, child: Text("보통이다")),
                                  DropdownMenuItem(value: 1, child: Text("전혀 아니다")),
                                ],
                                onChanged: (value) {
                                  if (value != null) {
                                    model.setAnswer(index - 1, value);
                                  }
                                },
                              ),
                            );
                          } else {
                            // 결과 버튼
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: ElevatedButton(
                                onPressed: () => controller.submit(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4FC3F7),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 32),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  "결과 보러가기 >",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
