import 'dart:async';

import 'package:admin_app/di/injection.dart';
import 'package:auth/auth.dart';
import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authRepository = getIt<AuthRepository>();
    if (authRepository.isAuthenticated) {
      resolver.next();
    } else {
      unawaited(router.push(const LoginRoute()));
    }
  }
}
