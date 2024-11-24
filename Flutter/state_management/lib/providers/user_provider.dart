import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:state_management/repositories/user_repository.dart';
import 'package:state_management/models/user.dart';

final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final client = ref.read(httpClientProvider);
  return UserRepository(httpClient: client);
});

final userProvider = FutureProvider<User>((ref) async {
  final repository = ref.read(userRepositoryProvider);
  return repository.fetchUser('123');
});
