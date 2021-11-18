import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import 'package:mime_type/mime_type.dart';
import 'package:re_quirement/app/utils/constants/http_info.dart';
import 'package:http/http.dart' as http;

class FileUploader {
  static const cloudName = "sickjtx";

  late FilePickerResult? result;
  late PlatformFile? file;

  final logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<bool> selectFile() async {
    try {
      final result = await FilePicker.platform.pickFiles();
      if (result != null) {
        file = result.files.first;
        logger.wtf(file!.name);
        logger.wtf(mime(file!.name));
        return true;
      }
    } on Exception catch (e) {
      logger.e(e.toString());
    }
    return false;
  }

  Future<Response> importProject({
    required String token,
  }) async {
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {
      "Authorization": "Bearer $token",
    };
    _dio.options.baseUrl = HttpInfo.url;
    _dio.options.contentType = "multipart/form-data";
    /* final FormData formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(
        file!.bytes!,
        filename: file!.name,
        contentType: MediaType("application", "xlsx"),
      ),
    }); */
    FormData body = FormData();
    final bytes = file!.bytes!;
    final MultipartFile excel =
        MultipartFile.fromBytes(bytes, filename: "document");
    MapEntry<String, MultipartFile> docEntry = MapEntry("files", excel);
    body.files.add(docEntry);
    try {
      response = await _dio.post("/project/import", data: body);
    } on DioError catch (e) {
      logger.e(e.response);
      throw Exception(e);
    }
    return response;
  }
}
