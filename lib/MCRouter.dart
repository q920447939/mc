import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mc/main.dart';
import 'package:mc/player_page.dart';
import 'package:mc/second_page.dart';
import 'package:mc/vedio_page/video_list_page.dart';

class MCRouter extends RouterDelegate<List<RouteSettings>>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<List<RouteSettings>> {
  final List<Page> _pages = [];
  late Completer<Object?> _boolResultCompleter;
  static const String mainPage = "/main";
  static const String secondPage = "/second";
  static const String playPage = "/play";
  static const String videoListPage = "/videoList";
  static const String key = "key";
  static const String value = "value";

  MCRouter() {
    _pages.add(_createPage(const RouteSettings(name: mainPage, arguments: [])));
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: List.of(_pages),
      onPopPage: _onPopPage,
    );
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey {
    return GlobalKey<NavigatorState>();
  }

  @override
  Future<void> setNewRoutePath(List configuration) async {}

  @override
  Future<bool> popRoute({Object? params}) {
    if (params != null) {
      _boolResultCompleter.complete(params);
    }
    if (_canPop()) {
      _pages.removeLast();
      notifyListeners();
      return Future.value(true);
    }
    return _confirmExit();
  }

  bool _onPopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }
    if (_canPop()) {
      _pages.removeLast();
      return true;
    } else {
      return false;
    }
  }

  bool _canPop() {
    return _pages.length > 1;
  }

  void replace({required String name, dynamic arguments}) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    push(name: name, arguments: arguments);
  }

  Future<Object?> push({required String name, dynamic arguments}) async {
    _boolResultCompleter = Completer<Object?>();
    _pages.add(_createPage(RouteSettings(name: name, arguments: arguments)));
    notifyListeners();
    return _boolResultCompleter.future;
  }

  MaterialPage _createPage(RouteSettings routeSettings) {
    Widget page;
    switch (routeSettings.name) {
      case mainPage:
        page = const MyHomePage(title: 'My Home Page');
        break;
      case secondPage:
        page = SecondPage(
          params: routeSettings.arguments?.toString() ?? '',
        );
        break;
      case playPage:
        var url = page = PlayerPage(
          url: routeSettings.arguments?.toString() ?? '',
        );
        break;
      case videoListPage:
        page = const VideoListPage();
        break;
      default:
        page = const Scaffold();
    }
    return MaterialPage(
        child: page,
        key: Key(routeSettings.name!) as LocalKey,
        name: routeSettings.name,
        arguments: routeSettings.arguments);
  }

  Future<bool> _confirmExit() async {
    final result = await showDialog(
        context: navigatorKey.currentContext!,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            content: const Text('确定退出吗'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(buildContext, true),
                  child: Text('取消')),
              TextButton(
                  onPressed: () => Navigator.pop(buildContext, false),
                  child: Text('确定'))
            ],
          );
        });
    return result;
  }
}
