import 'dart:math';

class UID {
  static final int uidLength = 20;

  static String generate() {
    String id = "";
    String characters = "abcdefghijklmnopqrstuvwxyz0123456789";

    Random rng = Random();

    for (int i = 0; i < uidLength; i++) {
      int index = rng.nextInt(characters.length);

      id += characters[index];
    }

    return id;
  }
}