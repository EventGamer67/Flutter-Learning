class User {
  final String? userID;
  final String? user_roleID;
  final String? user_name;
  final String? user_passwordHash;

  User({
    this.userID,
    this.user_roleID,
    this.user_name,
    this.user_passwordHash,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userID: json['userID'],
      user_roleID: json['user_roleID'],
      user_name: json['user_name'],
      user_passwordHash: json['user_passwordHash']
    );
  }
}
