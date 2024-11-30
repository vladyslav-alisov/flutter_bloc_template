abstract class ConfigLoader {
  Future<void> load();

  String? get(String key);
}
