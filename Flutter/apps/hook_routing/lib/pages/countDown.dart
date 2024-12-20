import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hook_routing/application/states/counterNotifier.dart';
import 'package:hook_routing/widgets/display_counter.dart';
import 'package:hook_routing/widgets/pop.dart';
import 'package:hook_routing/widgets/popAppbar.dart';

class CountDown extends ConsumerWidget {
  const CountDown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterNotifier = ref.read(counterNotifierProvider.notifier);

    ElevatedButton getButton(int num) {
      return ElevatedButton(
        onPressed: () {
          counterNotifier.add(num);
        },
        child: Text(
          '$num',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    final resetButton = ElevatedButton(
      onPressed: () {
        counterNotifier.reset();
      },
      child: Text(
        'リセット',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );

    return Scaffold(
      appBar: PopAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DisplayCounter(),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getButton(-1),
                SizedBox(width: 5),
                getButton(-2),
                SizedBox(width: 5),
                getButton(-3),
              ],
            ),
            SizedBox(height: 20),
            resetButton,
            SizedBox(height: 40),
            popWidget(),
          ],
        ),
      ),
    );
  }
}
