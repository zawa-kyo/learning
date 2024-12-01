import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hook_routing/application/states/counterNotifier.dart';

class DisplayCounter extends ConsumerWidget {
  const DisplayCounter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterNotifierProvider);

    return Text(
      '現在のカウントは ${count} です',
      style: Theme.of(context).textTheme.displaySmall,
    );
  }
}
