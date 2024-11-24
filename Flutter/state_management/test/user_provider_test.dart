import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:state_management/models/user.dart';
import 'package:state_management/providers/user_provider.dart';
import 'package:mockito/mockito.dart';

// FIXME: Exception has occurred:_TypeError (type 'Null' is not a subtype of type 'Future<Response>')
class MockHttpClient extends Mock implements http.Client {}

void main() {
  test('fetchUser returns a User', () async {
    final mockClient = MockHttpClient();

    when(mockClient.get(
      Uri.parse('https://api.example.com/users/123'),
    )).thenAnswer(
      (_) async =>
          http.Response('{"id": "123", "name": "Alice", "age": 30}', 200),
    );

    final container = ProviderContainer(overrides: [
      httpClientProvider.overrideWithValue(mockClient),
    ]);

    final user = await container.read(userProvider.future);

    expect(user.id, '123');
    expect(user.name, 'Alice');
    expect(user.age, 30);
  });
}
