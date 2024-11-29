import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_status_code/http_status_code.dart';
import 'package:state_management/models/user.dart';

class UserRepository {
  // http.ClientをDIで受け取る
  final http.Client httpClient;

  UserRepository({required this.httpClient});

  Future<User> fetchUser(int userId) async {
    final response = await httpClient.get(
      Uri.parse('https://api.example.com/users/$userId'),
    );

    if (response.statusCode != StatusCode.OK) {
      throw Exception('Failed to load user');
    }

    final jsonMap = json.decode(response.body) as Map<String, dynamic>;
    return User.fromJson(jsonMap);
  }
}
