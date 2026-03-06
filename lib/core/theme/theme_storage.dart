import 'package:shared_preferences/shared_preferences.dart';
import 'package:fansedu_flutter_mobile/core/theme/theme_cubit.dart';

const String kThemeModeKey = 'theme_mode';

class ThemeStorageImpl implements ThemeStorage {
  ThemeStorageImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<int?> getThemeModeIndex() async => _prefs.getInt(kThemeModeKey);

  @override
  Future<void> setThemeModeIndex(int index) async {
    await _prefs.setInt(kThemeModeKey, index);
  }
}
