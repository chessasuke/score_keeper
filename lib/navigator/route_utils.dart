// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:score_keeper/screens/game_board.dart';

import '../screens/unknown_screen.dart';

enum RoutePath {
  home,
  gameBoard,
  unknown;

  String get segmentName => this == RoutePath.home ? '' : name;
  String get location => this == RoutePath.home ? '/' : '/$name';
}

class RouteUtils {
  static RoutePath parseUri(String? location) {
    if (location != null) {
      final uri = Uri.parse(location);
      late RoutePath result;
      if (uri.pathSegments.isEmpty) {
        result = RoutePath.home;
      } else if (uri.pathSegments.first == RoutePath.gameBoard.segmentName) {
        result = RoutePath.gameBoard;
      } else {
        result = RoutePath.unknown;
      }
      return result;
    } else {
      return RoutePath.unknown;
    }
  }

  static RouteInformation restoreRouteInformation(RoutePath path) {
    late RouteInformation result;
    switch (path) {
      case RoutePath.home:
        result = RouteInformation(location: RoutePath.home.location);
        break;
      case RoutePath.gameBoard:
        result = RouteInformation(location: RoutePath.gameBoard.location);
        break;
      case RoutePath.unknown:
        result = RouteInformation(location: RoutePath.unknown.location);
        break;
    }
    return result;
  }

  static Page? updatePages(RoutePath path) {
    late Page? newPage;
    switch (path) {
      case RoutePath.home:
        return null;
      case RoutePath.gameBoard:
        newPage = MaterialPage(
          child: const GameBoard(),
          key: UniqueKey(),
          name: RoutePath.gameBoard.location,
        );
        break;
      case RoutePath.unknown:
        newPage = MaterialPage(
          child: const UnknownScreen(),
          key: UniqueKey(),
          name: RoutePath.unknown.location,
        );
        break;
    }
    return newPage;
  }
}
