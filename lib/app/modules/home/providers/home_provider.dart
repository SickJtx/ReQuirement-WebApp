import 'package:dio/dio.dart';

import 'package:logger/logger.dart';
import 'package:re_quirement/app/utils/constants/http_info.dart';

class HomeProvider {
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<Response> getProjects({
    required String token,
    required int limit,
    required int page,
  }) async {
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {"Authorization": "Bearer $token"};
    _dio.options.baseUrl = HttpInfo.url;

    try {
      response = await _dio.get(
        "/project?limit=$limit&page=$page",
      );
    } on DioError catch (e) {
      logger.e(e.response);
      throw Exception(e);
    }

    return response;
  }
}
