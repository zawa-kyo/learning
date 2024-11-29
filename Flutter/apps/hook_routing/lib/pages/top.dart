import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hook_routing/presentation/router.dart';

class Top extends StatelessWidget {
  const Top({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => GoRouter.of(context).go(Routes.countUp),
              child: Text(
                'Up',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () => GoRouter.of(context).go(Routes.countDown),
              child: Text(
                'Down',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
