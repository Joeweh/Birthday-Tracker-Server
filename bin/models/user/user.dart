class User {
  late String id, email, password;

  User({ required this.id, required this.email, required this.password });

  Map toJson() => {
    'id': id,
    'email': email,
    'password': password,
  };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'] as String,
        email: json['email'] as String,
        password: json['pw_hash'] as String
    );
  }
}

class UserDAO {
  late String email, password;

  UserDAO({ required this.email, required this.password });

  Map toJson() => {
    'email': email,
    'password': password,
  };

  factory UserDAO.fromJson(Map<String, dynamic> json) {
    return UserDAO(
        email: json['email'] as String,
        password: json['password'] as String
    );
  }
}