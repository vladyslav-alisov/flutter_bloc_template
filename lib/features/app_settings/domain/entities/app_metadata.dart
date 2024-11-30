class AppInfo {
  final String appName;
  final String packageName;
  final String version;
  final String buildNumber;
  final String buildSignature;
  final DateTime lastUpdated;

  AppInfo(
    this.appName,
    this.packageName,
    this.version,
    this.buildNumber,
    this.buildSignature,
    this.lastUpdated,
  );
}
