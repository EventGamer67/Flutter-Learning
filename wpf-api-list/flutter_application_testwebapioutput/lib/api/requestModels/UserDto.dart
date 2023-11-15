class UserDto {
  final String? user_name;
  final String? password;

  UserDto({
    this.user_name,
    this.password,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      user_name: json['user_name'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_name': user_name,
      'password': password,
    };
  }
}