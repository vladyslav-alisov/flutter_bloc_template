import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AppSettingsLocalDataSource {
  /// Saves a setting value by its key
  Future<void> saveSetting(String key, dynamic value);

  /// Retrieves a setting value by its key
  Future<dynamic> getSetting(String key);

  /// Removes a setting by its key
  Future<void> removeSetting(String key);

  /// Clears all saved settings
  Future<void> clearSettings();
}

class SharedPreferencesAppSettingsLocalDataSourceImpl implements AppSettingsLocalDataSource {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesAppSettingsLocalDataSourceImpl({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  @override
  Future<void> saveSetting(String key, dynamic value) async {
    if (value is String) {
      await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      await _sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      await _sharedPreferences.setBool(key, value);
    } else if (value is double) {
      await _sharedPreferences.setDouble(key, value);
    } else {
      throw Exception('Unsupported value type');
    }
  }

  @override
  Future<dynamic> getSetting(String key) async {
    return _sharedPreferences.get(key);
  }

  @override
  Future<void> removeSetting(String key) async {
    await _sharedPreferences.remove(key);
  }

  @override
  Future<void> clearSettings() async {
    await _sharedPreferences.clear();
  }
}
