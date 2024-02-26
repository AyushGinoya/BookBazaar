class UserModel {
  String? name;
  String? phone;
  String? email;
  String? password;

  UserModel({
    this.name,
    this.phone,
    this.email,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phone,
      'email': email,
      'password': password,
    };
  }
}
