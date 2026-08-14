import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://ecommercev01.pythonanywhere.com/",
    ),
  );

  String? accessToken;
  String? refreshToken;

  void setToken(String token) {
    accessToken = token;
  }

  void getToken(String tokeni) {
    refreshToken = tokeni;
  }

  Future<Response> getProducts() {
    return dio.get(
      "product/list/",
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    );
  }
}

  final apiService=ApiService();
