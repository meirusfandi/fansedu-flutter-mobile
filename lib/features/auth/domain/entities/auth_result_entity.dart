import 'package:fansedu_flutter_mobile/features/auth/domain/entities/user_entity.dart';

class AuthResultEntity {
  const AuthResultEntity({
    required this.token,
    required this.user,
  });

  final String token;
  final UserEntity user;
}
