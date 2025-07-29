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
      "지난 한 달 동안, 예상치 못한 일이 생겨서 기분 나빠진 적이 얼마나 있었나요?",
      "지난 한 달 동안, 중요한 일들을 통제할 수 없다고 느낀 적은 얼마나 있었나요?",
      "지난 한 달 동안, 초조하거나 스트레스가 쌓인다고 느낀 적은 얼마나 있었나요?",
      "지난 한 달 동안, 짜증나고 성가신 일들을 성공적으로 처리한 적이 얼마나 있었나요?",
      "지난 한 달 동안, 생활 속에서 일어나는 중요한 변화들을 효과적으로 대처한 적이 얼마나 있었나요?",
      "지난 한 달 동안, 개인적 문제를 처리하는 능력에 대해 자신감을 느낀 적이 얼마나 있었나요?",
      "지난 한 달 동안, 자신의 뜻대로 일이 진행된다고 느낀 적이 얼마나 있었나요?",
      "지난 한 달 동안, 예상한 통제를 잘 컨트롤하고 있다고 느낀 적이 얼마나 있었나요?",
      "지난 한 달 동안, 어려움에 부딪혔을 때 효과적으로 대처한 적이 얼마나 있었나요?",
      "지난 한 달 동안, 어려운 일이 너무 많아서 극복할 수 없다고 느낀 적이 얼마나 있었나요?",
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFB3E5FC),
      appBar: AppBar(
        title: const Text("스트레스 자가진단"),
        backgroundColor: const Color(0xFF4FC3F7),
        elevation: 0,
      ),
      body: Consumer<SurveyModel>(
        builder: (context, model, _) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: questions.length + 1,
            itemBuilder: (context, index) {
              if (index < questions.length) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(questions[index]),
                    trailing: DropdownButton<int>(
                      value: model.answers[index],
                      items: const [
                        DropdownMenuItem(value: 0, child: Text("선택")),
                        DropdownMenuItem(value: 3, child: Text("매우 그렇다")),
                        DropdownMenuItem(value: 2, child: Text("보통이다")),
                        DropdownMenuItem(value: 1, child: Text("전혀 아니다")),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          model.setAnswer(index, value);
                        }
                      },
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: ElevatedButton(
                    onPressed: () => controller.submit(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "결과 보러가기 >",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
