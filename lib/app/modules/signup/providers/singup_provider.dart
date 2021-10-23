import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:re_quirement/app/utils/constants/http_info.dart';

class SignUpProvider {
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<Response> signUpUser({
    required String username,
    required String password,
    required String firstName,
    required String lastName,
    String primaryAddress = "",
    String secundaryAddress = "",
  }) async {
    final _dio = Dio();
    final Response response;

    _dio.options.headers = {};
    _dio.options.baseUrl = HttpInfo.url;

    try {
      response = await _dio.post("/session/sign",
          data: {
            "email": username,
            "password": password,
            "firstName": firstName,
            "lastName": lastName,
            "primaryAddress": primaryAddress,
            "secundaryAddress": secundaryAddress
          },
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ));
      logger.i(response);
    } on DioError catch (e) {
      logger.e(e.response);
      throw Exception(e);
    }

    return response;
  }
}
