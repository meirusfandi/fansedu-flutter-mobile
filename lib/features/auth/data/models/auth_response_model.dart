import 'package:fansedu_flutter_mobile/features/auth/data/models/user_model.dart';

class AuthResponseModel {
  AuthResponseModel({required this.token, required this.user});

  final String token;
  final UserModel user;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      token: json['token'] as String? ?? json['access_token'] as String? ?? '',
      user: UserModel.fromJson(
        (json['user'] as Map<String, dynamic>?) ?? {},
      ),
    );
  }
}
