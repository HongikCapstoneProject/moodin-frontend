import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'measure_model.dart';
import 'measure_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:moodin_app/result/result_view.dart';

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
      _model = Provider.of<MeasureModel>(context, listen: false);
      _controller = MeasureController(_model)
        ..addListener(() => setState(() {}));
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// --------------------------
  /// 파일 업로드 팝업
  /// --------------------------
  Future<void> _showFileUploadDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            '파일 업로드',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('측정을 시작하기 전에 업로드할 파일을 선택해주세요.'),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.upload_file),
                label: const Text('파일 선택'),
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles();
                  if (result != null && result.files.isNotEmpty) {
                    final selectedName = result.files.single.name;
                    _controller.setUploadedFileName(selectedName);
                    Navigator.pop(context);
                    _controller.startMeasurement();
                  }
                },
              ),
              if (_model.uploadedFileName != null) ...[
                const SizedBox(height: 8),
                Text(
                  '선택된 파일: ${_model.uploadedFileName}',
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('취소'),
            ),
          ],
        );
      },
    );
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
                        color: Color(0xFF455A64)),
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
                    child: Image(
                      image: AssetImage('assets/images/gsr.png'),
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
                        color: Color(0xFF455A64)),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_model.hrv} ms',
                style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                '${_model.gsr} ms',
                style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStartButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _showFileUploadDialog,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8EC3D8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
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
                          fontSize: 20),
                    ),
                    TextSpan(
                      text: '측정은 어떻게 하나요?',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF333333),
                          fontSize: 20),
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
                if (model.uploadedFileName != null)
                  Text(
                    '업로드된 파일: ${model.uploadedFileName}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _showFileUploadDialog,
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
                      MaterialPageRoute(builder: (_) => const ResultView()),
                    ),
                    child: const Text(
                      '결과 보러가기 >',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
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
