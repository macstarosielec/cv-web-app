import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    //AutoRoute(page: HomeRoute.page, initial: true),
  ];
}
