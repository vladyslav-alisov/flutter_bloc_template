import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvVariable {
  baseUrl("BASE_URL");

  const EnvVariable(this.key);

  final String key;
}

abstract class ConfigLoader {
  Future<void> load();

  String? get(String key);
}

class DotenvConfigLoaderImpl implements ConfigLoader {
  final String fileName;

  DotenvConfigLoaderImpl(this.fileName);

  @override
  Future<void> load() async {
    await dotenv.load(fileName: fileName);
  }

  @override
  String? get(String key) => dotenv.env[key];
}
