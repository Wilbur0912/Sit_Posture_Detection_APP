class UserProfile {
  String? username;
  String? password;
  int? height;
  int? weight;
  String? gender;
  String? token;
  UserProfile({
    this.username,
    this.password,
    this.height,
    this.weight,
    this.gender,
    this.token,
  });

  UserProfile copyWith({
    String? username,
    String? password,
    int? height,
    int? weight,
    String? gender,
    String? token,
  }) {
    return UserProfile(
      username: username ?? this.username,
      password: password ?? this.password,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      token: token ?? this.token,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'height': height,
      'weight': weight,
      'gender': gender,
      'token': token,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      username: json['username'],
      password: json['password'],
      height: json['height'],
      weight: json['weight'],
      gender: json['gender'],
      token: json['token'],
    );
  }
}
