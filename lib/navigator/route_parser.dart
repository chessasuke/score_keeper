import 'package:flutter/material.dart';
import 'route_utils.dart';

class AppRouteInformationParser extends RouteInformationParser<RoutePath> {
  @override
  Future<RoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    return RouteUtils.parseUri(routeInformation.location);
  }

  @override
  RouteInformation restoreRouteInformation(RoutePath configuration) {
    return RouteUtils.restoreRouteInformation(configuration);
  }
}
