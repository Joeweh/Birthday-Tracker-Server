import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'user_service.dart';

class UserAPI {
  Router get router {
    final router = Router();
    final UserService userService = UserService();

    router.get("/", (Request req) {
      return Response(HttpStatus.notImplemented);
    });

    return router;
  }
}