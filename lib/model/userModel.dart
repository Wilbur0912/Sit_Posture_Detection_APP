class UserProfile {
  String? username;
  String? password;
  double? height;
  double? weight;
  String? gender;

  UserProfile({
    this.username,
    this.password,
    this.height,
    this.weight,
    this.gender,
  });

  UserProfile copyWith({
    String? username,
    String? password,
    double? height,
    double? weight,
    String? gender,
  }) {
    return UserProfile(
      username: username ?? this.username,
      password: password ?? this.password,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'height': height,
      'weight': weight,
      'gender': gender,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      username: json['username'],
      password: json['password'],
      height: json['height'],
      weight: json['weight'],
      gender: json['gender'],
    );
  }
}
