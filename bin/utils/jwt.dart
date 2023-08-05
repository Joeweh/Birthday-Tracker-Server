import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import 'config.dart';

class JWTUtil {
  static String issueAccessToken(String id) {
    String token;

    // Create a json web token
    final jwt = JWT({
      'exp': formatExpirationDate(Duration(minutes: 20)),
      'user_id': id,
    });

    // Sign it
    token = jwt.sign(SecretKey(Config.env["ACCESS_TOKEN_SECRET"]!));

    return token;
  }

  static String issueRefreshToken(String id) {
    String token;

    // Create a json web token
    final jwt = JWT({
      'exp': formatExpirationDate(Duration(days: 1)),
      'user_id': id,
    });

    // Sign it
    token = jwt.sign(SecretKey(Config.env["REFRESH_TOKEN_SECRET"]!));

    return token;
  }

  static Middleware verify() {
    return createMiddleware(
        requestHandler: (request) async {
          try {
            var authHeader = request.headers['Authorization'];
            var token = authHeader?.replaceFirst("Bearer ", "");

            // Verify a token
            final jwt = JWT.verify(token!, SecretKey(Config.env["ACCESS_TOKEN_SECRET"]!), checkExpiresIn: true);

            print('Payload: ${jwt.payload}');

            return null;
          }

          on JWTExpiredException {
            print('jwt expired');
            return Response(HttpStatus.unauthorized);
          }

          on JWTException catch (ex) {
            print("Invalid sig");
            print(ex.message);
            return Response(HttpStatus.unauthorized);
          }

          catch (e) {
            return Response(HttpStatus.unauthorized);
          }
        }
    );
  }

  static int formatExpirationDate(Duration lifespan) {
    var current = DateTime.now().add(lifespan);
    return (current.millisecondsSinceEpoch / 1000.0).round();
  }
}