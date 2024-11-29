import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hook_routing/pages/countUp.dart';

void main() {
  runApp(MaterialApp.router(
    routerConfig: _router,
  ));
}

final _router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const MyApp(),
  )
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
      home: const CountUp(),
    );
  }
}
