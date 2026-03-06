import 'package:shared_preferences/shared_preferences.dart';

import 'package:fansedu_flutter_mobile/features/auth/data/datasources/auth_storage.dart';

const String _keyToken = 'auth_token';

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
  }
}
