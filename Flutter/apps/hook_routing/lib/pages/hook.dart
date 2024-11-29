import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HookPage extends HookWidget {
  const HookPage({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useState(0);

    final button = ElevatedButton(
      onPressed: () {
        count.value++;
      },
      child: Text(
        '+1',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );

    final text = Text(
      '現在のカウントは ${count.value} です',
      style: Theme.of(context).textTheme.bodyLarge,
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text,
            SizedBox(height: 20),
            button,
          ],
        ),
      ),
    );
  }
}
