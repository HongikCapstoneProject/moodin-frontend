/*import 'package:flutter/material.dart';

enum MeasureState { idle, measuring, done }

enum StressLevel { low, normal, high }

class MeasureModel extends ChangeNotifier {
  bool isMeasuring = false;
  bool isDone = false;

  int hrv = 0;
  int gsr = 0;

  void setMeasuredValues({required int newHrv, required int newGsr}) {
    hrv = newHrv;
    gsr = newGsr;
    isDone = true;
    notifyListeners();
  }

  StressLevel get stressLevel {
    final score = hrv + gsr;
    if (score >= 160) {
      return StressLevel.high;
    } else if (score >= 120) {
      return StressLevel.normal;
    } else {
      return StressLevel.low;
    }
  }
}*/
import 'package:flutter/material.dart';

enum MeasuremState { idle, measuring, done }

class MeasureModel extends ChangeNotifier {
  bool isMeasuring = false;
  bool isDone = false;

  int hrv = 0;
  int gsr = 0;
}
