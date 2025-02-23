
class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() => {
        "email": email,
        "password": password,
      };
}
