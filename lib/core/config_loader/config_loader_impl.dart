import 'package:flutter_bloc_template/core/config_loader/config_loader.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvVariable {
  appStoreUrl("APP_STORE_URL"),
  playStoreUrl("PLAY_STORE_URL"),
  supportEmail("SUPPORT_EMAIL"),
  baseUrl("BASE_URL");

  const EnvVariable(this.key);

  final String key;
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
