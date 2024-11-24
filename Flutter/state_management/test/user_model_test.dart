import 'package:flutter_test/flutter_test.dart';
import 'package:state_management/models/user.dart';

void main() {
  group('User Model Test', () {
    test('fromJson creates a valid User object', () {
      final jsonMap = {
        'id': '123',
        'name': 'Alice',
        'age': 30,
      };

      final user = User.fromJson(jsonMap);

      expect(user.id, '123');
      expect(user.name, 'Alice');
      expect(user.age, 30);
    });

    test('toJson converts User object to JSON map', () {
      const user = User(id: '123', name: 'Alice', age: 30);

      final jsonMap = user.toJson();

      expect(jsonMap['id'], '123');
      expect(jsonMap['name'], 'Alice');
      expect(jsonMap['age'], 30);
    });
  });
}
