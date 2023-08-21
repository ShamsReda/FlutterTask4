class UserDataModel {
  String email;
  String name;
  String phone;
  String password;
  String uid;

  UserDataModel({
    required this.email,
    required this.phone,
    required this.name,
    required this.password,
    required this.uid,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      email: json['email'],
      password: json['password'],
      name: json['name'],
      uid: json['uid'],
      phone: json['phone'],
    );
  }
}
