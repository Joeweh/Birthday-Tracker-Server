import 'package:mysql_client/mysql_client.dart';

class Database {
  final pool = MySQLConnectionPool(
    host: 'localhost',
    port: 3306,
    userName: 'root',
    password: 'joeyqsa',
    maxConnections: 10,
    databaseName: 'mydb'
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