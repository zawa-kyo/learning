import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:state_management/models/user.dart';
import 'package:state_management/repositories/user_repository.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});

final userProvider = FutureProvider<User>((ref) async {
  final repository = ref.read(userRepositoryProvider);
  return repository.fetchUser();
});
