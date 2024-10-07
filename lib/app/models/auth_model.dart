class AuthModel {
  String type;
  String token;

  AuthModel({
    required this.type,
    required this.token,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      type: json['type'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['token'] = token;
    return data;
  }
}
