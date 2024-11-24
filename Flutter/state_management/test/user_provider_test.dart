import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:state_management/providers/user_provider.dart';

import 'user_provider_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test('fetchUser returns a User', () async {
    final mockClient = MockClient();
    const userId = 123;

    when(mockClient.get(Uri.parse('https://api.example.com/users/$userId')))
        .thenAnswer((_) async => http.Response(
            '{"id": "$userId", "name": "Alice", "age": 30}', 200));

    final container = ProviderContainer(overrides: [
      httpClientProvider.overrideWithValue(mockClient),
    ]);

    final user = await container.read(userProvider(userId).future);

    expect(user.id, '123');
    expect(user.name, 'Alice');
    expect(user.age, 30);
  });
}
