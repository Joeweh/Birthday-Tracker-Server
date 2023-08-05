import 'package:mysql_client/mysql_client.dart';

import 'config.dart';

class Database {

  final pool = MySQLConnectionPool(
    host: Config.env['DB_HOSTNAME']!,
    port: int.parse(Config.env['DB_PORT']!),
    userName: Config.env['DB_USERNAME']!,
    password: Config.env['DB_PASSWORD']!,
    databaseName: Config.env['DB_NAME']!,
    maxConnections: 10
  );

  /* ================= */
  /* SINGLETON PATTERN */
  /* ================= */
  static final Database _instance = Database._();

  Database._();

  static Database getInstance() {
    return _instance;
  }
}