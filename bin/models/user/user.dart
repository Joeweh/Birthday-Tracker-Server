class User {
  late String id, email, username, password;

  User({ required this.id, required this.email, required this.username, required this.password });

  Map toJson() => {
    'id': id,
    'email': email,
    'username': username,
    'password': password,
  };

  factory User.fromJson(dynamic json) {
    return User(
        id: json['id'] as String,
        email: json['email'] as String,
        username: json['username'] as String,
        password: json['password'] as String
    );
  }
}