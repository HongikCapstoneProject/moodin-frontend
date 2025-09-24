import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

final serviceUuid = Guid("b3b8c464-9e54-4b71-9c39-4f2b4f9a0001");
final charUuid    = Guid("b3b8c464-9e54-4b71-9c39-4f2b4f9a0002");
const targetLocalName = "Nano33BLE-GSR";

class GsrBleClient {
  BluetoothDevice? _device;
  BluetoothCharacteristic? _ch;

  StreamSubscription<List<ScanResult>>? _scanSub;
  StreamSubscription<List<int>>? _notifySub;
  StreamSubscription<BluetoothConnectionState>? _connSub;

  bool _busy = false;

  /// 스캔→연결→Notify 구독까지 수행하고 mavg(이동평균)만 Stream으로 방출
  Stream<double> startStream() {
    // 외부에서 listen 할 StreamController
    final controller = StreamController<double>(
      onCancel: () async {
        // 외부에서 구독을 끊으면 BLE 정리
        await stop();
      },
    );

    () async {
      if (_busy) return;
      _busy = true;
      try {
        await _stopScanSafe();

        // 어댑터 체크
        final state = await FlutterBluePlus.adapterState.first;
        if (state != BluetoothAdapterState.on) {
          throw Exception("Bluetooth 꺼져 있음");
        }

        // 스캔 시작 (서비스 UUID 필터 + 로컬네임 매칭)
        await FlutterBluePlus.startScan(
          withServices: [serviceUuid],
          timeout: const Duration(seconds: 8),
        );

        final completer = Completer<ScanResult>();
        _scanSub = FlutterBluePlus.scanResults.listen((list) {
          for (final r in list) {
            final ad = r.advertisementData;
            final byName = (ad.localName ?? "").contains(targetLocalName);
            final bySvc  = ad.serviceUuids
                .map((e) => e.toString().toLowerCase())
                .contains(serviceUuid.toString().toLowerCase());

            if (byName || bySvc) {
              if (!completer.isCompleted) completer.complete(r);
            }
          }
        }, onError: (e, st) {
          if (!completer.isCompleted) completer.completeError(e, st);
        });

        // 첫 매치 기다림
        final result = await completer.future.timeout(
          const Duration(seconds: 10),
          onTimeout: () => throw Exception("스캔 타임아웃: 기기 발견 못함"),
        );

        await _stopScanSafe();

        _device = result.device;

        // 연결 (v2: license 필수)
        // 최신 flutter_blue_plus에서는 autoConnect 파라미터가 있을 수 있음(버전별 상이)
        // 에디터 빨간줄 뜨면 해당 파라미터는 지워도 됨.
        try {
          if (!await _device!.isConnected) {
            await _device!.connect(
              license: License.free,                 // ✅ 필수
              timeout: const Duration(seconds: 12),  // 권장
              // autoConnect: false,                 // 버전별 지원 여부 상이
            );
          }
        } catch (e) {
          // 이미 연결 중/연결됨 예외 방어
          debugPrint("connect() warn: $e");
        }

        // 연결 상태 모니터링
        await _connSub?.cancel();
        _connSub = _device!.connectionState.listen((s) async {
          if (s == BluetoothConnectionState.disconnected) {
            debugPrint("BLE disconnected");
            // 스트림을 닫아 상위에 알리고 리소스 정리
            await stop();
            if (!controller.isClosed) {
              await controller.close();
            }
          }
        });

        // 서비스/특성 찾기
        final services = await _device!.discoverServices();
        final service = services.firstWhere(
          (s) => s.uuid == serviceUuid,
          orElse: () => throw Exception("Service ${serviceUuid.toString()} 없음"),
        );
        final ch = service.characteristics.firstWhere(
          (c) => c.uuid == charUuid,
          orElse: () => throw Exception("Characteristic ${charUuid.toString()} 없음"),
        );

        if (!ch.properties.notify && !ch.properties.indicate) {
          throw Exception("특성이 notify/indicate 미지원 (아두이노 BLENotify 필요)");
        }

        _ch = ch;
        await _ch!.setNotifyValue(true);

        // 기존 구독 제거 후 새로 구독
        await _notifySub?.cancel();
        _notifySub = _ch!.onValueReceived.listen((value) {
          if (value.length >= 8) {
            final b = ByteData.sublistView(Uint8List.fromList(value));
            // [0..3] int32 raw, [4..7] float mavg (LE)
            // final raw = b.getInt32(0, Endian.little);
            final mavg = b.getFloat32(4, Endian.little);
            if (!controller.isClosed) {
              controller.add(mavg); // ✅ mavg만 방출
            }
          } else {
            debugPrint("short packet: ${value.length} bytes");
          }
        }, onError: (e, st) async {
          debugPrint("notify error: $e");
          if (!controller.isClosed) {
            controller.addError(e, st);
            await controller.close();
          }
        });

        debugPrint("BLE ready (connected & subscribed)");
      } catch (e, st) {
        debugPrint("startStream() error: $e\n$st");
        await stop();
        if (!controller.isClosed) {
          controller.addError(e, st);
          await controller.close();
        }
      } finally {
        _busy = false;
      }
    }();

    // 바깥에 Stream 반환
    return controller.stream;
  }

  /// 연결/스캔/구독 정리
  Future<void> stop() async {
    try {
      await _notifySub?.cancel();
      _notifySub = null;

      if (_ch != null) {
        try { await _ch!.setNotifyValue(false); } catch (_) {}
      }

      await _connSub?.cancel();
      _connSub = null;

      if (_device != null) {
        try { await _device!.disconnect(); } catch (_) {}
      }
      _device = null;
      _ch = null;

      await _stopScanSafe();
    } catch (e) {
      debugPrint("stop() error: $e");
    }
  }

  Future<void> _stopScanSafe() async {
    try { await _scanSub?.cancel(); } catch (_) {}
    _scanSub = null;
    try { await FlutterBluePlus.stopScan(); } catch (_) {}
  }
}