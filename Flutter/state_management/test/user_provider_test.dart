import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:state_management/models/user.dart';
import 'package:state_management/providers/user_provider.dart';
import 'package:state_management/repositories/user_repository.dart';

void main() {
  group('UserProvider Test', () {
    test('fetchUser returns a User', () async {
      final mockRepository = MockUserRepository();
      final container = ProviderContainer(overrides: [
        userRepositoryProvider.overrideWithValue(mockRepository),
      ]);

      final userFuture = container.read(userProvider.future);

      final user = await userFuture;
      expect(user.id, '123');
      expect(user.name, 'Alice');
      expect(user.age, 30);
    });
  });
}

class MockUserRepository extends UserRepository {
  @override
  Future<User> fetchUser() async {
    return const User(id: '123', name: 'Alice', age: 30);
  }
}
