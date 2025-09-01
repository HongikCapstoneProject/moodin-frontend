// lib/signup/signup_response.dart
class SignupResponse {
  final dynamic userId; // Long/UUID 어떤 형태든 받기 위해 dynamic
  final String username;
  final String token;

  SignupResponse({
    required this.userId,
    required this.username,
    required this.token,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      userId: json['userId'],
      username: json['username'] as String,
      token: json['token'] as String,
    );
  }
}
