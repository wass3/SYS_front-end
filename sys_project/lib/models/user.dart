class User {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String address;
  final String imageUrl;
  final String bio;
  final String id;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.address,
    required this.imageUrl,
    required this.bio,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      phoneNumber: json['phoneNumber'] as String,
      address: json['address'] as String,
      imageUrl: json['imageUrl'] as String,
      bio: json['bio'] as String,
      id: json['id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'address': address,
      'imageUrl': imageUrl,
      'bio': bio,
      'id': id,
    };
  }
}
