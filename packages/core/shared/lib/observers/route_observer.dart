import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AppRouteObserver extends AutoRouterObserver {
  @override
  void didPush(Route<dynamic>? route, Route<dynamic>? previousRoute) =>
      log('Route pushed: ${route?.settings.name ?? 'unknown'}');

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) => log(
      'Route replacement: ${newRoute?.settings.name ?? 'unknown'}, replaced: ${oldRoute?.settings.name ?? 'unknown'}',
    );

  @override
  void didRemove(Route<dynamic>? route, Route<dynamic>? previousRoute) =>
      log('Route removed: ${route?.settings.name ?? 'unknown'}');

  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) =>
      log('Route popped: ${route?.settings.name ?? 'unknown'}');
}
