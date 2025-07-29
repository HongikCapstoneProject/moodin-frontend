import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurveyModel extends ChangeNotifier {
  final List<int> _answers = List.filled(10, 0);

  List<int> get answers => _answers;

  void setAnswer(int index, int value) {
    _answers[index] = value;
    notifyListeners();
  }

  int get totalScore => _answers.fold(0, (a, b) => a + b);

  // context에서 쉽게 접근하기 위한 helper 메서드
  static SurveyModel of(BuildContext context, {bool listen = true}) {
    return Provider.of<SurveyModel>(context, listen: listen);
  }
}
