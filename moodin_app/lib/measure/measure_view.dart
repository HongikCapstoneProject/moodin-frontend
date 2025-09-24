import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'measure_model.dart';
import 'measure_controller.dart';
import 'package:moodin_app/home/home_view.dart';
import 'package:moodin_app/result/result_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'gsr_stream.dart';
import 'package:moodin_app/main.dart';

class MeasureView extends StatefulWidget {
  const MeasureView({Key? key}) : super(key: key);

  @override
  State<MeasureView> createState() => _MeasureViewState();
}

class _MeasureViewState extends State<MeasureView> {
  late final MeasureModel _model;
  late final MeasureController _controller;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      // Provider에서 모델을 한 번만 가져옵니다.
      _model = Provider.of<MeasureModel>(context, listen: false);
      // 컨트롤러에 모델을 주입하고, 상태 변경 시 setState 호출
      _controller = MeasureController(
        _model,
        context.read<GsrBleClient>(),
      )
        ..addListener(() => setState(() {}));
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildMeasureResultCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF3F5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // 아이콘 + 레이블
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.favorite, color: Colors.red, size: 24),
                  SizedBox(width: 8),
                  Text(
                    'HRV',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF455A64),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Image.asset(
                      'assets/images/gsr.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'GSR',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF455A64),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // 측정값
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_model.hrv} ms',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                '${_model.gsrMavg} ms',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _starting = false;

  Widget _buildStartButton() {
  final model = Provider.of<MeasureModel>(context, listen: true);
  final disabled = _starting || model.isMeasuring;

  return SizedBox(
    width: double.infinity,
    height: 50,
    child: ElevatedButton(
      onPressed: disabled
          ? null
          : () async {
              setState(() => _starting = true);
              try {
                // 권한 요청이 따로 있다면 여기서 먼저 호출
                await requestBlePermissions();
                await _controller.startMeasurement(); // ← 비동기 호출
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('시작 실패: $e')));
              } finally {
                if (mounted) setState(() => _starting = false);
              }
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF8EC3D8),
        disabledBackgroundColor: const Color(0xFF8EC3D8).withOpacity(0.6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: _starting
          ? const SizedBox(
              width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
          : const Text(
              '측정 시작하기',
              style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
    ),
  );
}

  Widget _buildLoadingBox() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF8EC3D8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // build에서는 모델을 구독합니다.
    final model = Provider.of<MeasureModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.grey),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'GSR ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0077A3),
                        fontSize: 20,
                      ),
                    ),
                    TextSpan(
                      text: '측정은 어떻게 하나요?',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF333333),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/howtomeasure.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 30),

              if (model.isMeasuring) ...[
                _buildLoadingBox(),
              ] else if (model.isDone) ...[
                _buildMeasureResultCard(),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _controller.startMeasurement,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE0E0E0)),
                  child: const Text(
                    '다시 측정하기',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ResultView()),
                    ),
                    child: const Text(
                      '결과 보러가기 >',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ] else ...[
                _buildStartButton(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
