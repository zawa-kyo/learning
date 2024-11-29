import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'routes/app_router.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final _router = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pokemon App',
      routerDelegate: _router,
      routeInformationParser: _SimpleRouteParser(),
    );
  }
}

class _SimpleRouteParser extends RouteInformationParser<RouteSettings> {
  @override
  Future<RouteSettings> parseRouteInformation(RouteInformation rt) async {
    final uri = rt.uri;
    if (uri.pathSegments.isEmpty) {
      return const RouteSettings(name: '/');
    } else if (uri.pathSegments.length == 2 &&
        uri.pathSegments.first == 'detail') {
      final id = int.tryParse(uri.pathSegments[1]);
      if (id != null) {
        return RouteSettings(name: '/detail', arguments: id);
      }
    }
    return const RouteSettings(name: '/404');
  }

  @override
  RouteInformation restoreRouteInformation(RouteSettings configuration) {
    if (configuration.name == '/') {
      return RouteInformation(uri: Uri(path: '/'));
    } else if (configuration.name == '/detail') {
      return RouteInformation(
          uri: Uri(path: '/detail/${configuration.arguments}'));
    }
    return RouteInformation(uri: Uri(path: '/404'));
  }
}
