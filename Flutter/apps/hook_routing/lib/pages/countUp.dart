import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hook_routing/Widgets/pop.dart';
import 'package:hook_routing/application/states/counterNotifier.dart';
import 'package:hook_routing/widgets/popAppbar.dart';

class CountUp extends ConsumerWidget {
  const CountUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterNotifierProvider);
    final counterNotifier = ref.read(counterNotifierProvider.notifier);

    ElevatedButton getCalcButton(int num) {
      return ElevatedButton(
        onPressed: () {
          counterNotifier.add(num);
        },
        child: Text(
          '+$num',
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

    final text = Text(
      '現在のカウントは ${count} です',
      style: Theme.of(context).textTheme.displaySmall,
    );

    return Scaffold(
      appBar: PopAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text,
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getCalcButton(1),
                SizedBox(width: 5),
                getCalcButton(2),
                SizedBox(width: 5),
                getCalcButton(3),
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
