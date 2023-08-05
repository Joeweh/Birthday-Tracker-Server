import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../utils/jwt.dart';
import 'user.dart';
import 'user_service.dart';

class UserAPI {
  Router get router {
    final router = Router();
    final UserService userService = UserService();

    router.post(
        "/login",
        Pipeline()
            .addHandler((request) async {
              final String body = await request.readAsString();

              UserDAO userDAO = UserDAO.fromJson(jsonDecode(body));

              User? user = await userService.login(userDAO.email, userDAO.password);

              if (user == null) {
                return Response(HttpStatus.notFound);
              }
              
              Map<String, dynamic> json = {
                'access_token': JWTUtil.issueAccessToken(user.id),
                'refreshToken': JWTUtil.issueRefreshToken(user.id)
              };

              return Response(HttpStatus.ok, body: jsonEncode(json));
            })
    );

    router.post(
        "/register",
        Pipeline()
            .addHandler((request) async {
              final String body = await request.readAsString();

              UserDAO userDAO = UserDAO.fromJson(jsonDecode(body));

              await userService.register(userDAO.email, userDAO.password);

              return Response(HttpStatus.created);
            })
    );

    router.put(
        "/<id>/change-password",
        Pipeline()
            .addMiddleware(JWTUtil.verify())
            .addHandler((request) async {
              final String body = await request.readAsString();

              String newPassword = jsonDecode(body)["new_password"];

              bool successful = await userService.changePassword(request.params["id"]!, newPassword);

              if (!successful) {
                return Response(HttpStatus.unprocessableEntity);
              }

              return Response(HttpStatus.noContent);
            })
    );

    return router;
  }
}