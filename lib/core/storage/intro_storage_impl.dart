import 'package:shared_preferences/shared_preferences.dart';

import 'package:fansedu_flutter_mobile/core/storage/intro_storage.dart';

const String _keyIntroSeen = 'intro_seen';

class IntroStorageImpl implements IntroStorage {
  IntroStorageImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<bool> hasSeenIntro() async => _prefs.getBool(_keyIntroSeen) ?? false;

  @override
  Future<void> setIntroSeen() async {
    await _prefs.setBool(_keyIntroSeen, true);
  }
}
