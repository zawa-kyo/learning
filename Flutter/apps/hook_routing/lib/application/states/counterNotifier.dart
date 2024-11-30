import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counterNotifier.g.dart';

@Riverpod(keepAlive: true)
class CounterNotifier extends _$CounterNotifier {
  @override
  int build() => 0;

  void add(int num) {
    state = state + num;
  }

  void reset() {
    state = 0;
  }
}
