// lib/signup/signup_controller.dart
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'signup_model.dart';
import 'signup_response.dart';
import 'dart:io' show Platform;

class SignupController {
  final SignupModel model;
  final Function(String) onError;
  final Function(SignupResponse) onSuccess;

  SignupController({
    required this.model,
    required this.onError,
    required this.onSuccess,
  });

  String get baseUrl {
    if (kIsWeb) return 'http://localhost:8080';
    if (Platform.isAndroid) return 'http://10.0.2.2:8080';
    return 'http://localhost:8080'; // macOS/iOS/Windows/Linux 데스크탑 기본
  }

  void onNicknameChanged(String value) {
    model.nickname = value;
  }

  void onEmailChanged(String value) {
    model.email = value;
  }

  void onPasswordChanged(String value) {
    model.password = value;
  }

  /// 회원가입 실행
  Future<void> submit() async {
    if (!model.isValid()) {
      onError('모든 필드를 입력해주세요.');
      return;
    }

    try {
      final url = Uri.parse('$baseUrl/auth/signup');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "username": model.email,    // 서버에서 username으로 사용
          "password": model.password, // 서버 요구사항
        }),
      );

      // 디버깅 로그
      // ignore: avoid_print
      print('[SIGNUP] status=${response.statusCode} body=${response.body}');

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final signupResponse = SignupResponse.fromJson(data);
        onSuccess(signupResponse);
      } else if (response.statusCode == 409) {
        onError("이미 존재하는 사용자입니다.");
      } else {
        onError("회원가입 실패: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      onError("네트워크 오류: $e");
    }
  }
}
