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

// FutureProvider.familyから引数を受け取る
final userProvider = FutureProvider.family<User, int>((ref, userId) async {
  final repository = ref.read(userRepositoryProvider);
  return repository.fetchUser(userId);
});
