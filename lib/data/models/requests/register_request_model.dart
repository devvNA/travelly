
class RegisterRequestModel {
  String name;
  String email;
  String password;
  String confirmPassword;

  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "password": password,
        "confirm_password": confirmPassword,
      };
}
