// auth_bloc.dart
import 'package:dio/dio.dart';
import 'package:e_commerce/Bloc/Auth/auth_event.dart';
import 'package:e_commerce/Bloc/Auth/auth_state.dart';
import 'package:e_commerce/Services/Constlar/apikeys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await Dio().post(
        "https://ecommercev01.pythonanywhere.com/user/token/",
        data: {
          "email_or_phone": event.emailOrPhone,
          "password": event.password,
        },
      );

      final access = response.data["access"];
      final refresh = response.data["refresh"];

      apiService.accessToken = access;
      apiService.refreshToken = refresh;

      emit(AuthSuccess(accessToken: access, refreshToken: refresh));
    } on DioException catch (e) {
      emit(AuthFailure(
        message: e.response?.data?.toString() ?? "Login yoki parol noto'g'ri",
      ));
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await Dio().post(
        "https://ecommercev01.pythonanywhere.com/user/register/",
        data: {
          "first_name": event.firstName,
          "email": event.email,
          "password": event.password,
        },
      );

      print(response.data);
      // Ro'yxatdan o'tgach avtomatik login qilmoqchi bo'lsangiz,
      // shu yerda LoginRequested eventini chaqirish mumkin.
      emit(AuthInitial());
    } on DioException catch (e) {
      emit(AuthFailure(
        message: e.response?.data?.toString() ?? "Ro'yxatdan o'tishda xatolik",
      ));
    }
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) {
    apiService.accessToken = null;
    apiService.refreshToken = null;
    emit(AuthInitial());
  }
}