import 'dart:convert';

import 'package:crypto/crypto.dart';

class Cryptographer {
  static String hashPassword(String password) {
    var key = utf8.encode('key');
    var bytes = utf8.encode(password);

    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);

    return digest.toString();
  }
}