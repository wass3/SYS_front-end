class User {
  final int userId;
  final String userHandler;
  final DateTime createdAt;
  final String name;
  final String surname;
  final String biography;
  final String emailAddress;
  final String password;
  final String userImg;

  User({
    required this.userId,
    required this.userHandler,
    required this.createdAt,
    required this.name,
    required this.surname,
    required this.biography,
    required this.emailAddress,
    required this.password,
    required this.userImg,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'] as int,
      userHandler: json['user_handler'] as String,
      createdAt: DateTime.parse(json['created_at']),
      name: json['name'] as String,
      surname: json['surname'] as String,
      biography: json['biography'] as String,
      emailAddress: json['email_address'] as String,
      password: json['password'] as String,
      userImg: json['user_img'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'user_handler': userHandler,
      'created_at': createdAt.toIso8601String(),
      'name': name,
      'surname': surname,
      'biography': biography,
      'email_address': emailAddress,
      'password': password,
      'user_img': userImg,
    };
  }
}

