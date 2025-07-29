import 'package:flutter/material.dart';
import 'survey_model.dart';
import 'survey_result_view.dart';

class SurveyController {
  void submit(BuildContext context) {
    final model = SurveyModel.of(context, listen: false);
    final score = model.totalScore;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SurveyResultView(score: score),
      ),
    );
  }
}
