import 'package:dio/dio.dart';

class HttpService {
  final Dio _dio = Dio();

  Future<Response> get({required String url}) async {
    Response response = await _dio.get(url);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
