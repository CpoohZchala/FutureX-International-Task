class User {
  final int userid;
  final String username;
  final String email;
  final String phone;

  User({
    required this.userid,
    required this.username,
    required this.email,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userid: json['userid'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userid': userid,
      'username': username,
      'email': email,
      'phone': phone,
    };
  }
}