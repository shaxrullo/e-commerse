class RegisterModul {
  final String firstName;
  final String email;
  final String password;

  RegisterModul({
    required this.firstName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "email": email,
      "password": password,
    };
  }
}