import '../../utils/crypto.dart';
import '../../utils/db.dart';
import '../../utils/uid.dart';
import 'user.dart';

class UserService {
  final Database _db = Database.getInstance();

  Future<User> login(String email, String password) async {
    var query = await _db.pool.prepare("SELECT * FROM users WHERE email=? AND pw_hash=?");

    var resultSet = await query.execute(["test1@gmail.com", Cryptographer.hashPassword("test_pw1")]);

    await query.deallocate();

    User user = User.fromJson(resultSet.rows.single.typedAssoc());

    return user;
  }

  Future<void> register(String email, String password) async {
    var query = await _db.pool.prepare("INSERT INTO users VALUES(?, ?, ?)");

    await query.execute([UID.generate(), email, Cryptographer.hashPassword(password)]);

    await query.deallocate();
  }
}