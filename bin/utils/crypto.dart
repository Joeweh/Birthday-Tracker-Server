import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'config.dart';

class Cryptographer {
  static final String _keyString = Config.env['HASH_KEY']!;

  static String hashPassword(String password) {
    var key = utf8.encode(_keyString);
    var bytes = utf8.encode(password);

    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);

    return digest.toString();
  }
}