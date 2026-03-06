import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:fansedu_flutter_mobile/features/auth/data/datasources/auth_storage.dart';
import 'package:fansedu_flutter_mobile/features/auth/domain/entities/user_entity.dart';

const String _keyToken = 'auth_token';
const String _keyUser = 'auth_user';

class AuthStorageImpl implements AuthStorage {
  AuthStorageImpl(this._prefs);
  final SharedPreferences _prefs;

  @override
  Future<String?> getToken() async => _prefs.getString(_keyToken);

  @override
  Future<void> saveToken(String token) async {
    await _prefs.setString(_keyToken, token);
  }

  @override
  Future<void> clearToken() async {
    await _prefs.remove(_keyToken);
    await _prefs.remove(_keyUser);
  }

  @override
  Future<UserEntity?> getStoredUser() async {
    final json = _prefs.getString(_keyUser);
    if (json == null) return null;
    try {
      final map = jsonDecode(json) as Map<String, dynamic>;
      return UserEntity(
        id: map['id'] as String? ?? '',
        email: map['email'] as String? ?? '',
        name: map['name'] as String?,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveUser(UserEntity user) async {
    await _prefs.setString(
      _keyUser,
      jsonEncode({'id': user.id, 'email': user.email, 'name': user.name}),
    );
  }
}
