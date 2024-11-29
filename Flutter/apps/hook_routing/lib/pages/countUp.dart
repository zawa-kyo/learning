import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hook_routing/Widgets/pop.dart';

class CountUp extends HookWidget {
  const CountUp({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useState(0);

    ElevatedButton getCalcButton(int num) {
      return ElevatedButton(
        onPressed: () {
          count.value = count.value + num;
        },
        child: Text(
          '+$num',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    final resetButton = ElevatedButton(
      onPressed: () {
        count.value = 0;
      },
      child: Text(
        'リセット',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );

    final text = Text(
      '現在のカウントは ${count.value} です',
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
