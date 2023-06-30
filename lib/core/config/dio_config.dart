import 'package:dio/dio.dart';

class AppDio {
  final String _authorization =
      'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkOTI4NTg2Yjg1NTdmNDQ5OTE1ZWYxMDlkMTQ3YWNjNCIsInN1YiI6IjVmOTNkZmE3ZDExZTBlMDA1MDhlM2Q0NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.CqzYq4rmT64OlwyLR8Bpu6qOv2sr4WgLw9D3zOlLZNo';

  Dio get dio {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": _authorization
    };

    final options = BaseOptions(
        baseUrl: "https://api.themoviedb.org/3/",
        contentType: "application/json",
        headers: headers);

    var dio = Dio(options);

    return dio;
  }
}
