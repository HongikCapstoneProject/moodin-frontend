import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'measure_model.dart';
import 'gsr_stream.dart';

// ====== Controller ======
class MeasureController extends ChangeNotifier {
  final MeasureModel model;
  final GsrBleClient ble;
  StreamSubscription<double>? _sub;

  MeasureController(this.model, this.ble);

  Future<void> startMeasurement() async {
    if (_sub != null) return;          // 중복 구독 방지
    model.isMeasuring = true;
    model.isDone = false;
    notifyListeners();

    _sub = ble.startStream().listen((mavg) {
      model.gsrMavg = mavg;
      model.isMeasuring = true;
      model.isDone = false;
      notifyListeners();
    }, onError: (e) {
      model.isMeasuring = true;
      notifyListeners();
    });
  }

  Future<void> stopMeasurement() async {
    await _sub?.cancel();
    _sub = null;
    await ble.stop();
    model.isMeasuring = false;
    model.isDone = true;
    notifyListeners();
  }
}