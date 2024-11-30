abstract interface class AppInfoProvider {
  Future<void> init();
  String get appName;
  String get packageName;
  String get version;
  String get buildNumber;
  String get buildSignature;
  DateTime get lastUpdated;
}
