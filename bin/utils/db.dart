import 'package:mysql_client/mysql_client.dart';

class Database {
  final pool = MySQLConnectionPool(
    host: 'db4free.net',
    port: 3306,
    userName: 'joeyqsa',
    password: 'obeseclown211',
    maxConnections: 10,
    databaseName: 'bdaydb'
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