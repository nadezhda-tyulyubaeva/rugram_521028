import 'package:dio/dio.dart';

class Environment {
  static final BaseOptions baseOptions = BaseOptions(
    baseUrl: 'https://dummyapi.io/data/v1/',
    headers: {
      'app-id': '0JyYiOQXQQr5H9OEn21312',
    },
  );
}