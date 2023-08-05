import 'package:dotenv/dotenv.dart';

class Config {
  static final env = DotEnv(includePlatformEnvironment: true)..load();
}