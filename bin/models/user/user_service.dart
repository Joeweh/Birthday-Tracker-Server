import '../../utils/crypto.dart';
import '../../utils/db.dart';
import '../../utils/uid.dart';
import 'user.dart';

class UserService {
  final Database _db = Database.getInstance();

  Future<User?> login(String email, String password) async {
    // ATTEMPT TO GET USER
    var query = await _db.pool.prepare("SELECT * FROM users WHERE email=? AND pw_hash=?");

    var resultSet = await query.execute([email, Cryptographer.hashPassword(password)]);

    await query.deallocate();

    // VERIFY RESULT
    if (resultSet.rows.length != 1) {
      return null;
    }

    User user = User.fromJson(resultSet.rows.single.typedAssoc());

    return user;
  }

  Future<void> register(String email, String password) async {
    var query = await _db.pool.prepare("INSERT INTO users VALUES(?, ?, ?)");

    await query.execute([UID.generate(), email, Cryptographer.hashPassword(password)]);

    await query.deallocate();
  }

  Future<bool> changePassword(String id, String newPassword) async {
    var query = await _db.pool.prepare("UPDATE users SET pw_hash=? WHERE id=?");

    var resultSet = await query.execute([Cryptographer.hashPassword(newPassword), id]);

    await query.deallocate();

    if (resultSet.affectedRows.toInt() == 0) {
      return false;
    }

    return true;
  }
}