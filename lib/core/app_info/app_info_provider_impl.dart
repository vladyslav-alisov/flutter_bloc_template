import 'package:flutter_bloc_template/core/app_info/app_info_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _kLatestUpdateKey = "latestUpdateKey";
const String _kLatestAppVersionKey = "latestAppVersionKey";

class AppInfoProviderImpl implements AppInfoProvider {
  final SharedPreferences _prefs;

  AppInfoProviderImpl({required SharedPreferences prefs}) : _prefs = prefs;

  late PackageInfo _packageInfo;
  late DateTime _lastUpdate;

  @override
  Future<void> init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String? appVersion = _getAppVersionFromStorage;

    if (appVersion != null && appVersion == packageInfo.version) {
      _lastUpdate = _getLastUpdateDateFromStorage();
      _packageInfo = packageInfo;
    } else {
      DateTime now = DateTime.now();
      await _saveAppVersionToStorage(packageInfo.version);
      await _saveLastUpdateDateToStorage(now);
      _lastUpdate = now;
      _packageInfo = packageInfo;
    }
  }

  String? get _getAppVersionFromStorage => _prefs.getString(_kLatestAppVersionKey);

  DateTime _getLastUpdateDateFromStorage() {
    int? lastUpdatedUnix = _prefs.getInt(_kLatestUpdateKey);
    return lastUpdatedUnix != null ? DateTime.fromMillisecondsSinceEpoch(lastUpdatedUnix) : DateTime.now();
  }

  Future<void> _saveAppVersionToStorage(String appVersion) async {
    await _prefs.setString(_kLatestAppVersionKey, appVersion);
  }

  Future<void> _saveLastUpdateDateToStorage(DateTime dateTime) async {
    int lastUpdatedUnix = dateTime.millisecondsSinceEpoch;
    await _prefs.setInt(_kLatestUpdateKey, lastUpdatedUnix);
  }

  @override
  String get appName => _packageInfo.appName;

  @override
  String get buildNumber => _packageInfo.buildNumber;

  @override
  String get buildSignature => _packageInfo.buildSignature;

  @override
  DateTime get lastUpdated => _lastUpdate;

  @override
  String get packageName => _packageInfo.packageName;

  @override
  String get version => _packageInfo.version;
}
