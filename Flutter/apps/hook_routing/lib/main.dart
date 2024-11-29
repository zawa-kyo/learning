import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hook_routing/pages/countDown.dart';
import 'package:hook_routing/pages/countUp.dart';
import 'package:hook_routing/pages/top.dart';

void main() {
  runApp(MaterialApp.router(
    routerConfig: _router,
  ));
}

final _router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const MyApp(),
    routes: [
      GoRoute(
        path: '/countUp',
        builder: (context, state) => const CountUp(),
      ),
      GoRoute(
        path: '/countDown',
        builder: (context, state) => const CountDown(),
      ),
    ],
  ),
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const Top(),
    );
  }
}
