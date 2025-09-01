import 'package:flutter/material.dart';
import 'signup_model.dart';
import 'signup_controller.dart';
import 'signup_response.dart'; // ✅ 성공 콜백으로 받는 응답 DTO

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late final SignupModel _model;
  late final SignupController _controller;

  bool _loading = false; // ✅ 로딩 상태

  @override
  void initState() {
    super.initState();
    _model = SignupModel();
    _controller = SignupController(
      model: _model,
      onError: (msg) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg)),
        );
      },
      // ✅ SignupResponse를 매개변수로 받도록 시그니처 수정
      onSuccess: (SignupResponse res) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('회원가입 완료: ${res.username}\n토큰: ${res.token}')),
        );
        // TODO: 필요시 토큰 저장/화면 전환
        // Navigator.pop(context);
        // Navigator.pushReplacementNamed(context, '/home');
      },
    );
  }

  Widget _buildTextField(String label, String hint, bool obscure, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 4),
        TextField(
          obscureText: obscure,
          onChanged: onChanged,
          enabled: !_loading,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFE0E0E0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Future<void> _onSubmit() async {
    if (_loading) return;
    setState(() => _loading = true);
    await _controller.submit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('mood in', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xFF0077A3))),
              const Text('회원가입', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF3A3A3A))),
              const SizedBox(height: 40),
              _buildTextField('닉네임', '닉네임을 입력하세요', false, _controller.onNicknameChanged),
              _buildTextField('이메일', '이메일을 입력하세요', false, _controller.onEmailChanged),
              _buildTextField('비밀번호', '비밀번호를 입력하세요', true, _controller.onPasswordChanged),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF455A64),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _loading ? null : _onSubmit,
                  child: _loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('회원가입', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              TextButton(
                onPressed: _loading ? null : () => Navigator.pop(context),
                child: const Text('이전', style: TextStyle(color: Colors.black54)),
              )
            ],
          ),
        ),
      ),
    );
  }
}