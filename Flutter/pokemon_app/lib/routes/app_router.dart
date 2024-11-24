import 'package:flutter/material.dart';
import 'package:pokemon_app/views/list_view.dart';
import 'package:pokemon_app/views/detail_view.dart';

class AppRouter extends RouterDelegate<RouteSettings>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteSettings> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  RouteSettings? currentConfiguration;

  AppRouter() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        const MaterialPage(child: PokemonListView()),
        if (currentConfiguration?.name == '/detail')
          MaterialPage(
              child: PokemonDetailView(
                  id: currentConfiguration!.arguments as int)),
        if (currentConfiguration?.name != '/' &&
            currentConfiguration?.name != '/detail')
          const MaterialPage(
            child: Scaffold(body: Center(child: Text('404'))),
          ),
      ],
      onPopPage: (BuildContext context, Route<dynamic> route, dynamic result) {
        if (!route.didPop(result)) {
          return false;
        }
        currentConfiguration = const RouteSettings(name: '/');
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RouteSettings configuration) async {
    currentConfiguration = configuration;
  }
}
