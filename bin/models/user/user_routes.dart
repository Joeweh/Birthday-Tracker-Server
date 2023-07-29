import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'user.dart';
import 'user_service.dart';

class UserAPI {
  Router get router {
    final router = Router();
    final UserService userService = UserService();

    router.get("/login", (Request req) async {
      User user = await userService.login("test@gmail.com", "test");

      return Response(HttpStatus.ok, body: jsonEncode(user));
    });

    router.post("/register", (Request req) async {
      final String body = await req.readAsString();

      UserDAO userDAO = UserDAO.fromJson(jsonDecode(body));

      await userService.register(userDAO.email, userDAO.password);

      return Response(HttpStatus.created);
    });

    return router;
  }
}