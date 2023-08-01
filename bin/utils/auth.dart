import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';

import 'crypto.dart';
import 'db.dart';

class Auth {
  static final Database _db = Database.getInstance();

  static Middleware verify() {
    return createMiddleware(
      requestHandler: (request) async {
        try {
          var authHeader = request.headers['Authorization'];
          var authValue = authHeader?.replaceFirst("Basic", " ").trim();

          Codec<String, String> stringToBase64 = utf8.fuse(base64);
          var credentials = stringToBase64.decode(authValue!).split(":");

          var query = await _db.pool.prepare("SELECT * FROM users WHERE email=? AND pw_hash=?");

          var resultSet = await query.execute([credentials[0], Cryptographer.hashPassword(credentials[1])]);

          await query.deallocate();

          if (resultSet.rows.isEmpty) {
            return Response(HttpStatus.unauthorized);
          }

          return null;
        }

        catch (e) {
          return Response(HttpStatus.unauthorized);
        }
      }
    );
  }
}