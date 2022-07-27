import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/home_screen.dart';

import 'route_utils.dart';
import 'package:flutter/material.dart';

final pageManagerProvider = ChangeNotifierProvider((ref) => PageManager());

class PageManager extends ChangeNotifier {
  PageManager() {
    _pages = [
      MaterialPage(
        child: const HomeScreen(),
        key: ValueKey(RoutePath.home.name),
        name: RoutePath.home.location,
      ),
    ];
  }

  List<Page> get pages => List.unmodifiable(_pages);
  List<Page> _pages = [];
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  RoutePath get currentPath => RouteUtils.parseUri(_pages.last.name);

  void didPop(Page page) {
    _pages.remove(page);
    notifyListeners();
  }

  Future<void> setNewRoutePath(RoutePath path) async {
    final newPage = RouteUtils.updatePages(path);
    if (newPage == null) {
      _pages.removeWhere(
        (element) => element.key != Key(RoutePath.home.name),
      );
    } else {
      _pages.add(newPage);
    }
    notifyListeners();
    return;
  }

  void resetToHome() {
    setNewRoutePath(RoutePath.home);
  }

  void addPage(RoutePath page) {
    setNewRoutePath(page);
  }
}
