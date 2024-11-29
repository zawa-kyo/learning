import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hook_routing/pages/countDown.dart';
import 'package:hook_routing/pages/countUp.dart';
import 'package:hook_routing/pages/top.dart';
import 'package:hook_routing/presentation/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _router = GoRouter(routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const Top(),
        routes: [
          GoRoute(
            path: Routes.countUp,
            builder: (context, state) => const CountUp(),
          ),
          GoRoute(
            path: Routes.countDown,
            builder: (context, state) => const CountDown(),
          ),
        ],
      ),
    ]);

    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
    );
  }
}
