import 'package:fansedu_flutter_mobile/features/auth/domain/entities/user_entity.dart';

abstract class AuthStorage {
  Future<String?> getToken();
  Future<void> saveToken(String token);
  Future<void> clearToken();
  Future<UserEntity?> getStoredUser();
  Future<void> saveUser(UserEntity user);
}
