// auth_event.dart
abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String emailOrPhone;
  final String password;

  LoginRequested({required this.emailOrPhone, required this.password});
}

class RegisterRequested extends AuthEvent {
  final String firstName;
  final String email;
  final String password;

  RegisterRequested({
    required this.firstName,
    required this.email,
    required this.password,
  });
}

class LogoutRequested extends AuthEvent {}