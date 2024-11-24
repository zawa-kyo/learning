import 'dart:convert';

import 'package:state_management/models/user.dart';

class UserRepository {
  Future<User> fetchUser() async {
    // TODO: http通信を仮定した処理を実装する
    const jsonString = '{"id": "123", "name": "Alice", "age": 30}';
    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
    return User.fromJson(jsonMap);
  }
}
