import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hook_routing/application/states/counterNotifier.dart';
import 'package:hook_routing/presentation/router.dart';

class Top extends ConsumerWidget {
  const Top({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterNotifierProvider);
    final text = Text(
      '現在のカウントは ${count} です',
      style: Theme.of(context).textTheme.displaySmall,
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text,
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => context.go(Routes.countUp),
                  child: Text(
                    'Up',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => context.go(Routes.countDown),
                  child: Text(
                    'Down',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
