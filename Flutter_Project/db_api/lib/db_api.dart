library db_api;

import 'package:dio/dio.dart';

class API {
  final dio = Dio();

  getUsers() async {
    try {
      final response = await dio.get('https://reqres.in/api/users');
      return response.data;
    } catch (e) {
      return null;
    }
  }

  getUser(String id) async {
    try {
      final response = await dio.get('https://reqres.in/api/users/$id');
      return response.data;
    } catch (e) {
      return null;
    }
  }
}
