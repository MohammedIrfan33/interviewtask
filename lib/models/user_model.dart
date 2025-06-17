class UserModel {
  final String name;
  final String userId;
  final String accessToken;
  final String refreshToken;

  UserModel({
    required this.name,
    required this.userId,
    required this.accessToken,
    required this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      userId: json['userId'] ?? '',
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }
}
